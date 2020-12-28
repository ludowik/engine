Test6 = class()
Test6.runSetup = false

function Test6:init()
    -- you can accept and set parameters here
    self.title = "motors (hold on left or right of screen to move car)"
end

function Test6:draw()
    -- Codea does not automatically call this method
end

function Test6:setup()
    local ground = createGround()
    ground.friction = 1
    
    local car = physics.body(POLYGON, vec2(-50,10), vec2(-50,-10), vec2(50,-10), vec2(50,10), vec2(30,10),vec2(25,25),vec2(-25,25),vec2(-30,10))
    car.position = vector(WIDTH/2, 50)
    debugDraw:addBody(car)
    car.density = 2.0
    
    local piston = physics
    
    local leftPos = vec2(WIDTH/2 - 30, 40)
    local leftWheel = createCircle(leftPos.x, leftPos.y, 20) 
    leftWheel.friction = 1  
    self.leftJoint = physics.joint(REVOLUTE, car, leftWheel, leftWheel.position)
    self.leftJoint.maxMotorTorque = 10
    
    local rightPos = vec2(WIDTH/2 + 30, 40)
    local rightWheel = createCircle(rightPos.x, rightPos.y, 15)    
    rightWheel.friction = 1
    self.rightJoint = physics.joint(REVOLUTE, car, rightWheel, rightWheel.position)
    
    for y = 25,70,15 do
        createBox(WIDTH/2 + 150, y, 15,15)
    end
    
end

function Test6:cleanup()
    self.leftJoint = nil
    self.rightJoint = nil
end

function Test6:touched(touch)
    -- Codea does not automatically call this method
    if touch.state == BEGAN or touch.state == MOVING then
        self.leftJoint.enableMotor = true
        if touch.x > WIDTH/2 then
            self.leftJoint.motorSpeed = -1000
        else
            self.leftJoint.motorSpeed = 1000
        end
    elseif touch.state == ENDED then
        self.leftJoint.motorSpeed = 0
    end
end
