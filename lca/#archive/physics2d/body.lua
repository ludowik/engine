local Body = class('love.box2d.Body')

function Body:init(physics, item, body, shape, fixture, shapeType)
    self.physics = physics
    
    self.body = body
    self.fixture = fixture
    
    self.shape = fixture:getShape()

    physics.bodies[body] = self
    physics.fixtures[fixture] = self
    
    self.item = item
end

function Body:destroy()
    self.physics.fixtures[self.fixture] = nil
    self.physics.bodies[self.body] = nil
    
    self.fixture:destroy()
    self.body:destroy()
end

function Body.properties.get:type()
    return self.body:getType()
end

function Body.properties.set:type(type)
    self.body:setType(type)
end

function Body.properties.get:shapeType()
    return self.shape:getType()
end

function Body.properties.get:info(info)
    return self.body:getUserData()
end

function Body.properties.set:info(info)
    self.body:setUserData(info)
end

function Body.properties.get:gravityScale()
    return self.body:getGravityScale()
end

function Body.properties.set:gravityScale(gravityScale)
    self.body:setGravityScale(gravityScale)
end

function Body.properties.get:restitution()
    return self.fixture:getRestitution()
end

function Body.properties.set:restitution(restitution)
    self.fixture:setRestitution(restitution)
end

function Body.properties.get:friction()
    return self.fixture:getFriction()
end

function Body.properties.set:friction(friction)
    self.fixture:setFriction(friction)
end

function Body.properties.get:position()
    local x, y = self.body:getPosition()
    return vec3(x, y)
end

function Body.properties.set:position(position)
    self.body:setPosition(position.x, position.y)
end

function Body.properties.get:x()
    return self.body:getX()
end

function Body.properties.set:x(x)
    self.body:setX(x)
end

function Body.properties.get:y()
    return self.body:getY()
end

function Body.properties.set:y(y)
    self.body:setY(y)
end

function Body.properties.get:angle()
    return deg(self.body:getAngle())
end

function Body.properties.set:angle(angle)
    self.body:setAngle(rad(angle))
end

function Body.properties.get:radius(radius)
    return self.shape:getRadius()
end

function Body.properties.set:radius(radius)
    self.shape:setRadius(radius)
end

function Body.properties.set:angularDamping(angularDamping)
    self.body:setAngularDamping(angularDamping)
end

function Body.properties.set:linearDamping(linearDamping)
    self.body:setLinearDamping(linearDamping)
end

function Body.properties.get:linearVelocity()
    local x, y = self.body:getLinearVelocity()
    return vec3(x, y)
end

function Body.properties.set:linearVelocity(linearVelocity)
    self.body:setLinearVelocity(linearVelocity.x, linearVelocity.y)
end

function Body.properties.get:angularVelocity()
    return deg(self.body:getAngularVelocity())
end

function Body.properties.set:angularVelocity(angularVelocity)
    self.body:setAngularVelocity(rad(angularVelocity))
end

function Body.properties.get:bullet()
    return self.body:getBullet()
end

function Body.properties.set:bullet(bullet)
    self.body:setBullet(bullet)
end

function Body.properties.get:sensor()
    return self.fixture:isSensor()
end

function Body.properties.set:sensor(sensor)
    self.fixture:setSensor(sensor)
end

function Body.properties.get:points()
    local points = {self.shape:getPoints()}
    local vectors = {}
    for i=1,#points,2 do
        table.insert(vectors, vec3(points[i], points[i+1]))
    end
    return vectors
end

function Body:applyForce(f)
    self.body:applyLinearImpulse(f.x, f.y)
end

function Body:applyLinearImpulse(v)
    self.body:applyLinearImpulse(v.x, v.y)
end

function Body:testPoint(p)
    local x, y = self.body:getPosition()
    local angle = self.body:getAngle()
    return self.shape:testPoint(x, y, angle, p.x, p.y)
end

function Body:getLocalPoint(p)
    return vec3(self.body:getLocalPoint(p.x, p.y))
end

function Body:getWorldPoint(p)
    return vec3(self.body:getWorldPoint(p.x, p.y))
end

function Body:getLinearVelocityFromLocalPoint(p)
    return vec3(self.body:getLinearVelocityFromLocalPoint(p.x, p.y))
end

function Body:getLinearVelocityFromWorldPoint(p)
    return vec3(self.body:getLinearVelocityFromWorldPoint(p.x, p.y))
end

function Body:testOverlap(otherBody)
    todo()
    return false
end
