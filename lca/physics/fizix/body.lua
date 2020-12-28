local Body = class('Fizix.Body')

Fizix.Body = Body

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

    self.bodyType = bodyType
    self.shapeType = shapeType

    self.position = vec3()
    self.previousPosition = vec3()
    
    self.force = vec3()
    self.move = vec3()

    self.linearVelocity = vec3()
    self.angularVelocity = 0

    self.linearDamping = 0.5
    self.angularDamping = 0.5

    self.restitution = 0.8
    self.friction = 1

    self.radius = 0

    self.angle = 0

    self:setMass(1)

    self.gravityScale = 1

    self.maxAcceleration = 100
    self.maxSpeed = 100

    self.interpolate = true -- TODO
    self.sleepingAllowed = false -- TODO

    self.keepInArea = false -- TODO

    self.points = Array()

    Body[self.shapeType].init(self, ...)
end

function Body.properties.get:x() return self.position.x end
function Body.properties.get:y() return self.position.y end

function Body.properties.set:x(x) self.position.x = x end
function Body.properties.set:y(y) self.position.y = y end

function Body:setMass(mass)
    if self.bodyType == STATIC then
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
        vec2(-w/2, -h/2),
        vec2( w/2, -h/2),
        vec2( w/2,  h/2),
        vec2(-w/2,  h/2),
    }
end

function Body.polygon:init(vertices)
    if vertices then
        for i,vertex in ipairs(vertices) do
            self.points:insert(vertex)
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
        self.points:insert(vertex)
    end

    self:computeSize()
end

function Body.edge:init(v1, v2)
    self.points:insert(v1)
    self.points:insert(v2)

    self:computeSize()
end

function Body.sphere:init(radius)
    self.radius = radius or math.random(10, 50)

    self.w = self.radius * 2
    self.h = self.w
    
    self.d = self.d
end

function Body:computeSize()
    local left, right = math.MAX_INTEGER, -math.MAX_INTEGER
    local bottom, top = math.MAX_INTEGER, -math.MAX_INTEGER
    for i,vertex in ipairs(self.points) do
        left = min(left, vertex.x)
        right = max(right, vertex.x)

        bottom = min(bottom, vertex.y)
        top = max(top, vertex.y)
    end

    self.w = right - left
    self.h = top - bottom

    self.radius = self.w
end

function Body:destroy()
end

function Body:applyForce(v)
end

function Body:applyLinearImpulse(force)
end

function Body:applyTorque(torque)
end

function Body:testOverlap( otherBody )
end

function Body:integration(dt)
    local position = self.position / self.world.pixelRatio
    local angle = math.rad(self.angle)

    local linearVelocity = self.linearVelocity
    local angularVelocity = self.angularVelocity

    local acceleration = self.force + self.world.g * self.gravityScale * self.mass

    linearVelocity = linearVelocity - (1 - self.linearDamping) * linearVelocity * dt
    linearVelocity = linearVelocity + acceleration * self.invMass * dt

    local len = self.linearVelocity:len()
    if len > self.maxSpeed then
        self.linearVelocity = self.linearVelocity:normalize(self.maxSpeed)
    end

    self.move = linearVelocity * dt

    position = position + self.move
    angle = angle + angularVelocity * dt

    self.position = position * self.world.pixelRatio 

    self.linearVelocity = linearVelocity

    angularVelocity = angularVelocity - (1 - self.angularDamping) * angularVelocity * dt
    angle = angle + angularVelocity * dt

    self.angularVelocity = angularVelocity
    self.angle = math.deg(angle)

    self.force:set()
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
    circle(self.position.x, self.position.y, 2)

    stroke(gray)
    strokeWidth(2)
    noFill()
    
    Body.computeSize(self)

    -- bounding circle
    circle(self.position.x, self.position.y, self.radius)

    -- bounding box
    rectMode(CENTER)
    rect(self.position.x, self.position.y, self.w, self.h)
end

function Body.circle:draw()
    ellipseMode(CENTER)
    circle(self.position.x, self.position.y, self.radius)
end

function Body.rect:draw()
    rectMode(CENTER)
    rect(self.position.x, self.position.y, self.w, self.h)
end

function Body.polygon:draw()
    assert(#self.points >= 3)

    local vertices = Array()

    local p1, p2, p3 = self.points[1]
    for i=3,#self.points do
        p2 = self.points[i-1]
        p3 = self.points[i]

        table.insert(vertices, p1)
        table.insert(vertices, p2)
        table.insert(vertices, p3)
    end

    local shape = mesh()
    shape.vertices = vertices

    pushMatrix()
    do
        translate(self.position.x, self.position.y)
        
        rotate(self.angle, 0, 0, 1)
        
        shape:draw()

        for i=2,#self.points do
            p2 = self.points[i-1]
            p3 = self.points[i]

            line(p2.x, p2.y, p3.x, p3.y)
        end
        line(p3.x, p3.y, p1.x, p1.y)
    end
    popMatrix()
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
