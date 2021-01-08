Test8 = class()
Test8.runSetup = false

function Test8:init()
    -- you can accept and set parameters here
    self.title = "collision engine"
end

function Test8:draw()
    -- Codea does not automatically call this method
    if self.box:testOverlap(self.circle) then
        self.title = "collision engine (overlapping = true)"
    else
        self.title = "collision engine (overlapping = false)"
    end
end

function Test8:setupTest()
    physics.pause()
    self.box = createBox(WIDTH/2, HEIGHT/2, 100, 25)
    self.circle = createCircle(WIDTH/2, HEIGHT/2, 25)
end

function Test8:cleanup()
    physics.resume()
    self.box = nil
    self.circle = nil
end

function Test8:touched(touch)
    -- Codea does not automatically call this method
    if touch.state == BEGAN or touch.state == MOVING then
        self.box.position = vec2(touch.x, touch.y)
    end
end
