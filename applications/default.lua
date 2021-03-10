function setup()
    local pixelSize = 8

    img = image(
        floor(W/pixelSize),
        floor(H/pixelSize))

    img2 = image(
        floor(W/pixelSize),
        floor(H/pixelSize))

    setContext(img)
    background(0, 0, 0, 1)

    local pixels = img:getPixels()
    local pixels2 = img2:getPixels()

    local i = 0
    for y=0,img.height-1 do
        for x=0,img.width-1 do
            if x == 0 then
                pixels[i] = random(255)
                --pixels[i+1] = random(255)
                --pixels[i+2] = random(255)
            else
            end

            pixels[i+3] = 255

            i = i + 4
        end
    end

    img:update(true)

    setContext(img2)
    spriteMode(CORNER)
    sprite(img)
    img2:update(true)

    config.interpolate = false
    parameter.boolean('config.interpolate', false)
    
    parameter.watch('total')
end

function update()
    local pixels = img:getPixels()

    setContext(img2)
    spriteMode(CORNER)
    sprite(img)
    setContext()

    local pixels2 = img2:getPixels()    
    
    local i, r, d = 0, 0
    for y=0,img.height-1 do
        for x=0,img.width-1 do
            local a, b = i,(i+4)%(img.width*img.height*4)

            r = pixels[a]

            d = randomInt(0, r)
            d = min(255, pixels[b]+d) - pixels[b]

            pixels2[a] = pixels2[a] - d
            pixels2[b] = pixels2[b] + d

            i = i + 4
        end
    end
    
    i, total = 0, 0
    for y=0,img.height-1 do
        for x=0,img.width-1 do
            total = total + pixels2[i]
            i = i + 4
        end
    end
    

    img2:update(true)

    img, img2 = img2, img
end

function draw()
    scale(W/img.width)

    spriteMode(CORNER)
    sprite(img)
end
