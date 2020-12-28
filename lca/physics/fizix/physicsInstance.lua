PhysicsInstance = class('PhysicsInstance')

function PhysicsInstance.setup()
end

function PhysicsInstance:init()
    self.physics = newPhysics()
    self.physics:resume()

    self.bodies = Table()

    fizix = self
end

function PhysicsInstance:gravity(x, y)
    return self.physics.gravity(x, y)
end

function PhysicsInstance:body(...)
    return self:add(Object(), DYNAMIC, ...)
end

function PhysicsInstance:pause()
    self.physics.pause()
end

function PhysicsInstance:resume()
    self.physics.resume()
end

function PhysicsInstance:add(item, bodyType, ...)
    assert(item)
    assert(bodyType)

    local body = self.physics.body(...)
    body.type = bodyType

    if item then
        body.item = item
        item.body = body

        body.x = item.position.x
        body.y = item.position.y
    end

    body.world = self

    self.bodies:add(body)

    return body
end

function PhysicsInstance:addItems(items, ...)
    for _,item in ipairs(items) do
        self:add(item, ...)
    end
end

function PhysicsInstance:removeItem(item)
    item.body:destroy()
    self.bodies:removeItem(item.body)
end

class('Edge', Object)

function Edge:init(name, ...)
    Object.init(self, name, ...)
end

function PhysicsInstance:setArea(x, y, w, h)
    self:add(Edge('down'), STATIC, EDGE, vec2(x, y  ), vec2(x+w, y  ))
    self:add(Edge(), STATIC, EDGE, vec2(x, y+h), vec2(x+w, y+h))
    self:add(Edge(), STATIC, EDGE, vec2(x  , y), vec2(x  , y+h))
    self:add(Edge(), STATIC, EDGE, vec2(x+w, y), vec2(x+w, y+h))
end

function PhysicsInstance:update(dt)
    Fizix.setProperties(self)
    self.physics.update(dt)
    Fizix.updateProperties(self)
end

function PhysicsInstance:setProperties()
    for _,body in ipairs(self.bodies) do
        body.position.x = body.item.position.x
        body.position.y = body.item.position.y
        
        body.previousPosition.x = body.position.x
        body.previousPosition.y = body.position.y

        if body.item.linearVelocity then
            body.linearVelocity = body.item.linearVelocity
            body.item.linearVelocity = nil
        end
    end
end

function PhysicsInstance:updateProperties()
    for _,body in ipairs(self.bodies) do
        body.item.position.x = body.position.x
        body.item.position.y = body.position.y
        
        body.item.angle = body.angle
    end
end

function PhysicsInstance:draw()
    if not self.debug then return end

    for _,body in ipairs(self.bodies) do
        if body.shapeType == CIRCLE then
            Fizix.Body.draw(body)
        elseif body.shapeType == POLYGON then
            Fizix.Body.draw(body)
        elseif body.shapeType == EDGE then
            -- TODO
        else
            assert(false, body.shapeType)
        end

--        body:draw(dt)
    end
end
