Test1 = class()
Test1.runSetup = false

function Test1:init()
    self.title = "basic bodies (tap to create)"
end

function Test1:setupTest()
    createGround()
    createBox(WIDTH/2, 100, 30, 30)
    createCircle(WIDTH/2 + 50, 110, 30)
    createRandPoly(WIDTH/2 + 150, 120)
end

function Test1:draw()
    -- Codea does not automatically call this method
end

function Test1:touched(touch)
    if touch.state == BEGAN then
        createRandPoly(touch.x, touch.y, 25, 25)
    end
end
