local physics3d

class('Object3d', Rect3d)

function Object3d:init(x, y, z, w, h, d)
    Rect3d.init(self, x, y, z, w, h, d)

    self.angle = 0

    self.force = vec3()
    self.acceleration = vec3()    
    self.linearVelocity = vec3()    

    self.angularVelocity = 0    

    self.linearDamping = 0.5
    self.angularDamping = 0.5

    self.maxAcceleration = 10
    self.maxSpeed = 10

    self.restitution = 0.8
    self.friction = 1

    self.interpolate = true -- TODO

    self.sleepingAllowed = false -- TODO
    self.keepInArea = false

    self.mass = 1

    self.gravityScale = 1

    self.move = vector()
end

function Object3d:update(dt)
    -- force
    self.acceleration = self.force / self.mass + physics3d.gravity * self.gravityScale * dt
    self.force = vector()

    -- linear
    self.linearVelocity = self.linearVelocity - (1 - self.linearDamping) * self.linearVelocity * dt

    self.linearVelocity = self.linearVelocity + self.acceleration * dt

    local len = self.linearVelocity:len()
    if len > self.maxSpeed then
        self.linearVelocity = self.linearVelocity * self.maxSpeed / len
    end

    self.move.x = self.linearVelocity.x
    self.move.y = self.linearVelocity.y
    self.move.z = self.linearVelocity.z

    self.position = self.position + self.move

    -- angular
    self.angularVelocity = self.angularVelocity - (1 - self.angularDamping) * self.angularVelocity * dt
    self.angle = self.angle + self.angularVelocity * dt
end

class('Shape')

function Shape:init(shapeType)
    self.shapeType = shapeType
end

function Shape:getType()
    return self.shapeType
end

class('Physics3d')

function Physics3d:init(x, y, z)
    physics3d = self

    self.scale = 1

    self.gravity = vector(
        self.scale * (x or 0),
        self.scale * (y or 0),
        self.scale * (z or 0))

    self.running = true    
    self.debug = false

    self.bodies = Table()
end

function Physics3d:setArea(x, y, z, w, h, d)
    self.area = Rect3d(x, y, z, w, h, d)
end

function Physics3d:addItems(items, bodyType, shapeType, groupIndex)
    for i,item in ipairs(items) do
        self:addItem(bodyType, shapeType, groupIndex)
    end
end

function Physics3d:addItem(item, bodyType, shapeType, groupIndex)
    bodyType = bodyType or DYNAMIC
    groupIndex = groupIndex or 1

    item.shape = Shape(shapeType)
    
    self.bodies:add(item)
end

function Physics3d:update(dt)
    for _,item in ipairs(self.bodies) do
        local x1 = item.position.x - item.size.y / 2
        local x2 = item.position.x + item.size.y / 2

        if x1 <= self.area.position.x then
            item.linearVelocity.x = -item.linearVelocity.x * item.restitution
            if item.move then
                item.position.x = item.position.x - item.move.x
            end
        elseif x2 >= self.area.position.x + self.area.size.x then
            item.linearVelocity.x = -item.linearVelocity.x * item.restitution
            if item.move then
                item.position.x = item.position.x - item.move.x
            end
        end

        local z1 = item.position.z - item.size.z / 2
        local z2 = item.position.z + item.size.z / 2

        if z1 <= self.area.position.z then
            item.linearVelocity.z = -item.linearVelocity.z * item.restitution
            if item.move then
                item.position.z = item.position.z - item.move.z
            end
        elseif z2 >= self.area.position.z + self.area.size.z then
            item.linearVelocity.z = -item.linearVelocity.z * item.restitution
            if item.move then
                item.position.z = item.position.z - item.move.z
            end
        end

        local y1 = item.position.y - item.size.y / 2
        if y1 <= self.area.position.y then
            item.linearVelocity.y = -item.linearVelocity.y * item.restitution
            if item.move then
                item.position.y = item.position.y - item.move.y
            end
        end
    end

    for _,item in ipairs(self.bodies) do
        item:update(dt)
    end

    local n = #self.bodies
    for i=1,n-1 do
        local a = self.bodies[i]
        for j=i+1,n do
            local b = self.bodies[j]

            local direction = (b.position - a.position)

            local distance = direction:dist()
            local distanceMin = a.size.x / 2 + b.size.x / 2

            if distance <= distanceMin then
                a.linearVelocity = -a.linearVelocity / 2 - direction:normalize() * b.linearVelocity:len() / 2 
                b.linearVelocity = -b.linearVelocity / 2 + direction:normalize() * a.linearVelocity:len() / 2 

                a.position = a.position - direction:normalize() * (distanceMin - distance) / 2
                b.position = b.position + direction:normalize() * (distanceMin - distance) / 2
            end
        end
    end
end

function Physics3d:draw()
    if not self.debug then return end

    initMode('front', true)

    pushMatrix()
    do
        translate(self.area.position.x, self.area.position.y, self.area.position.z)
        translate(self.area.size.x/2, self.area.size.y/2, self.area.size.z/2)

        scale(self.area.size.x, self.area.size.y, self.area.size.z)

        box()
    end
    popMatrix()

    initMode('back', true)

    for _,item in ipairs(self.bodies) do
        local type = item.shape:getType()

        fill(item.color or white)

        pushMatrix()
        do
            translate(item.position.x, item.position.y, item.position.z)
            scale(item.size.x, item.size.y, item.size.z)

            if type == 'sphere' then
                sphere()
            elseif type == 'box' then
                box()
            end
        end
        popMatrix()
    end
end
