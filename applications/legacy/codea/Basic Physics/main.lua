-- Simple Physics

_G.physics = box2dRef.Physics()

-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    
    print("Hello Physics!")

    print("Touch the screen to make boxes")

    -- Table to store our physics bodies
    bodies = {}

    -- Create some static boxes (not effected by gravity or collisions)
    local left = makeBox(WIDTH/4, HEIGHT/2, WIDTH/3, 15, -30)
    left.type = STATIC

    local right = makeBox(WIDTH - WIDTH/4, HEIGHT/2, WIDTH/3, 15, 30)
    right.type = STATIC

    local floor = makeBox(WIDTH/2, 10, WIDTH, 20, 0)
    floor.type = STATIC

    table.insert(bodies, left)
    table.insert(bodies, right)
    table.insert(bodies, floor)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color
    background(40, 40, 50)

    -- Draw all our physics bodies
    for k,body in pairs(bodies) do
        drawBody(body)
    end
end

function touched(touch)
    -- When you touch the screen, create a random box
    if touch.state == BEGAN then
        table.insert(bodies, makeBox(touch.x, touch.y, math.random(25, 50), math.random(25, 50), 0))
    end
end

-- Helper function to create a box using a polygon body
function makeBox(x,y,w,h,r)
    -- Points are defined in counter-clockwise order
    local body = physics.body(POLYGON,
        vec2(-w/2, h/2),
        vec2(-w/2, -h/2),
        vec2(w/2, -h/2),
        vec2(w/2, h/2))

    -- Set the body's transform (position, angle)
    body.x = x
    body.y = y
    body.angle = r

    -- Make movement smoother regardless of framerate
    body.interpolate = true

    return body
end

-- Helper function to draw a physics body
function drawBody(body)
    -- Push style and transform matrix so we can restore them after
    pushStyle()
    pushMatrix()

    strokeWidth(5)
    stroke(148, 224, 135, 255)
    translate(body.x, body.y)
    rotate(body.angle)

    -- Draw body based on shape type
    if body.shapeType == POLYGON then
        strokeWidth(3.0)
        local points = body.points
        for j = 1,#points do
            a = points[j]
            b = points[(j % #points)+1]
            line(a.x, a.y, b.x, b.y)
        end
    elseif body.shapeType == CHAIN or body.shapeType == EDGE then
        strokeWidth(3.0)
        local points = body.points
        for j = 1,#points-1 do
            a = points[j]
            b = points[j+1]
            line(a.x, a.y, b.x, b.y)
        end
    elseif body.shapeType == CIRCLE then
        strokeWidth(3.0)
        line(0,0,body.radius-3,0)
        ellipse(0,0,body.radius*2)
    end

    -- Restore style and transform
    popMatrix()
    popStyle()
end
