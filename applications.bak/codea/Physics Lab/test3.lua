Test3 = class()
Test3.runSetup = false

function Test3:init()
    self.title = "gravity scale"
end

function Test3:setup()
    createGround()
    local circle1 = createCircle(50, HEIGHT/2, 25)
    
    local circle2 = createCircle(150, HEIGHT/2, 25)
    circle2.gravityScale = 0.5
    
    local circle3 = createCircle(250, HEIGHT/2, 25)
    circle3.gravityScale = 0.25
end

function Test3:draw()
end

function Test3:touched(touch)
    -- Codea does not automatically call this method
end
