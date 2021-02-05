Fizix = class('Fizix')

function Fizix.setup()
    Gravity = vec3(0, -9.81)
end

function Fizix:init()
    env.fizix = self

    self.bodies = Array()
    self.contacts = Array()

    self.worldCenter = vec2()

    self.pixelRatio = 32

    self.gravityForce = vec3(0, -9.81) * self.pixelRatio

    self.debug = true

    self.deltaTime = 0
    self.elapsedTime = 0
    self.remainTime = 0

    self:resume()
end

function Fizix:gravity(...)
    self.gravityForce:set(...)
    return self.gravityForce
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

function Fizix:draw()
    for _,body in ipairs(self.bodies) do
        body:draw()
    end
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

    local startTime = sdl.getTicks() * 0.001

    self:setProperties()
    do
        dt = dt + self.remainTime
        
        local ds = max(min(0.015, dt), 0.015)
        while dt >= ds do
            self:step(ds)
            dt = dt - ds
        end
        
        self.remainTime = dt
    end
    self:updateProperties()

    local endTime = sdl.getTicks() * 0.001

    self.deltaTime = endTime - startTime
    self.elapsedTime = self.elapsedTime + self.deltaTime
end

function Fizix:setProperties()
    local item
    for _,body in ipairs(self.bodies) do
        item = body.item
        if item then
            -- est-ce la bonne méthode : pour l'initialisation ok mais après ????
--            body.position.x = item.position.x
--            body.position.y = item.position.y

--            body.previousPosition.x = item.position.x
--            body.previousPosition.y = item.position.y

            if item.linearVelocity then
                assert() -- pas la bonne méthode -> changer la velocity directement
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

function Fizix:step(dt)
    for _,body in ipairs(self.bodies) do
        if body.type == DYNAMIC then
            body:integration(dt)
        end

        if body.keepInArea then
            -- TODO : usefull ?
            if body.position.x < -screen.W/2 then
                body.position.x = body.position.x + screen.W
            elseif body.position.x > screen.W/2 then
                body.position.x = body.position.x - screen.W
            end

            if body.position.y < -screen.H/2 then
                body.position.y = body.position.y + screen.H
            elseif body.position.y > screen.H/2 then
                body.position.y = body.position.y - screen.H
            end
        end
    end
    self:collision()
end

function Fizix:canCollide(categories, mask)
    for categoryA in ipairs(categories) do
        for categoryB in ipairs(mask) do
            if categoryA == categoryB then
                return true
            end
        end
    end
    return false
end

function Fizix:collision()
    self.contacts = Array()

    local bodies = self.bodies
    local contacts = self.contacts

    for i,body in bodies:iterator() do
        body.contact = nil
    end

    for i=1,#bodies-1 do
        local bodyA = bodies[i]

        for j=i+1,#bodies do
            local bodyB = bodies[j]

            if self:canCollide(bodyA.categories, bodyB.mask) then
                if Fizix.Collision.collide(bodyA, bodyB) then
                    local contact = Fizix.Contact(bodyA, bodyB)
                    contacts:insert(contact)

                    bodyA.contact = bodyB
                    bodyB.contact = bodyA
                end
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

-- Performs a raycast from the start point to the end point.
-- Any additional parameters are treated as category filters, allowing certain bodies to be ignored.
-- This function only returns hit information on the closest rigid body detected.
function Fizix:raycast(from, to, category1, category2)
    -- TODO : raycast
end

-- Performs a raycast from the start point to the end point.
-- Any additional parameters are treated as category filters, allowing certain bodies to be ignored.
-- This function returns an array of tables describing all objects hit along the ray, ordered from closest to farthest.
function Fizix:raycastAll(from, to, category1, category2)
    -- TODO : raycastAll
    return {}
end

-- Performs a query to find all bodies within the supplied axis-aligned bounding box.
-- Any additional parameters are treated as category filters, allowing certain bodies to be ignored.
function Fizix:queryAABB(lowerLeft, upperRight, category1, category2)
    -- TODO : queryAABB
    return {}
end
