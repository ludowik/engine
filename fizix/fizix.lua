Fizix = class('Fizix')

Gravity = vec3(0, -9.81)

function Fizix.setup()
    Physics2d = Fizix
    Physics3d = Fizix

    Object2d = Object
    Object3d = Object
end

function Fizix:init()
    fizix = self
    env.physics = self

    self.bodies = Array()
    self.contacts = Array()

    self.g = vec3(0, -9.81)

    self.pixelRatio = 32
    self.debug = true

    self.deltaTime = 0
    self.elapsedTime = 0

    self:resume()
end

function Fizix:gravity(...)
    self.g:set(...)
    return self.g
end

function Fizix:joint(...)
    return Fizix.Joint(...)
end

function Fizix:pause()
    self.running = false
end

function Fizix:resume()
    self.running = true
end

function Fizix:body(...)
    return self:add(nil, DYNAMIC, ...)
end

function Fizix:add(item, bodyType, ...)
    --assert(item)
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
    self:add(Object(), STATIC, EDGE, vec3(x, y  ), vec3(x+w, y  ))
    self:add(Object(), STATIC, EDGE, vec3(x, y+h), vec3(x+w, y+h))
    self:add(Object(), STATIC, EDGE, vec3(x  , y), vec3(x  , y+h))
    self:add(Object(), STATIC, EDGE, vec3(x+w, y), vec3(x+w, y+h))
end

function Fizix:update(dt)
    if not self.running then return end

    local startTime = sdl.SDL_GetTicks() * 0.001

    self:setProperties()
    do
        local ds = dt -- 0.015
        while dt > 0 do
            self:step(ds)
            dt = dt - ds
        end
        if dt < 0 then
            assert()
            self:step(-dt)
        end
        
        -- TODO : collision each step, no ?
        self:collision()
    end
    self:updateProperties()

    local endTime = sdl.SDL_GetTicks() * 0.001

    self.deltaTime = endTime - startTime
    self.elapsedTime = self.elapsedTime + self.deltaTime
end

function Fizix:setProperties()
    local item
    for _,body in ipairs(self.bodies) do
        item = body.item
        if item then
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
end

function Fizix:updateProperties()
    for _,body in ipairs(self.bodies) do
        if body.item then
            body.item.position = body.position
            body.item.angle = body.angle
        end
    end
end

-- TODO : body or object => fix this
function Fizix:step(dt)
    for _,body in ipairs(self.bodies) do
        if body.type == DYNAMIC then
            body:integration(dt)
        end
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
            if obj.type == DYNAMIC then
                obj.linearVelocity = -obj.linearVelocity * obj.restitution
                obj.position = obj.previousPosition
            end
        end

        env.app:__collide(contact)

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
