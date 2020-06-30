local Contact = class('Fizix.Contact')

Fizix.Contact = Contact

function Contact:init(bodyA, bodyB)
    self.bodyA = bodyA
    self.bodyB = bodyB
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
