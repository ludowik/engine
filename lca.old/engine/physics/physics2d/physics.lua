class('Physics2d')

Gravity = vector()

function Physics2d:init(x, y, scale)
    self.scale = scale or 32

    lca.physics.setMeter(self.scale)

    self.world = lca.physics.newWorld()
    self.world:setSleepingAllowed(true)

    local g = self:gravity(
        self.scale * (x or 0),
        self.scale * (y or -10))

    self.running = true    
    self.debug = false

    self.bodies = Table()
    self.fixtures = Table()
    self.joints = Table()

    self:initContact()   
end

function Physics2d:gravity(x, y)
    if x then
        self.g = vector(x, y)
        self.world:setGravity(self.g.x, self.g.y)
    end
    return self.world:getGravity()
end

function Physics2d:initContact()
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

function Physics2d:setArea(x, y, w, h)
    self:addEdge('down' , {x, y  , x+w, y  })
    self:addEdge('up'   , {x, y+h, x+w, y+h})

    self:addEdge('left' , {x  , y, x  , y+h})
    self:addEdge('right', {x+w, y, x+w, y+h})
end

function Physics2d:addEdge(name, points)
    self:addItem(Edge(name), STATIC, EDGE, 1, nil, nil, points)
end

function Physics2d:addItems(items, bodyType, shapeType, groupIndex)
    bodyType = bodyType or DYNAMIC
    groupIndex = groupIndex or 1

    for i,item in ipairs(items) do
        self:addItem(item, bodyType, shapeType, groupIndex)
    end
end

function Physics2d:addItem(item, bodyType, shapeType, groupIndex, radius, loop, points)
    bodyType = bodyType or DYNAMIC
    groupIndex = groupIndex or 1

    local body = lca.physics.newBody(self.world,
        item and item.position.x or 0,
        item and item.position.y or 0,
        bodyType)

    local shape
    if shapeType == CIRCLE then
        shape = lca.physics.newCircleShape(item and item.size.x / 2 or radius)

    elseif shapeType == RECT then
        shape = lca.physics.newRectangleShape(item.size.x, item.size.y)

    elseif shapeType == POLYGON then
        shape = lca.physics.newPolygonShape(unpack(points))

    elseif shapeType == CHAIN then
        shape = lca.physics.newChainShape(loop, unpack(points))

    elseif shapeType == EDGE then
        local x1, y1 = points[1], points[2]
        local x2, y2 = points[3], points[4]
        shape = lca.physics.newEdgeShape(x1, y1, x2, y2)

    else
        assert(false, shapeType)
    end

    local fixture = lca.physics.newFixture(body, shape)
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

function Physics2d:removeItem(item)
    if item.body then
        item.body:destroy()
        item.body = nil
    end
    return item
end

function Physics2d:addJoint(jointType, ...)
    local joint = Joint(self, jointType, ...)
    return joint
end

function Physics2d:processForce(items)
    for i,item in ipairs(items) do
        if item.linearVelocity then
            item.body.linearVelocity = item.linearVelocity
            item.linearVelocity = nil
        end
    end
end

function Physics2d:updatePosition(items)
    for i,item in ipairs(items) do
        item.body.position = item.position
    end
end

function Physics2d:pause()
    self.running = false
end

function Physics2d:resume()
    self.running = true
end

function Physics2d:update(dt)
    if self.running then
        local contacts = self.contacts
        for k,contact in pairs(contacts) do
            if contact.state == ENDED then
                self.contacts[k] = nil
            end
        end

        self.world:update(dt)

        for k,contact in pairs(contacts) do
            app:collide(contact)
        end

        for i,body in pairs(self.bodies) do
            local item = body.item
            if item then
                if item.needUpdatePosition then
                    item.needUpdatePosition = nil
                    body.position = item.position

                else
                    local pos = body.position
                    item.position.x = pos.x
                    item.position.y = pos.y
                end
            end
        end
    end
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

function Physics2d:draw()
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

function Physics2d:beginContact(a, b, contact)
    self.contacts[contact] = Contact(self, contact)
end

function Physics2d:endContact(a, b, contact)
    self.contacts[contact]:destroy(contact)
end

function Physics2d:preSolve(a, b, contact)
    self.contacts[contact]:update(contact)
end

function Physics2d:postSolve(a, b, contact, normalImpulse, tangentImpulse)
end

function Physics2d:raycast(x1, y1, x2, y2)
    return self:raycastProc(x1, y1, x2, y2, 0)[1]
end

function Physics2d:raycastAll(x1, y1, x2, y2)
    return self:raycastProc(x1, y1, x2, y2, 1)
end

function Physics2d:raycastProc(x1, y1, x2, y2, all)
    local bodies = Table()
    local function worldRayCastCallback(fixture, x, y, xn, yn, fraction)
        bodies:add{
            body = self.fixtures[fixture],
            point = vector(x, y),
            normal = vector(xn, yn),
            fraction = fraction
        }

        return all
    end

    self.world:rayCast(x1, y1, x2, y2, worldRayCastCallback)

    return bodies
end

function Physics2d:queryAABB(x1, y1, x2, y2)
    todo()
    --    self.world:queryAABB(x1, y1, x2, y2)
    return {}
end
