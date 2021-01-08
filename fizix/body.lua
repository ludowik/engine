local Body = class('Fizix.Body')

function Body.setup()
    DYNAMIC = DYNAMIC or 'dynamic'
    KINEMATIC = KINEMATIC or 'kinematic'
    STATIC = STATIC or 'static'

    CIRCLE = CIRCLE or 'circle'
    RECT = RECT or 'rect'
    POLYGON = POLYGON or 'polygon'
    CHAIN = CHAIN or 'chain'
    EDGE = EDGE or 'edge'
    SPHERE = SPHERE or 'sphere'
end

Body.circle = {}
Body.rect = {}
Body.polygon = {}
Body.chain = {}
Body.edge = {}
Body.sphere = {}

function Body:init(bodyType, shapeType, ...)
    assert(bodyType)
    assert(shapeType)

    self.type = bodyType
    self.shapeType = shapeType

    self.position = vec3()
    self.positionDelta = vec3()

    self.previousPosition = vec3()

    self.force = vec3()
    self.linearVelocity = vec3()
    self.linearDamping = 0.1

    self.angle = 0
    self.angleDelta = 0
    self.previousDelta = 0

    self.torque = 0
    self.angularVelocity = 0
    self.angularDamping = 0.1

    self.restitution = 0.8
    self.friction = 1

    self.radius = 0

    self:setMass(1)

    self.gravityScale = 1

    self.maxAcceleration = 100
    self.maxSpeed = 100

    self.categories = {0}
    self.mask = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}

    self.interpolate = true -- TODO : interpolate ?
    self.sleepingAllowed = false -- TODO : fix them when they don't "move"

    self.keepInArea = false -- TODO : keepInArea, 'in' or 'cross'

    self.points = Buffer('vec3')

    Body[self.shapeType].init(self, ...)
end

function Body.properties.get:x() return self.position.x end
function Body.properties.get:y() return self.position.y end

function Body.properties.set:x(x) self.position.x = x end
function Body.properties.set:y(y) self.position.y = y end

function Body:setMass(mass)
    if self.type == STATIC then
        self.mass = 0
        self.invMass = 0
    else
        self.mass = mass or 1
        self.invMass = 1 / self.mass
    end
end

function Body.circle:init(radius)
    self.radius = radius or math.random(10, 50)

    self.w = self.radius * 2
    self.h = self.w
end

function Body.rect:init(w, h)
    w = w or math.random(20, 100)
    h = h or math.random(20, 100)

    self.w = w
    self.h = h

    self.radius = math.sqrt(self.w^2 + self.h^2) / 2

    self.points = {
        vec3(-w/2, -h/2),
        vec3( w/2, -h/2),
        vec3( w/2,  h/2),
        vec3(-w/2,  h/2),
    }
end

function Body.polygon:init(vertices, ...)
    if vertices then
        if type(vertices) == 'cdata' then
            vertices = {vertices, ...}
        end
        for i,vertex in ipairs(vertices) do
            self.points:add(vertex:tovec3())
        end
    else
        self.points = Model.random.polygon(r or math.random(10, 50))
    end

    self:computeSize()
end

function Body.chain:init(loop, ...)
    self.loop = loop

    local vertices = {...}
    for i,vertex in ipairs(vertices) do
        self.points:add(vertex:tovec3())
    end

    self:computeSize()
end

function Body.edge:init(v1, v2)
    self.points:add(v1:tovec3())
    self.points:add(v2:tovec3())

    self:computeSize()
end

function Body.sphere:init(radius)
    self.radius = radius or math.random(10, 50)

    self.w = self.radius * 2
    self.h = self.w
    self.d = self.w
end

function Body:computeSize()
    local left, right = math.maxinteger, -math.maxinteger
    local bottom, top = math.maxinteger, -math.maxinteger

    for i,vertex in ipairs(self.points) do
        left = min(left, vertex.x)
        right = max(right, vertex.x)

        bottom = min(bottom, vertex.y)
        top = max(top, vertex.y)
    end

    self.w = right - left
    self.h = top - bottom

    self.radius = self.w / 2
end

function Body:destroy()
end

function Body:applyForce(force)
    self.force = self.force + force
end

function Body:applyLinearImpulse(impulse)
    self.linearVelocity = self.linearVelocity + impulse
end

function Body:applyTorque(torque)
    self.torque = self.torque + torque
end

function Body:applyAngularImpulse(impulse)
    self.anle = self.angle + impulse
end

function Body:testOverlap(otherBody)
    return Collision.collide(self, otherBody)
end

function Body:getLocalPoint(worldPoint)
    return worldPoint - self.position
end

function Body:getWorldPoint(localPoint)
    return localPoint + self.position
end

function Body:getLinearVelocityFromWorldPoint(worldPoint)
    return self.linearVelocity + (worldPoint - self.world.worldCenter):crossFromScalar(self.angularVelocity)
end

function Body:getLinearVelocityFromLocalPoint(localPoint)
    return self:getLinearVelocityFromWorldPoint(self:getWorldPoint(localPoint));
end

function Body:integration(dt)
    -- position
    local position = self.position / self.world.pixelRatio
    local linearVelocity = self.linearVelocity / self.world.pixelRatio

    local linearAcceleration = self.force + self.world.gravityForce * self.gravityScale * self.mass
    linearAcceleration = linearAcceleration / self.world.pixelRatio

    linearVelocity = linearVelocity - self.linearDamping * linearVelocity * dt
    linearVelocity = linearVelocity + linearAcceleration * self.invMass * dt

    if linearVelocity:len() > self.maxSpeed then
        linearVelocity = linearVelocity:normalize(self.maxSpeed)
    end

    self.positionDelta = linearVelocity * dt

    position = position + self.positionDelta

    self.previousPosition:set(self.position)
    self.position = position * self.world.pixelRatio
    self.linearVelocity = linearVelocity * self.world.pixelRatio

    self.force:set()

    -- angle
    local angle = self.angle
    local angularVelocity = self.angularVelocity

    local angularAcceleration = self.torque

    angularVelocity = angularVelocity - self.angularDamping * angularVelocity * dt
    angularVelocity = angularVelocity + angularAcceleration

    self.angleDelta = angularVelocity * dt

    angle = angle + self.angleDelta

    self.previousAngle = self.angle
    self.angle = angle
    self.angularVelocity = angularVelocity

    self.torque = 0
end

function Body:getBoundingBox()
    return
    self.position.x - self.w/2,
    self.position.y - self.h/2,
    self.position.x + self.w/2,
    self.position.y + self.h/2
end

function Body:getBoundingCircle()
    return
    self.position.x,
    self.position.y,
    self.radius
end

function Body:getBox2d()
    local r = Rect(
        self.position.x - self.w/2,
        self.position.y - self.h/2,
        self.w,
        self.h)
    r.rotation = deg(self.angle)
    return r
end

function Body:draw()
    noFill()

    strokeWidth(2)
    if self.contact then
        stroke(red)
    else
        stroke(yellow)
    end

    assert(Body[self.shapeType].draw, self.shapeType)
    Body[self.shapeType].draw(self)

    noStroke()
    fill(red)
    circle(0, 0, 2)

    stroke(gray)
    strokeWidth(2)
    noFill()

    Body.computeSize(self)

    -- bounding circle
    circle(0, 0, self.radius)

    -- bounding box
    rectMode(CENTER)
    rect(0, 0, self.w, self.h)
end

function Body.circle:draw()
    circleMode(CENTER)
    circle(0, 0, self.radius)
end

function Body.rect:draw()
    rectMode(CENTER)
    rect(0, 0, self.w, self.h)
end

function Body.polygon:draw()
    polygon(self.points)
end

function Body.chain:draw()
    polyline(self.points)
end

function Body.edge:draw()
    local p1 = self.points[1]
    local p2 = self.points[2]

    line(p1.x, p1.y, p2.x, p2.y)
end

function Body.sphere:draw()
    sphere()
end

function Body:touched(touch)
    self.position.x = self.position.x + touch.deltaX
    self.position.y = self.position.y - touch.deltaY
end

function Body:testPoint(touch)
    local xl, yb, xr, yt = self:getBoundingBox()
    if (touch.x >= xl and touch.x <= xr and
        touch.y >= yb and touch.y <= yt) then
        return true
    end
end
