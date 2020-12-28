supportedOrientations(LANDSCAPE_ANY)

-- Use this function to perform your initial setup
function setup()    
    lineCapMode(ROUND)
    debugDraw = PhysicsDebugDraw()
    
    -- test classes
    -- to add your own, make sure to define setup() and cleanup() 
    -- in addition to draw() and touched()
    tests = {Test1(), Test2(), Test3(), Test4(), Test5(), Test6(), Test7(), Test8(), Test9()}
    
    parameter.integer("TestNumber", 1, #tests)

    parameter.boolean("UseAccelerometer")

    currentTestIndex = 1
    currentTest = nil
    setTest(currentTestIndex)
    
    defaultGravity = physics.gravity()
end

function setTest(t)
    if currentTest then
        if currentTest.cleanup then
            currentTest:cleanup()
        end
        cleanup()
    end
    
    currentTestIndex = t
    currentTest = tests[t]
    currentTest:setup()
end

function nextTest()
    local t = currentTestIndex + 1
    if t > #tests then
        t = 1
    end
    setTest(t)
end

function createCircle(x,y,r)
    local circle = physics.body(CIRCLE, r)
    -- enable smooth motion
    circle.interpolate = true
    circle.x = x
    circle.y = y
    circle.restitution = 0.25
    circle.sleepingAllowed = false
    debugDraw:addBody(circle)
    return circle
end

function createBox(x,y,w,h)
    -- polygons are defined by a series of points in counter-clockwise order
    local box = physics.body(POLYGON, vec2(-w/2,h/2), vec2(-w/2,-h/2), vec2(w/2,-h/2), vec2(w/2,h/2))
    box.interpolate = true
    box.x = x
    box.y = y
    box.restitutions = 0.25
    box.sleepingAllowed = false
    debugDraw:addBody(box)
    return box
end

function createGround()
    local ground = physics.body(POLYGON, vec2(0,20), vec2(0,0), vec2(WIDTH,0), vec2(WIDTH,20))
    ground.type = STATIC
    debugDraw:addBody(ground)
    return ground
end

function createRandPoly(x,y)
    local count = math.random(3, 8)
    local r = math.random(25, 75)
    local a = 0
    local d = 2 * math.pi / count
    local points = {}
    
    assert(count >= 3)
    
    for i = 1,count do
        local v = vec2(r,0):rotate(a) + vec2(math.random(-10,10), math.random(-10,10))
        a = a + d
        table.insert(points, v)
    end
    
    local poly = physics.body(POLYGON, unpack(points))
    poly.x = x
    poly.y = y
    poly.sleepingAllowed = false
    poly.restitution = 0.25
    debugDraw:addBody(poly)
    return poly
end

function cleanup()
    output.clear()
    debugDraw:clear()
end

-- This function gets called once every frame
function draw()
    -- This sets the background color to black
    background(0, 0, 0)
    
    if TestNumber ~= currentTestIndex then
        setTest(TestNumber)
    end
    
    currentTest:draw()
    debugDraw:draw()
    
    local str = string.format("Test %d - %s", currentTestIndex, currentTest.title)
    
    font("Arial")
    fontSize(22)
    fill(255, 255, 255, 255)
    
    
    text(str, WIDTH/2, HEIGHT - 20)
    
    if UseAccelerometer == true then
        physics.gravity(Gravity)
    else
        physics.gravity(defaultGravity)
    end
end

function touched(touch)
    if debugDraw:touched(touch) == false then
        currentTest:touched(touch)
    end
end

function collide(contact)
    if debugDraw then
        debugDraw:collide(contact)
    end
    
    if currentTest and currentTest.collide then
        currentTest:collide(contact)
    end
end
