supportedOrientations(LANDSCAPE_ANY)

-- Mandelbrot set explorer, by Dr. Phillip Alvelda
-- it uses a few tricks to speed up the set calcs

-- Setup all the variables we'll be using
function variableSetup()
    mColor=1
    Binary=2
    Grayscale=3

    RMode = mColor -- Default rendering mode. 
                  -- Can also be "Grayscale" or "Binary"

    tileNumber = 100 -- Image resolution. 
                     -- Try varying this between 50 to 700

    tilesize = WIDTH/tileNumber

    ManCalcStart = 0 -- Variables track time it takes to calc one line
    ManCalcEnd = 0
    ManCalcTime = 0
    LastTouchTime = -1 -- State to time preceeding touch for double tap
    gx,gy = 0
    MinRe = -2.0 -- Window borders in real coordinates
    MaxRe = 0.7
    MinIm = -1.35
    MaxIm = 1.35
    Re_factor = (MaxRe-MinRe)/(WIDTH -1) -- Scale factors 
                                         -- From real to window
                                        
    Im_factor = (MaxIm-MinIm)/(HEIGHT -1)

    MaxIterations = 255 -- Max iteration count for membership check
    UCounter = 0
    count = 1

    redArray={} -- Tables to store the color maps for the set rendering
    greenArray={}
    blueArray={}

    myImage = image(WIDTH,HEIGHT) -- The raster display image
end

-- Print the initial instructions, setup the color map
function setup() 
    setInstructionLimit(0)
    
    variableSetup()
    
    parameter.watch("ManCalcTime")
    parameter.watch("DeltaTime")
    
    parameter.integer("RMode",1, 3,1)
    parameter.integer("Resolution",50,700,200)
    
    print("This program plots an image of the Mandelbrot set using the image() class.\n")
    print("Tap anywhere in the window to zoom in, double-tap to zoom out.\n")
    print("ManCalcTime is the time it takes to calculate the set membership and escape values.\n")
    print("Parameter: RMode sets the type of color map the set is rendered with.\n")
    print("Parameter: Resolution sets the level of image detail.")
    print("Higher resolutions make prettier pictures at the expense of slower update.")
    
    InitColorMap()
    background(0, 0, 0, 255)
    --ManSetCalc()
end


function InitColorMap()
    for i=0,MaxIterations do
        if RMode == Grayscale then -- Grayscale
        
            redArray[i]=255-i*255/MaxIterations
            greenArray[i]=255-i*255/MaxIterations
            blueArray[i]=255-i*255/MaxIterations
            
        elseif RMode == mColor then 
            
            -- Color gradients designed to use their prime
            -- number mulltiples to create a range of varied 
            -- and uniqe color bands, even when MaxIterations
            -- gets very high.
            redArray[i]=(i*11) % 255
            greenArray[i] = (i*5) % 255
            blueArray[i] = (i * 7) % 255
            
        elseif RMode == Binary then 
            
            -- Alternating black and white
            if (i % 2) == 0 then
                redArray[i]=255
                greenArray[i]=255
                blueArray[i]=255  
            else 
                redArray[i]=0
                greenArray[i]=0
                blueArray[i]=0  
            end
        end         
    end    
end


function touched(touch)
    if touch.state == ENDED then 
        --only use the final touch event to scale image window  
        dre=MaxRe-MinRe
        dim=MaxIm-MinIm
        gx = MinRe + touch.x/WIDTH * dre
        gy = MinIm + (touch.y)/HEIGHT * dim
    
        TouchTime = os.clock()
        if TouchTime - LastTouchTime < 0.3 then 
            -- zoom out if double tap
            MinRe = gx -  dre * 1.33
            MaxRe = gx + dre * 1.33
            MinIm = gy - dim * 1.33
            MaxIm = gy + dim * 1.33
        else
            --set the zoom in factor and new window borders
            MinRe = gx -  dre / 3
            MaxRe = gx + dre / 3
            MinIm = gy - dim / 3
            MaxIm = gy + dim / 3
        end
        
        Re_factor = (MaxRe-MinRe)/(WIDTH - 1)
        Im_factor = (MaxIm-MinIm)/(HEIGHT - 1)
        
        LastTouchTime = TouchTime
        count=1   
    end
end

function ManSetCalc() 
    ManCalcStart= os.clock() 
    local y, x, n, isInside
    local imf=Im_factor*tilesize
    local ref=Re_factor*tilesize
    local iterations
    
    -- note each call to ManSetCalc() only updates 
    -- a single line of the image at y=count
    y = myImage.height - count
    c_im = MinIm + y*imf      
      
    for x = 1, tileNumber-1 do
        c_re = MinRe + x*ref
        --check to see if x,y are inside the main 
        --cardioid or period2 bulb
          
        --in which case they are in the set and 
        --no iterative check is necessary
          
        --results in a 5x speedup when zoomed out
        q=(c_re-0.25)*(c_re-0.25) + c_im*c_im
        
        if ( ((c_re+1)*(c_re+1) + c_im * c_im < 0.0625) or 
              (q*(q+(c_re-0.25))<0.25*c_im*c_im) ) then         
            myImage:set(x, y,
                redArray  [MaxIterations] / 255,
                greenArray[MaxIterations] / 255,
                blueArray [MaxIterations] / 255,
                1)
        else
            -- Iterate the Mandelbrot set function from the starting
            -- position on the complex plane to see if it stays 
            -- inside a radius less than 2 units from the origin.
            Z_re = c_re
            Z_im = c_im
            isInside = true
            
            for n=0, MaxIterations, 1 do
                Z_re2 = Z_re*Z_re
                Z_im2 = Z_im*Z_im
                iterations=n
                -- Note the radius limit is 4 here after a rewrite
                -- to avoid having a sqrt() in the inner loop.
                if Z_re2 + Z_im2 > 4 then
                    isInside = false   
                    break
                end
                Z_im = 2*Z_re*Z_im + c_im
                Z_re = Z_re2 - Z_im2 + c_re
            end
             
            -- Store the iteration result in the image buffer           
            myImage:set(x, y,
                redArray  [iterations] / 255,
                greenArray[iterations] / 255,
                blueArray [iterations] / 255,
                1) 
        end
    end 
    
    ManCalcEnd = os.clock()
    ManCalcTime = ManCalcEnd-ManCalcStart
end

function draw()
    background(black)
    
    smooth() -- noSmooth() if you like a blockier image
    
    -- If RMode iparamter changes reinitialize the colormap
    if RMode ~= LastRMode then 
        InitColorMap()
        LastRMode = RMode
    end
    
    -- If Resolution iparameter changes then reinitialize image buffer
    if Resolution ~= LastResolution then
        tileNumber=Resolution
        tilesize = WIDTH/tileNumber
        
        -- Redefine image buffer to new resolution
        myImage = image(tileNumber+1,tileNumber+1) 
        
        -- Reset rendering to top of image 
        -- to be sure count is within buffer bounds  
        count=1 
        LastResolution = Resolution
    end
    
    -- Render the image buffer
    sprite(myImage, WIDTH*0.5, HEIGHT*0.5, WIDTH, HEIGHT) 
    
    -- Calculate and store current line of image data
    ManSetCalc() 
    count = 1 + count % tileNumber
end