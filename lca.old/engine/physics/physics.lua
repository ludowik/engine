class('Physics')

KINEMATIC = 'kinematic'
DYNAMIC = 'dynamic'
STATIC = 'static'

CIRCLE = 'circle'
RECT = 'rect'
POLYGON = 'polygon'
CHAIN = 'chain'
EDGE = 'edge'

function Physics:init(...)
    local physics = self
    local p2d = Physics2d(...)

    physics.p2d = p2d

    function physics:update(dt)
        p2d:update(dt)
    end

    function physics.gravity(x, y)
        if x then
            p2d:gravity(x, y)
        end
        return vec3(p2d:gravity())
    end

    function physics.pause()
        p2d:pause()
    end

    function physics.resume()
        p2d:resume()
    end

    function physics:addItems(...)
        return p2d:addItems(...)
    end

    function physics:addItem(...)
        return p2d:addItem(...)
    end

    function physics.body(shapeType, ...)
        local args = {...}
        if shapeType == CIRCLE then
            local radius = args[1]
            return p2d:addItem(nil, DYNAMIC, shapeType, 1, radius)

        elseif shapeType == POLYGON then
            local points = args
            return p2d:addItem(nil, DYNAMIC, shapeType, 1, nil, nil, vectors2vertices(points))

        elseif shapeType == CHAIN then
            local points = args
            local loop = points[1] or false
            table.remove(points, 1)
            return p2d:addItem(nil, STATIC, shapeType, 1, nil, loop, vectors2vertices(points))

        elseif shapeType == EDGE then
            local points = args
            return p2d:addItem(nil, STATIC, shapeType, 1, nil, nil, vectors2vertices(points))

        end
    end

    function physics.joint(jointType, ...)
        return p2d:addJoint(jointType, ...)
    end

    function physics.raycast(p1, p2)
        return p2d:raycast(p1.x, p1.y, p2.x, p2.y)
    end

    function physics.raycastAll(p1, p2)
        return p2d:raycastAll(p1.x, p1.y, p2.x, p2.y)
    end

    function physics.queryAABB(p1, p2)
        return p2d:queryAABB(p1.x, p1.y, p2.x, p2.y)
    end
end

physics = Physics(0, -10)
physics.debug = true
