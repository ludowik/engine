local Physics = class('love.box2d.Physics2d')

Gravity = vec2()

class('box2dRef')

function box2dRef.Physics()
    return Physics()
end

function Physics:init(x, y, scale)
    self.scale = scale or 32

    love.physics.setMeter(self.scale)

    self.world = love.physics.newWorld()
    self.world:setSleepingAllowed(true)

    local g = self:gravity(
        self.scale * (x or 0),
        self.scale * (y or -10))

    self:resume()

    self.debug = false

    self.bodies = Table()
    self.fixtures = Table()
    self.joints = Table()

    self:initContact()   
end

function Physics:gravity(x, y)
    if x then
        self.g = vec2(x, y)
        self.world:setGravity(self.g.x, self.g.y)
    end
    return self.world:getGravity()
end

function Physics:initContact()
    local function beginContact(a, b, contact)
        self:beginContact(a, b, contact)
    end

    local function endContact(a, b, contact)
        self:endContact(a, b, contact)
    end    

    local function preSolve(a, b, contact)
        self:preSolve(a, b, contact)
    end

    local function postSolve(a, b, contact, normalImpulse, tangentImpulse)
        self:postSolve(a, b, contact, normalImpulse, tangentImpulse)
    end

    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    self.contacts = Table()
end

function Physics:addItems(items, bodyType, shapeType, groupIndex)
    bodyType = bodyType or DYNAMIC
    groupIndex = groupIndex or 1

    for i,item in ipairs(items) do
        self:addItem(item, bodyType, shapeType, groupIndex)
    end
end

function Physics:addItem(item, bodyType, shapeType, groupIndex, radius, loop, points)
    bodyType = bodyType or DYNAMIC
    groupIndex = groupIndex or 1

    local body = love.physics.newBody(self.world,
        item and item.position.x or 0,
        item and item.position.y or 0,
        bodyType)

    local shape
    if shapeType == CIRCLE then
        shape = love.physics.newCircleShape(item and item.size.x / 2 or radius)

    elseif shapeType == RECT then
        shape = love.physics.newRectangleShape(item.size.x, item.size.y)

    elseif shapeType == POLYGON then
        shape = love.physics.newPolygonShape(unpack(points))

    elseif shapeType == CHAIN then
        shape = love.physics.newChainShape(loop, unpack(points))

    elseif shapeType == EDGE then
        local x1, y1 = points[1], points[2]
        local x2, y2 = points[3], points[4]
        shape = love.physics.newEdgeShape(x1, y1, x2, y2)

    else
        assert(false, shapeType)
    end

    local fixture = love.physics.newFixture(body, shape)
    fixture:setGroupIndex(groupIndex)
    fixture:setRestitution(item and item.restitution or 0)
    fixture:setFriction(item and item.friction or 0.2)
    fixture:setDensity(item and item.density or 1)

    if item and item.bullet then
        body:setBullet(true)
    end

    if item and item.sensor then
        fixture:setSensor(item.sensor)
    end

    local b = Body(self, item, body, shape, fixture, shapeType)
    if item then
        item.body = b
    end

    return b
end

function Physics:removeItem(item)
    if item.body then
        item.body:destroy()
        item.body = nil
    end
    return item
end

function Physics:addJoint(jointType, ...)
    local joint = Joint(self, jointType, ...)
    return joint
end

function Physics:update(dt)
    if self.running then
        self.world:update(dt)
    end
end

function Physics:pause()
    self.running = false
end

function Physics:resume()
    self.running = true
end

local function drawContactPosition(x1, y1, x2, y2)
    noStroke()
    fill(red)

    circleMode(CENTER)
    circle(x1, y1, 5)

    if x2 then
        circle(x2, y2, 5)
    end
end

local function drawContactNormal(x, y, xn, yn)
    local scale = 50

    stroke(green)
    strokeWidth(1)

    xn = xn * scale
    yn = yn * scale

    line(x, y, x+xn, y+yn)
end

function Physics:draw()
    if not self.debug then return end

    for _,body in pairs(self.bodies) do
        local item = body.item

        local shapeType = body.shapeType
        local x, y = body.position.x, body.position.y

        fill(item and item.color or white)

        if shapeType == CIRCLE then
            circleMode(CENTER)
            circle(x, y, body.radius)

        elseif shapeType == RECT then
            pushMatrix()
            do
                translate(x, y)
                rotate(body.angle)
                polygon(body.points)
            end
            popMatrix()

        elseif shapeType == POLYGON or shapeType == CHAIN then
            pushMatrix()
            do
                translate(x, y)
                rotate(body.angle)
                polygon(body.points)
            end
            popMatrix()

        elseif shapeType == EDGE then
            local p1, p2 = body.points[1], body.points[2]
            line(x+p1.x, y+p1.y, x+p2.x, y+p2.y)
        end
    end

    local contacts = self.contacts
    for _,contact in pairs(contacts) do
        local x1, y1, x2, y2 = contact.position.x, contact.position.y
        local xn, yn = contact.normal.x, contact.normal.y

        drawContactPosition(x1, y1, x2, y2)
        drawContactNormal(x1, y1, xn, yn)
    end
end

function Physics:beginContact(a, b, contact)
    self.contacts[contact] = Contact(self, contact)
end

function Physics:endContact(a, b, contact)
    self.contacts[contact]:destroy(contact)
end

function Physics:preSolve(a, b, contact)
    self.contacts[contact]:update(contact)
end

function Physics:postSolve(a, b, contact, normalImpulse, tangentImpulse)
end

function Physics:raycast(x1, y1, x2, y2)
    return self:raycastProc(x1, y1, x2, y2, 0)[1]
end

function Physics:raycastAll(x1, y1, x2, y2)
    return self:raycastProc(x1, y1, x2, y2, 1)
end

function Physics:raycastProc(x1, y1, x2, y2, all)
    local bodies = Table()
    local function worldRayCastCallback(fixture, x, y, xn, yn, fraction)
        bodies:add{
            body = self.fixtures[fixture],
            point = vec2(x, y),
            normal = vec2(xn, yn),
            fraction = fraction
        }

        return all
    end

    self.world:rayCast(x1, y1, x2, y2, worldRayCastCallback)

    return bodies
end

function Physics:queryAABB(x1, y1, x2, y2)
    todo()
    --    self.world:queryAABB(x1, y1, x2, y2)
    return {}
end
