
--# Main
-- project "sphere" JMV38

local cam

function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(FULLSCREEN)

    COLOR = color(207, 207, 207, 255)
    fps = FPS()
    cam = CameraControl()
    tuto = Tutorial()
end

function draw()
    background(14, 14, 14, 255)
    rectMode(CORNER)
    rect(5,5,270,32)
    perspective(50, WIDTH/HEIGHT)    -- First arg is FOV, second is aspect
    cam:setCam()
    tuto:update()
    ortho()                          -- Restore orthographic projection
    viewMatrix(matrix())             -- Restore the view matrix to the identity
    tuto:draw()
    fps:draw()
end

function touched(touch)
    cam:touched(touch)
    tuto:touched(touch)
end

--# Sphere
Sphere = class()

function Sphere:init(input)
    -- spatial position of sphere
    self.cx = input.cx or 0
    self.cy = input.cy or 0
    self.cz = input.cz or 0
    -- angular position of sphere, defined by angles around x,y,z axis
    self.ax = 0
    self.ay = 0
    self.az = 0
    -- sphere radius and rotation
    self.radius = input.r
    self.tRot = input.rotTime1
    -- sphere rotation 2
    self.tRot2 = input.rotTime2
    self.cx2 = input.cx2 or 0   -- center of rotation 2
    self.cy2 = input.cy2 or 0
    self.cz2 = input.cz2 or 0
    self.ax2 = input.ax2 or 0   -- axis of rotation 2
    self.ay2 = input.ay2 or 1
    self.az2 = input.az2 or 0
    -- mesh definition
    self.nx = input.nx    -- number of triangles in x
    self.ny = input.ny    -- and in y
    self.c1 = input.c1    -- 2 color() objects, to see the triangles
    self.c2 = input.c2
    self.optimized = input.meshOptimize    -- boolean
    -- sphere decoration
    self.url = input.url    -- texture as a url (text)
    self.hflip = input.hflip    -- to flip image horizontally
    if input.lightDir then
        self.lightDir = input.lightDir:normalize()   -- a vec3 pointing to the sun
    end
    self.shadowRatio = input.shadowRatio or 1.05   -- close to 1.05

    -- create mesh and colors
    local vertices,colors,tc = {},{},{}
    if self.optimized then
        vertices,colors,tc = self:optimMesh({ nx=self.nx, ny=self.ny, c1=self.c1, c2=self.c2 })
    else
        vertices,colors,tc = self:simpleMesh({ nx=self.nx, ny=self.ny, c1=self.c1, c2=self.c2 })
    end

    -- if a radius is given, warp to a sphere
    if self.radius then
        vertices = self:warpVertices({
                verts=vertices,
                xangle=180,
                yangle=180
            })
    end

    -- create the mesh itself
    self.ms = mesh()
    self.ms.vertices = vertices
    self.ms.colors = colors

    -- add the texture from internet
    if self.url then
        self:load( self.url ) -- this will not be instantaneous!
    end
    self.ms.texCoords = tc

    -- add some shadows
    if self.lightDir then self:shadows() end

end

function Sphere:shadows()
    self.ms2 = mesh()
    local dir = self.lightDir
    local vertices2,colors2 = {},{}
    local d = 0
    for i,v in ipairs(self.ms.vertices) do
        vertices2[i] = v
        d = v:dot(dir)
        d = 128 - 4*(d-0.1)*128
        if d<0 then d=0 end
        if d>255 then d=255 end
        colors2[i] = color(0,0,0,d)
    end
    self.ms2.vertices = vertices2
    self.ms2.colors = colors2
end

function Sphere:simpleMesh(input)
    -- create the mesh tables
    local vertices = {}
    local colors = {}
    local texCoords = {}
    --local w,h = img.width/10, img.height/10
    local k = 0
    local s = 1
    -- create a rectangular set of triangles
    local x,y
    local nx,ny = input.nx,input.ny
    local opt = input.opt
    local sx, sy = 1/ny, 1/ny
    local color1 = input.c1
    local color2 = input.c2
    local center = vec3(1,0.5,0)
    for y=0,ny-1 do
        for x=0,nx-1 do
            vertices[k+1] = vec3( sx*x    , sy*y    , 1) - center
            vertices[k+2] = vec3( sx*(x+1), sy*y    , 1) - center
            vertices[k+3] = vec3( sx*(x+1), sy*(y+1), 1) - center
            vertices[k+4] = vec3( sx*x    , sy*y    , 1) - center
            vertices[k+5] = vec3( sx*x    , sy*(y+1), 1) - center
            vertices[k+6] = vec3( sx*(x+1), sy*(y+1), 1) - center
            colors[k+1] = color1
            colors[k+2] = color1
            colors[k+3] = color1
            colors[k+4] = color2
            colors[k+5] = color2
            colors[k+6] = color2
            k = k + 6
        end
    end
    return vertices,colors
end

function Sphere:optimMesh(input)
    -- create the mesh tables
    local vertices = {}
    local colors = {}
    local texCoords = {}
    --local w,h = img.width/10, img.height/10
    local k = 0
    local s = 1
    -- create a set of triangles with approx constant surface on a sphere
    local x,y
    local x1,x2 = {},{}
    local i1,i2 = 0,0
    local nx,ny = input.nx,input.ny
    local sx, sy = nx/ny, 1/ny
    local color1 = input.c1
    local color2 = input.c2
    local center = vec3(1,0.5,0)
    local m1,m2,c
    for y=0,ny-1 do -- for each horizontal band
        -- number of points on each side of the band
        local nx1 = math.floor( nx * math.abs(math.cos(    ( y*sy-0.5)*2 * math.pi/2)) )
        if nx1<6 then nx1=6 end
        local nx2 = math.floor( nx * math.abs(math.cos( ((y+1)*sy-0.5)*2 * math.pi/2)) )
        if nx2<6 then nx2=6 end
        -- points on each side of the band
        x1,x2 = {},{}
        for i1 = 1,nx1 do x1[i1] = (i1-1)/(nx1-1)*sx end
        for i2 = 1,nx2 do x2[i2] = (i2-1)/(nx2-1)*sx end
        x1[nx1+1] = x1[nx1] -- just a trick to manage last triangle without thinking
        x2[nx2+1] = x2[nx2]
        -- start on the left
        local i1,i2 = 1,1
        c = 1    -- starting color
        local continue = true
        local n,nMax = 0,0
        nMax = nx*2+1
        while continue do
            -- center of the 2 current segments
            m1 = (x1[i1]+x1[i1+1])/2
            m2 = (x2[i2]+x2[i2+1])/2
            if m1<=m2 then -- the less advanced base makes the triangle
                vertices[k+1] = vec3(   x1[i1], sy*y    , 1)  - center
                vertices[k+2] = vec3( x1[i1+1], sy*y    , 1)  - center
                vertices[k+3] = vec3(   x2[i2], sy*(y+1), 1)  - center
                texCoords[k+1] = vec2(   x1[i1]/2, sy*y    )
                texCoords[k+2] = vec2( x1[i1+1]/2, sy*y    )
                texCoords[k+3] = vec2(   x2[i2]/2, sy*(y+1))
                if i1<nx1 then i1 = i1 +1 end
            else
                vertices[k+1] = vec3(   x1[i1], sy*y    , 1) - center
                vertices[k+2] = vec3(   x2[i2], sy*(y+1), 1) - center
                vertices[k+3] = vec3( x2[i2+1], sy*(y+1), 1) - center
                texCoords[k+1] = vec2(   x1[i1]/2, sy*y    )
                texCoords[k+2] = vec2(   x2[i2]/2, sy*(y+1))
                texCoords[k+3] = vec2( x2[i2+1]/2, sy*(y+1))
                if i2<nx2 then i2 = i2 +1 end
            end

            if self.hflip then
                texCoords[k+1].y = 1-texCoords[k+1].y
                texCoords[k+2].y = 1-texCoords[k+2].y
                texCoords[k+3].y = 1-texCoords[k+3].y
            end

            -- set the triangle color
            if c==1 then col=color1 else col=color2 end
            colors[k+1] = col
            colors[k+2] = col
            colors[k+3] = col
            if c==1 then c=2 else c=1 end
            if i1==nx1 and i2==nx2 then continue=false end
            -- increment index for next triangle
            k = k + 3
            n = n + 1
            if n>nMax then continue=false  end -- just in case of infinite loop
        end
    end
    return vertices,colors,texCoords
end

function Sphere:warpVertices(input)
    -- move each vector to its position on sphere
    local verts = input.verts
    local xangle = input.xangle
    local yangle = input.yangle
    local s = self.radius
--    local m = matrix(0,0,0,0, 0,0,0,0, 1,0,0,0, 0,0,0,0) -- empty matrix
    local m = matrix()
    local vx,vy,vz,vm
    for i,v in ipairs(verts) do
        vx,vy = v[1], v[2]
        vm = m:rotate(xangle*vy,1,0,0):rotate(yangle*vx,0,1,0)
        vx,vy,vz = vm[1],vm[5],vm[9]
        verts[i] = vec3(vx,vy,vz)
    end
    return verts
end

function Sphere:load(url)
    map = nil
    http.request(url,
        function(theImage, status, head)
            self:setTexture(theImage, status, head)
        end
    )
end

function Sphere:setTexture(theImage, status, head)
    self.ms.texture = theImage
end

function Sphere:move()
    -- self auto rotation
    if self.tRot then
        local ay
        ay = self.ay + 360 * DeltaTime / self.tRot
        if ay >  180 then ay = ay - 360 end
        if ay < -180 then ay = ay + 360 end
        self.ay = ay
    end
    -- rotation around an axis
    if self.tRot2 then
        local phiAxis = vec3(self.ax2,self.ay2,self.az2):normalize()
        local v1 =  vec3(self.cx,self.cy,self.cz) - vec3(self.cx2,self.cy2,self.cz2)
        m = matrix( v1.x,0,0,0,
            v1.y,0,0,0,
            v1.z,0,0,0,
            0,   0,0,0 )
        local phi =  360 * DeltaTime / self.tRot2
        m = m:rotate(phi,phiAxis[1],phiAxis[2],phiAxis[3])
        local x,y,z
        x = m[1]
        y = m[5]
        z = m[9]
        v1 = vec3(self.cx2,self.cy2,self.cz2) + vec3(x,y,z)
        self.cx,self.cy,self.cz = v1.x, v1.y, v1.z
    end
end

function Sphere:draw()
    local s
    pushMatrix()
    pushStyle()
    self:move()
    translate(self.cx,self.cy,self.cz)
    rotate(self.az,0,0,1)
    rotate(self.ax,1,0,0)
    rotate(self.ay,0,1,0)
    if self.radius then s = self.radius else s = 100 end
    scale(s,s,s)
    self.ms:draw()

    if self.lightDir then
        rotate(-self.ay,0,1,0)
        rotate(-self.ax,1,0,0)
        rotate(-self.az,0,0,1)
        local s2 = self.shadowRatio
        scale(s2,s2,s2)
        self.ms2:draw()
    end
    popStyle()
    popMatrix()
end

--# CameraControl
CameraControl = class()

function CameraControl:init()
    -- this is for touch control
    self.touches = {}
    self.x0 = 0
    self.y0 = 0
    self.d0 = 100
    -- this is the camera position
    self.camX, self.camY, self.camZ = 0, 200, 500
    -- this is the point the camera is looking to
    self.tx ,self.ty ,self.tz  = 0,0,0
    -- vertical axis of the camera
    self.vx, self.vy, self.vz = 0,1,0
    -- distance limit from 0,0,0
    self.maxDist = 1000
    -- apply these settings
    self:setCam()
end

function CameraControl:touched(touch)
    if touch.state == ENDED then
        self.touches[touch.id] = nil
    else
        self.touches[touch.id] = touch
    end
    local n = 0
    for i,v in pairs(self.touches) do n = n + 1 end
    -- if exactly one touch then move
    if n==1 then self:move(touch) end
    -- if exactly 2 touches then zoom
    if n==2 then self:zoom() end
end

function CameraControl:zoom()
    local t = {}
    local n = 1
    for i,touch in pairs(self.touches) do
        t[n] = touch
        n = n + 1
    end
    local x1,y1,x2,y2,delta,d1
    if t[1].state == BEGAN or t[2].state == BEGAN then
        -- memorize the starting point of the touch
        x1,y1,x2,y2 = t[1].x, t[1].y, t[2].x, t[2].y
        delta = vec2(x2-x1,y2-y1):len() +100
        self.d0 = delta
    elseif t[1].state == MOVING or t[2].state == MOVING then
        x1,y1,x2,y2 = t[1].x, t[1].y, t[2].x, t[2].y
        delta = vec2(x2-x1,y2-y1):len() +100
        -- to prvent the camera to go too far
        if self.d0/delta > 1 then
            if vec3(self.camX,self.camY,self.camZ):len()>self.maxDist then delta = self.d0 end
        end
        self.camX = self.d0/delta * self.camX
        self.camY = self.d0/delta * self.camY
        self.camZ = self.d0/delta * self.camZ
        self.d0 = delta
        --print(self.camZ)
    end
end

function CameraControl:move(touch)
    local dx,dy,x,y,z,l0,l1
    local theta,phi,m,xphi,yphi,zphi,phiAxis,cosAngle
    local state = touch.state
    if state == BEGAN then
        -- memorize the starting point of the touch
        self.x0 = touch.x
        self.y0 = touch.y
    elseif state == MOVING then
        -- now the finger has move of how much?
        dx = touch.x - self.x0
        dy = touch.y - self.y0
        -- convert this into angles
        -- get camera position to the center...
        x,y,z = self.camX,self.camY,self.camZ
        local pos = vec3(x,y,z)
        l0 = pos:len()    -- ... to compute the distance to center
        pos = pos / l0
        -- convert this into angles (approx: angle ~tg(angle))
        local s = 180/math.pi -- coef to covert radians into degrees
        theta = dx/l0*s -- the angle around the y axis
        phi =  -dy/l0*s -- the angle around the horizontal axis
        -- the transparency seems to work based on z-axis only: so theta should be limited
        cosAngle = vec3(0,0,1):dot(pos)
        -- there is a pb when close y axis, so lock the phi to avoid this case
        cosAngle = vec3(0,1,0):dot(pos)
        if cosAngle > 0.95 and phi > 0 then phi=0 end
        if cosAngle < -0.95 and phi < 0 then phi=0 end
        -- the phis axis depends on the orientation but is easy to compute with cross product
        phiAxis = vec3(0,1,0):cross(pos)
        -- now, finally, let's compute the new camera position
        m = matrix( x,0,0,0, y,0,0,0, z,0,0,0, 0,0,0,0)
        m = m:rotate(theta,0,1,0)
        m = m:rotate(phi,phiAxis[1],phiAxis[2],phiAxis[3])
        x , y , z = m[1], m[5], m[9]
        -- save this new position of the camera
        self.camX,self.camY,self.camZ = x,y,z
        -- use this point as the start point for next move
        self.x0 = touch.x
        self.y0 = touch.y
    elseif state == ENDED then
    end
end

function CameraControl:setCam()
    camera( self.camX,self.camY,self.camZ,
        self.tx ,self.ty ,self.tz,
        self.vx, self.vy, self.vz )
end

--# FPS
FPS = class()

function FPS:init()
    self.val = 60
end

function FPS:draw()
    -- update FPS value with some smoothing
    self.val = self.val*0.9+ 1/(DeltaTime)*0.1
    -- write the FPS on the screen
    fill(COLOR)
    fontSize(30)
    font("AmericanTypewriter-Bold")
    rectMode(CENTER)
    text(math.floor(self.val).." fps",50,HEIGHT-25)
end

--# Tutorial
Tutorial = class()

function Tutorial:init()
    -- these var are to keep track of various animations
    self.step = 0
    self.stepMax = 11
    self.ready = false

    -- buttons 'next and 'prev'
    fill(0, 0, 0, 255)
    fontSize(28)
    font("AmericanTypewriter-Bold")

    self.nextButton = image(90,50)
    setContext(self.nextButton)
    background(COLOR)
    text("next",45,25)
    setContext()

    fontSize(27)
    font("AmericanTypewriter-Bold")
    self.prevButton = image(90,50)
    setContext(self.prevButton)
    background(COLOR)
    text("prev",45,25)
    setContext()

    self.lines = 0
    self.line = {}
end

function Tutorial:print(str)
    self.lines = self.lines + 1
    self.line[ self.lines ] = str
end

function Tutorial:clearPrint()
    self.lines = 0
end

function Tutorial:step0()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 0  ###########")
        self:print("")
        self:print("This is a 'hands-on' tutorial about drawing spheres")
        self:print("On top left you can see the refreshing frequency (<60 frames per second)")
        self:print("to go to next example press 'next', to go back press 'prev'")
        self.ready = true
    else end
end

function Tutorial:step1()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 1  ###########")
        self:print("")
        self:print("First you can start by drawing a flat mesh of triangles")

        local color1 = color(255, 0, 0, 128)
        local color2 = color(255, 255, 0, 128)
        planet1 = Sphere({  nx = 40, ny = 20   ,  -- mesh definition
                c1 = color1 , c2 = color2 ,   -- mesh colors
                cx=0, cy=-20, cz=0           -- sphere center
            })
        self.ready = true
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 0, 0, 300
    else
        planet1:draw()
    end
end

function Tutorial:step2()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 2  ###########")
        self:print("")
        self:print("Then you can warp the vertices of this mesh to a sphere shape")
        self:print("The triangles are partly transparent because the colors of the vectors were set that way")
        self:print("you can rotate (1 finger) and zoom (2 fingers) the object")
        local color1 = color(255, 0, 0, 128)
        local color2 = color(255, 255, 0, 128)

        planet1 = Sphere({
                nx = 40, ny = 20 ,            -- mesh definition
                c1 = color1 , c2 = color2 ,   -- mesh colors
                cx=0, cy=-50, cz=0,          -- sphere center
                r = 100               -- radius of the sphere
            })
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 0, 200, 300
        self.ready = true
    else
        planet1:draw()
    end
end

function Tutorial:step3()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 3  ###########")
        self:print("")
        self:print("you can make the sphere opaque by setting the color opaque")
        self:print("and you can make it rotate around its axis")
        self:print("the frame rate is still excellent: close to 60 fps")
        self:print("the next screen will take several seconds to appear... be patient!")
        local color1 = color(255, 0, 0, 255)
        local color2 = color(255, 255, 0, 255)
        planet1 = Sphere({
                nx = 40, ny = 20 ,    -- mesh definition
                c1 = color1 , c2 = color2 ,   -- mesh colors
                cx=0, cy=-50, cz=0,          -- sphere center
                r = 100    ,           -- radius of the sphere
                rotTime1 = 10    -- rotation time in s
            })
        self.ready = true
    else planet1:draw() end
end

function Tutorial:step4()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 4  ###########")
        self:print("")
        self:print("we can multiply the number of vertices from 4800 (40x20x6) up to 43200 (120x60x6)")
        self:print("the setup time is long, but the fps still excellent")
        self:print("You can notice that the triangle sizes are not optimized for a sphere: ")
        self:print("the top ones are really too small compared to middle ones")
        local color1 = color(255, 0, 0, 255)
        local color2 = color(255, 255, 0, 255)
        planet1 = Sphere({
                nx = 120, ny = 60 ,    -- mesh definition
                c1 = color1 , c2 = color2 ,   -- mesh colors
                cx=0, cy=-50, cz=0,          -- sphere center
                r = 100    ,           -- radius of the sphere
                rotTime1 = 10 ,   -- rotation time in s
            })
        self.ready = true
    else planet1:draw() end
end

function Tutorial:step5()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 5  ###########")
        self:print("")
        self:print("Here the triangles have been optimized to be approximately equal size")
        self:print("The difficulty is to find which vectors to assemble in triangles, but it is solved now...")
        local color1 = color(255, 0, 0, 255)
        local color2 = color(255, 255, 0, 255)
        planet1 = Sphere({
                nx = 40, ny = 20 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color1 , c2 = color2 ,    -- mesh colors
                cx=0, cy=-50, cz=0  ,         -- sphere center
                r = 100      ,         -- radius of the sphere
                rotTime1 = 10 ,   -- rotation time in s
            })
        self.ready = true
        --     change camera position
        -- cam.camX, cam.camY, cam.camZ = 0, 0, 300
    else planet1:draw() end
end

function Tutorial:step6()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 6  ###########")
        self:print("")
        self:print("But it means that when back on a flat surface, the triangles are not equal.")
        local color1 = color(255, 0, 0, 255)
        local color2 = color(255, 255, 0, 255)
        planet1 = Sphere({
                nx = 40, ny = 20 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color1 , c2 = color2 ,    -- mesh colors
                cx=0, cy=-25, cz=0  ,         -- sphere center
            })
        self.ready = true
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 0, 0, 300
    else planet1:draw() end
end

function Tutorial:step7()
    if self.ready == false then
        url1 = 'https://www.evl.uic.edu/pape/data/Earth/2048/PathfinderMap.jpg'
        url1 = 'https://www.cleverfiles.com/howto/wp-content/uploads/2016/08/mini.jpg'
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 7  ###########")
        self:print("")
        self:print("we may want to draw an image on the sphere instead of just colors")
        self:print("all we need is to load an image, and 1/ define it as the 'texture' to use with the mesh ")
        self:print("and 2/ define where each vector lays on this image (in [0-1] relative coordinates)")
        self:print("The image used here is from "..url1)
        self:print("(it will take several seconds to load)The image should not be too big for ipad limits (2048x2048 max)")
        self:print("the image is right-left inverted, this is to be correct on the sphere, I dont know the reason")
        local color1 = color(255, 255, 255, 255)
        local color2 = color(127, 127, 127, 255)
        planet1 = Sphere({
                nx = 40, ny = 20 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color1 , c2 = color2 ,    -- mesh colors
                cx=0, cy=-25, cz=0  ,         -- sphere center
                url = url1,        -- texture image url
                hflip = true,    -- to flip image horozontally
            })
        self.ready = true
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 0, 0, 300
    else planet1:draw() end
end

function Tutorial:step8()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 8  ###########")
        self:print("")
        self:print("To turn this map into a planet, we must:")
        self:print("1/ set the mesh vertice colors to: color(255, 255, 255, 255)")
        self:print("2/ warp the vertices to a sphere")
        self:print("you can zoom to see the detail (this is done very simply via the 'camera' settings of CODEA)")
        self:print("This is a nice earth, but there is not the shadow of the sun...")

        local color1 = color(255, 255, 255, 255)
        planet1 = Sphere({
                nx = 40, ny = 20 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color1 , c2 = color1 ,    -- mesh colors
                cx=0, cy=-50, cz=0  ,         -- sphere center
                r = 100      ,         -- radius of the sphere
                rotTime1 = 30 ,   -- rotation time in s
                url = url1,        -- texture image url
                hflip = true,    -- to flip image horozontally
            })
        self.ready = true
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 0, 200, 300
    else planet1:draw() end
end

function Tutorial:step9()
    url1 = 'https://www.evl.uic.edu/pape/data/Earth/2048/PathfinderMap.jpg'
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 9  ###########")
        self:print("")
        self:print("To add the sun, we simply add shadows on the planet. But the shadows should not turn.")
        self:print("So we will built a 2nd sphere, black and transparent as it is oriented to the light source")
        self:print("This sphere has a larger radius than the planet, to be adjusted to avoid rendering problems")
        self:print("To have a smoother shadow, i have increased the number of tirangles by 4 => I lose a little bit in fps")
        local color1 = color(255, 255, 255, 255)
        planet1 = Sphere({
                nx = 80, ny = 40 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color1 , c2 = color1 ,    -- mesh colors
                cx=0, cy=-50, cz=0  ,         -- sphere center
                r = 100      ,         -- radius of the sphere
                rotTime1 = 30 ,   -- rotation time in s
                url = url1,        -- texture image url
                hflip = true,    -- to flip image horozontally
                lightDir = vec3(1,0,0),   -- a vec3 pointing to the sun
                shadowRatio = 1.05,    -- the ratio of radius of shadow sphere to sphere
            })
        self.ready = true
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 200, 100, 300
    else planet1:draw() end
end

function Tutorial:step10()
    url1 = 'http://www.evl.uic.edu/pape/data/Earth/2048/PathfinderMap.jpg'
    url2 = "http://web.cortland.edu/flteach/civ/davidweb/images/moonb.jpg"
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 10  ###########")
        self:print("")
        self:print("Finally here is a moon to turn around our earth (too fast and too close...)")

        local color1 = color(255, 255, 255, 255)
        planet1 = Sphere({
                nx = 80, ny = 40 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color1 , c2 = color1 ,    -- mesh colors
                cx=0, cy=-50, cz=0  ,         -- sphere center
                r = 100      ,         -- radius of the sphere
                rotTime1 = 30 ,   -- rotation time in s
                url = url1,        -- texture image url
                hflip = true,    -- to flip image horozontally
                lightDir = vec3(1,0,0),   -- a vec3 pointing to the sun
                shadowRatio = 1.02,    -- the ratio of radius of shadow sphere to sphere
            })
        local color2 = color(223, 211, 138, 255)
        moon1 = Sphere({
                nx = 60, ny = 30 ,            -- mesh definition
                meshOptimize = true,           -- optimize mesh for sphere
                c1 = color2 , c2 = color2 ,    -- mesh colors
                cx=150, cy=0, cz=0  ,         -- sphere center
                r = 20      ,         -- radius of the sphere
                rotTime1 = 30 ,   -- rotation time in s
                url = url2,
                lightDir = vec3(1,0,0),   -- a vec3 pointing to the sun
                shadowRatio = 1.02,    -- the ratio of radius of shadow sphere to sphere
                rotTime2 = 30,
                cx2=0, cy2=0, cz2=0,    -- center of rotation 2
                ax2=0, ay2=1, az2=0,    -- rotation axis
            })
        self.ready = true
        --     change camera position
        cam.camX, cam.camY, cam.camZ = 200, 100, 300
    else planet1:draw() moon1:draw() end
end

function Tutorial:step11()
    if self.ready == false then
        self:clearPrint()
        self:print("")
        self:print("###########  STEP 11  ###########")
        self:print("")
        self:print("This tutorial is over. Now it is you turn to play with the code...")
        self:print("Feel free to improve my functions, i have the feeling there are a couple bugs left.")
        self:print("And thank you to Simeon and the great team of Two Lives Left for the magic of CODEA!")
        self:print("")
        self:print("This tutorial was brought to you by JMV38")
    end
end

function Tutorial:update()
    if self.step == 0 then self:step0() end
    if self.step == 1 then self:step1() end
    if self.step == 2 then self:step2() end
    if self.step == 3 then self:step3() end
    if self.step == 4 then self:step4() end
    if self.step == 5 then self:step5() end
    if self.step == 6 then self:step6() end
    if self.step == 7 then self:step7() end
    if self.step == 8 then self:step8() end
    if self.step == 9 then self:step9() end
    if self.step == 10 then self:step10() end
    if self.step == 11 then self:step11() end
end

function Tutorial:draw()
    -- buttons 'next and 'prev'
    fontSize(28)
    font("AmericanTypewriter-Bold")
    rectMode(CENTER)
    fill(COLOR)
    rect(WIDTH-50,HEIGHT-25,90,50)
    rect(WIDTH-150,HEIGHT-25,90,50)
    fill(0, 0, 0, 255)
    text("next",WIDTH-50,HEIGHT-25)
    text("prev",WIDTH-150,HEIGHT-25)
    -- text of tutorial
    fill(COLOR)
    fontSize(20)
    font("Arial")
    if self.lines>0 then
        for i=1,self.lines do
            text(self.line[i],WIDTH/2,HEIGHT-50-i*20)
        end
    end
end

function Tutorial:touched(touch)
    local dx,dy,step
    local ds = 0
    if touch.state == BEGAN then
        dx = math.abs(touch.x-(WIDTH-50))
        dy = math.abs(touch.y-(HEIGHT-25))
        if dx<50 and dy<50 then ds = 1 end
        dx = math.abs(touch.x-(WIDTH-150))
        dy = math.abs(touch.y-(HEIGHT-25))
        if dx<50 and dy<50 then ds = -1 end
        if ds~=0 then
            step = self.step + ds
            if  step < 0 then step = 0
            elseif step > self.stepMax then step = self.stepMax
            else     self.ready = false     self.step = step  end
        end
    end
end
