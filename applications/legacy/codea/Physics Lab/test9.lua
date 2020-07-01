Test9 = class()
Test9.runSetup = false

function Test9:init()
    -- you can accept and set parameters here
    self.title = "edge chains & edges"
end

function Test9:draw()
    -- Codea does not automatically call this method
end

function Test9:setup()
    --createGround()
    
    local points = {}
    for i = 0,WIDTH,WIDTH/30 do
        table.insert(points, vec2(i,math.sin(i*4)*20+60))
    end

    local ground = physics.body(CHAIN, false, unpack(points))
    debugDraw:addBody(ground)
    
    local edge = physics.body(EDGE, vec2(WIDTH*0.75,0), vec2(WIDTH*0.75,250))
    debugDraw:addBody(edge)
    
    local chase = createBox(WIDTH/2, 150, 50, 50)
    local leftWheel = createCircle(chase.x - 15, chase.y - 25, 10)
    local rightWheel = createCircle(chase.x + 15, chase.y - 25, 10)
        
    self.leftJ = physics.joint(REVOLUTE, chase, leftWheel, leftWheel.position)
    self.rightJ = physics.joint(REVOLUTE, chase, rightWheel, rightWheel.position)
    
end

function Test9:cleanup()
    self.leftJ = nil
end

function Test9:touched(touch)
end
