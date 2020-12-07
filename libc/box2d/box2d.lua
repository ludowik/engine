local accum = 0

box2d.userdata = {}

class('box2dRef')

function box2dRef.setup()
    Fizix.Body.setup()

    e_shapesType = {
        [box2d.e_circle] = CIRCLE,
        [box2d.e_edge] = EDGE,
        [box2d.e_polygon] = POLYGON,
        [box2d.e_chain] = CHAIN,
        [box2d.e_typeCount] = COMPOUND,
    }

    e_bodiesType = {
        [STATIC]    = 0, -- b2World.b2_staticBody
        [KINEMATIC] = 1, -- b2World.b2_kinematicBody
        [DYNAMIC]   = 2, -- b2World.b2_dynamicBody
        [0] = STATIC,
        [1] = KINEMATIC,
        [2] = DYNAMIC
    }

    REVOLUTE  = box2d.e_revoluteJoint
    PRISMATIC = 1
    DISTANCE  = 2
    WELD      = 3
    ROPE      = 4

    BEGAN = 0
    MOVING = 1
    ENDED = 2
end

function box2dRef.Physics()
    physicsBox2d = ffi.gc(box2d.b2World_new(), destroyPhysics)
    physicsBox2d.running = true

    local unrefJoin = ffi.cast('unref', unrefJoin)
    box2d.setUnrefJoint(unrefJoin)

    Gravity = physicsBox2d.gravity()
    return physicsBox2d
end

function box2dRef.destroyPhysics(physics)
    box2d.b2World_gc(physics)
end

function b2Vec2(x, y, ratio)
    return ffi.gc(box2d.b2Vec2_new(x, y, ratio or 1), box2d.b2Vec2_gc)
end

local b2Vec2_mt = ffi.metatype('b2Vec2', {
        __newindex = function (tbl, key, value)
            if key == 'x' then
                box2d.b2Vec2_x_set(tbl, value)
            elseif key == 'y' then
                box2d.b2Vec2_y_set(tbl, value)
            else
                assert()
--                rawset(tbl, key, value)
            end
        end,

        __index = function (tbl, key)
            if key == 'x' then
                return box2d.b2Vec2_x_get(tbl)
            elseif key == 'y' then
                return box2d.b2Vec2_y_get(tbl)
            else
                return rawget(b2Vec2_index, key)
            end
        end,

        __tostring = function (tbl)
            return '('..string.format('%.2f', tbl.x)..','..string.format('%.2f', tbl.y)..')'
        end
    })

local function collideFunc(cp)
    local contact = {
        id = cp.id,
        state = cp.state,
        touching = cp.touching,
        position = vec3(cp.position.x, cp.position.y):mul(mtpRatio),
        normal = vec3(cp.normal.x, cp.normal.y),
        normalImpulse = cp.normalImpulse,
        tangentImpulse = cp.tangentImpulse,
        pointCount = cp.pointCount,
        points = {},
        bodyA = cp.bodyA,
        bodyB = cp.bodyB
    }

    for i=1,cp.pointCount do
        table.add(contact.points,
            vec3(cp.points[i-1].x, cp.points[i-1].y):mul(mtpRatio))
    end

    if env.app.__collide then
        env.app:__collide(contact)

        if contact.state ~= ENDED then
            physicsBox2d.contacts:add(contact)
        end
    end
end

local function __triangulate(points)
    local x = ffi.new('float[2048]')
    local y = ffi.new('float[2048]')

    local triangles = ffi.new('b2Triangle[4096]')

    for i,point in ipairs(points) do
        x[i-1] = point.x
        y[i-1] = point.y
    end

    local triCount = box2d.b2World_triangulate(x, y, #points, triangles)

    local vertices = Table()
    for i=1,triCount do
        local v = triangles[i]
        vertices:add(vec3(v.x[i-1], v.y[i-1]))
    end

    return vertices
end

local b2World_index = {
    gravity = function (x, y)
        if x == nil and y == nil then
            local g = box2d.b2World_getGravity(physicsBox2d)
            return vec3(g.x, g.y)
        else
            if x and y then
                box2d.b2World_setGravity(physicsBox2d, b2Vec2(x, y))
            elseif x.x then
                local g = x
                box2d.b2World_setGravity(physicsBox2d, b2Vec2(g.x, g.y))
            end
        end
    end,

    update = function (dt)
        physicsBox2d.contacts = Table()
        if physicsBox2d.running then
            local timeStep = 0.005 -- 1. / config.framerate

            if debugging() then
                accum = timeStep
            else
                accum = accum + dt
            end

            box2d.b2World_setAutoClearForces(physicsBox2d, false)

            while (accum >= timeStep) do
                accum = accum - timeStep

                box2d.b2World_step(physicsBox2d, timeStep)

                -- process contact
                local collideFunc = ffi.cast('collideFunc', collideFunc)
                box2d.b2World_processContacts(physicsBox2d, collideFunc)
                collideFunc:free()
            end

            -- clear forces
            box2d.b2World_clearForces(physicsBox2d)
        end
    end,

    draw = function ()
        noStroke()
        fill(red)
        circleMode(CENTER)
        for _,contact in ipairs(physicsBox2d.contacts) do
            for i=1,contact.pointCount do
                local point = contact.points[i]
                circle(point.x, point.y, 5)
            end
        end
    end,

    pause = function ()
        physicsBox2d.running = false
    end,

    resume = function ()
        physicsBox2d.running = true
    end,

    clear = function ()
        functionNotImplemented('physics.clear')
    end,

    body = function (shapeType, ...)
        local self = physicsBox2d

        local args = {...}

        local body

        if shapeType == CIRCLE then
            local radius = args[1] or math.random(10, 50)
            body = box2d.b2Body_new_circle(self, radius * ptmRatio)

        elseif shapeType == RECT then
            local w, h = args[1] or math.random(20, 100), args[2] or math.random(20, 100)
            local points = ffi.new('b2Vec2[?]', 4)
            points[0].x, points[0].y = -w/2 * ptmRatio, -h/2 * ptmRatio
            points[1].x, points[1].y =  w/2 * ptmRatio, -h/2 * ptmRatio
            points[2].x, points[2].y =  w/2 * ptmRatio,  h/2 * ptmRatio
            points[3].x, points[3].y = -w/2 * ptmRatio,  h/2 * ptmRatio
            body = box2d.b2Body_new_polygon(self, points, 4)

        elseif shapeType == POLYGON then
            if args[1] then
                args = args[1].x and args or args[1]
            else
                args = Model.random.polygon(r or math.random(10, 50))
            end

            local points = ffi.new('b2Vec2[?]', #args)
            for i=1,#args do
                points[i-1].x = args[i].x * ptmRatio
                points[i-1].y = args[i].y * ptmRatio
            end
            body = box2d.b2Body_new_polygon(self, points, #args)

        elseif shapeType == CHAIN then
            local loop = table.remove(args, 1) or true
            args = args[1].x and args or args[1]

            local points = ffi.new('b2Vec2[?]', #args)
            for i=1,#args do
                points[i-1].x = args[i].x * ptmRatio
                points[i-1].y = args[i].y * ptmRatio
            end
            body = box2d.b2Body_new_chain(self, points, #args, loop)

        elseif shapeType == EDGE then
            local p1 = b2Vec2(args[1].x * ptmRatio, args[1].y * ptmRatio)
            local p2 = b2Vec2(args[2].x * ptmRatio, args[2].y * ptmRatio)
            body = box2d.b2Body_new_edge(self, p1, p2)
        else
            body = box2d.b2Body_new_circle(self, 1)
        end

        box2d.userdata[box2d.b2Body_getId(body)] = {}

        body.previousPosition = body.position:clone()

        body.density = 1
        body.friction = 0.4
        body.sleepingAllowed = true
        body.gravityScale = 1

        return body
    end,

    edge = function ()
        functionNotImplemented('physics.edge')
    end,

    joint = function (jointType, bodyA, bodyB, anchorA, anchorB, maxLength)
        local self = physicsBox2d
        self.joints = self.joints or {}

        local direction = anchorB
        anchorB = anchorB or vec3()

        anchorA = b2Vec2(anchorA.x, anchorA.y, ptmRatio)
        anchorB = b2Vec2(anchorB.x, anchorB.y, ptmRatio)

        maxLength = maxLength or 0

        local joint
        if jointType == REVOLUTE then
            joint = box2d.b2Joint_new_revolute(self, bodyA, bodyB, anchorA)
        elseif jointType == DISTANCE then
            joint = box2d.b2Joint_new_distance(self, bodyA, bodyB, anchorA, anchorB)
        elseif jointType == PRISMATIC then
            joint = box2d.b2Joint_new_prismatic(self, bodyA, bodyB, anchorA, direction)
        elseif jointType == WELD then
            joint = box2d.b2Joint_new_weld(self, bodyA, bodyB, anchorA, direction)
        else
            assert()
        end

        self.joints[ffi.cast('b2Joint*', self)] = joint
        return joint
    end,

    raycast = function (p1, p2)
        local self = physicsBox2d

        local result = box2d.b2World_raycast(self,
            b2Vec2(p1.x, p1.y, ptmRatio),
            b2Vec2(p2.x, p2.y, ptmRatio))

        if result ~= NULL then
            return {
                body = result.body,
                point = vec3(result.point.x, result.point.y):mul(mtpRatio),
                normal = vec3(result.normal.x, result.normal.y),
                fraction = result.fraction
            }
        end
    end,

    raycastAll = function (p1, p2)
        local self = physicsBox2d

        local result = box2d.b2World_raycastAll(self,
            b2Vec2(p1.x, p1.y, ptmRatio),
            b2Vec2(p2.x, p2.y, ptmRatio))

        local bodies = {}
        if result ~= NULL then
            local i = 0
            while (result[i].body ~= NULL) do
                table.add(bodies, {
                        body = result[i].body,
                        point = vec3(result[i].point.x, result[i].point.y):mul(mtpRatio),
                        normal = vec3(result[i].normal.x, result[i].normal.y),
                        fraction = result[i].fraction
                    })
                i = i + 1
            end
        end
        return bodies
    end,

    queryAABB = function (p1, p2)
        local self = physicsBox2d

        local result = box2d.b2World_queryAABB(self,
            b2Vec2(p1.x, p1.y, ptmRatio),
            b2Vec2(p2.x, p2.y, ptmRatio))

        if result then
            local bodies = {}
            local i = 0
            while (result[i] ~= NULL) do
                table.add(bodies, result[i])
                i = i + 1
            end
            return bodies
        end
    end,

    triangulate = triangulate
}

local b2World_mt = ffi.metatype('b2World', {
        __newindex = function (tbl, key, value)
            if key == 'continuous' then
                box2d.b2World_setContinuous(tbl, value)
            elseif key == 'pixelToMeterRatio' then
                pixelToMeterRatio = value
                mtpRatio = pixelToMeterRatio
                ptmRatio = 1 / mtpRatio
            elseif key == 'running' then
                b2World_index.running = value
            elseif key == 'debug' then
                b2World_index.debug = value
            elseif key == 'contacts' then
                b2World_index.contacts = value
            elseif key == 'joints' then
                b2World_index.joints = value
            else
                assert(false, key..'='..tostring(value))
--                rawset(tbl, key, value)
            end
        end,

        __index = function (tbl, key)
            if key == 'continuous' then
                return box2d.b2World_getContinuous(tbl)
            elseif key == 'pixelToMeterRatio' then
                return pixelToMeterRatio
            elseif key == 'running' then
                return b2World_index.running
            elseif key == 'debug' then
                return b2World_index.debug
            elseif key == 'contacts' then
                return b2World_index.contacts
            elseif key == 'joints' then
                return b2World_index.joints
            else
                return rawget(b2World_index, key)
            end
        end
    })
