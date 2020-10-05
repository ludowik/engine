Test2 = class()
Test2.runSetup = false

function Test2:init()
    -- you can accept and set parameters here
    self.title = "basic joints"
end

function Test2:setup()
    createGround()
    
    local circle = createCircle(WIDTH/2, HEIGHT/2, 25)
    circle.type = STATIC
    
    local box = createBox(WIDTH/2, HEIGHT/2 - 75, 25, 150)
    
    local joint = physics.joint(REVOLUTE, circle, box, circle.position)
    debugDraw:addJoint(joint)
    
    local circle2 = createCircle(WIDTH/2, HEIGHT/2 - 125, 25)
    local distJoint = physics.joint(DISTANCE, box, circle2, box.position, circle2.position)
    debugDraw:addJoint(distJoint)
    
    local box2 = createBox(WIDTH/2 + 100, HEIGHT/2, 50, 50)
    local sliderJoint = physics.joint(PRISMATIC, circle, box2, box2.position, vec2(1,0))
    sliderJoint.enableLimit = true
    sliderJoint.upperLimit = 50
    debugDraw:addJoint(sliderJoint)
end

function Test2:draw()
    -- Codea does not automatically call this method
end

function Test2:touched(touch)
    -- Codea does not automatically call this method
end
