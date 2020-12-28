
--# Main
-- Screensaver

-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    
    parameter.watch("math.floor(fps)")
    initColors()
    boxes = {}
    counter = 0
    boxGrav = 1
end

-- This function gets called once every frame
function draw()
    background(212, 228, 229, 255)
    fps = 1/DeltaTime

    local x = -math.random(-350,350)
    local y = -math.random(100,350)
    local width = math.random(50,100)
    local height = math.random(25,50)

    translate(WIDTH/2,HEIGHT/2)
    counter = counter + 1
    if counter == 60 then counter = 0
        for i = 1, 2 do
            if i == 1 then box = makeBox(x,y,width,height) end
            if i == 2 then box = makeBox(x,-y,width,height) end
            box.gravityScale = boxGrav
            box.restitution = 0.5
            boxes[#boxes+1] = Platform(box,x,y,width,height)
            boxGrav = -boxGrav
            rotate(180)
        end
    end

    for i, b in pairs(boxes) do
        b:draw()
    end

end

function makeBox(x,y,w,h)
    local body = physics.body(POLYGON,vec2(-w/2,h/2),vec2(-w/2,-h/2),vec2(w/2,-h/2),vec2(w/2,h/2))
    body.position = vec2(-x,-y)
    return body
end

function initColors()
    colorTab = {
    color(34, 155, 153, 255),
    color(180, 94, 30, 255),
    color(51, 63, 84, 255)
    }
end


--# Platform
Platform = class()

function Platform:init(b,x,y,w,h)
    -- you can accept and set parameters here
    self.body = b
    self.width = w
    self.height = h
    self.colr = colorTab[math.random(#colorTab)]
end

function Platform:draw()
    -- Codea does not automatically call this method
    fill(self.colr)

    local x = self.body.x
    local y = self.body.y
    local w = self.width
    local h = self.height

    pushMatrix()
    translate(x,y)
    rotate(self.body.angle)
    
    rectMode(CORNER)
    rect(-w/2,-h/2,w,h)
    
    popMatrix()
end

function Platform:touched(touch)
    -- Codea does not automatically call this method
end

