Fizix = class('Fizix')

function Fizix.setup()
    Physics2d = Fizix
    Physics3d = Fizix

    Object2d = Object
    Object3d = Object
end

function Fizix:init()
    self.bodies = Array()
    self.contacts = Array()

    self.g = vec3(0, -9.81)

    self.pixelRatio = 32
    self.debug = false

    Gravity = self.g
    
    self:resume()
end

function Fizix:gravity(x, y)
    if x then
        if type(x) == 'table' then
            self.g:set(x.x, x.y)
        else
            self.g:set(x, y)
        end
    end
    return self.g
end

function Fizix:body(...)
    return self:add(Object(), DYNAMIC, ...)
end

function Fizix:pause()
    self.running = false
end

function Fizix:resume()
    self.running = true
end

function Fizix:add(item, bodyType, ...)
    assert(item)
    assert(bodyType)
    
    local body = Fizix.Body(bodyType, ...)

    if item then
        body.item, item.body = item, body
        body.position = item.position
    end

    body.world = self

    self.bodies:add(body)

    return body
end

function Fizix:addItems(items, ...)
    for _,item in ipairs(items) do
        self:add(item, ...)
    end
end

function Fizix:setArea(x, y, w, h)
    self:add(Object(), STATIC, EDGE, vec2(x, y  ), vec2(x+w, y  ))
    self:add(Object(), STATIC, EDGE, vec2(x, y+h), vec2(x+w, y+h))
    self:add(Object(), STATIC, EDGE, vec2(x  , y), vec2(x  , y+h))
    self:add(Object(), STATIC, EDGE, vec2(x+w, y), vec2(x+w, y+h))
end

function Fizix:update(dt)
    if not self.running then return end
    
    self:setProperties()

    while dt > 0 do
        self:step(math.min(0.001, dt))
        dt = dt - 0.001
    end
    
    self:collision()

    self:updateProperties()
end

function Fizix:setProperties()
    local item
    for _,body in ipairs(self.bodies) do
        item = body.item
        
        body.x = item.position.x
        body.y = item.position.y
        
        body.previousPosition.x = item.position.x
        body.previousPosition.y = item.position.y

        if item.linearVelocity then
            body.linearVelocity = item.linearVelocity
            item.linearVelocity = nil
        end
    end
end

function Fizix:updateProperties()
    for _,body in ipairs(self.bodies) do
        body.item.position = body.position
        body.item.angle = body.angle
    end
end

function Fizix:step(dt)
    for _,body in ipairs(self.bodies) do
        body:integration(dt)
    end
end

function Fizix:collision()
    self.contacts = Array()

    local bodies = self.bodies
    local contacts = self.contacts

    for i,object in bodies:iterator() do
        object.contact = nil
    end

    for i=1,#bodies do
        local bodyA = bodies[i]

        for j=i+1,#bodies do
            local bodyB = bodies[j]

            if Fizix.Collision.collide(bodyA, bodyB) then
                local contact = Fizix.Contact(bodyA, bodyB)
                contacts:insert(contact)

                bodyA.contact = bodyB
                bodyB.contact = bodyA
            end
        end
    end

    for _,contact in ipairs(contacts) do
        local bodyA = contact.bodyA
        local bodyB = contact.bodyB

        function response(obj)
            if obj.bodyType ~= STATIC then
                obj.linearVelocity = -obj.linearVelocity * obj.restitution
                obj.position = obj.previousPosition
            end
        end
        
        lca.collide(contact)

        response(bodyA)
        response(bodyB)
    end
end

function Fizix:draw()
    if not self.debug then return end
    
    for _,body in ipairs(self.bodies) do
        body:draw(dt)
    end
end
