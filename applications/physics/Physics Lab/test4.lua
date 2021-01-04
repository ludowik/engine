Test4 = class()
Test4.runSetup = false

function Test4:init()
    -- you can accept and set parameters here
    self.title = "sensors"
end

function Test4:setupTest()
    createGround()
    self.sensor = createCircle(WIDTH/2,HEIGHT/2, 25)
    self.sensor.sensor = true
    self.sensor.type = STATIC

    createBox(WIDTH/2, HEIGHT/2 + 100, 20, 20)
end

function Test4:draw()
    -- Codea does not automatically call this method
end

function Test4:touched(touch)
    -- Codea does not automatically call this method
end

function Test4:collide(contact)
    if contact.bodyA.sensor or contact.bodyB.sensor then
        if contact.state == BEGAN then
            print("Sensor BEGAN")
        elseif contact.state == MOVING then
            print("Sensor MOVING")
        else
            print("Sensor ENDED")
        end
    end
end
