class('Contact')

function Contact:init(physics, contact)
    self.id = contact

    local fixtureA, fixtureB = contact:getFixtures()
    self.bodyA = physics.bodies[fixtureA:getBody()]
    self.bodyB = physics.bodies[fixtureB:getBody()]
    
    self:update(contact)
end

function Contact:get(...)
    local args = {...}
    
    local items = {}
    for i,className in ipairs(args) do
        if self.bodyA and self.bodyA.item.className == className then
            items[i] = self.bodyA.item
        elseif self.bodyB and self.bodyB.item.className == className then
            items[i] = self.bodyB.item
        end        
    end

    return unpack(items)
end

function Contact:update(contact, state)
    if self.state == nil then
        self.state = BEGAN
    else
        self.state = MOVING
    end

    local x1, y1 = contact:getPositions()
    local xn, yn = contact:getNormal()

    self.position = vector(x1, y1) 
    self.normal = vector(xn, yn)
end

function Contact:destroy(contact)
    self.state = ENDED
end

function Contact.properties.get:points()
    local x1, y1, x2, y2 = self.id:getPositions()
    local points = {
        vec2(x1, y1)
    }

    if x2 and y2 then
        table.insert(points, vec2(x2, y2))
    end

    return points
end
