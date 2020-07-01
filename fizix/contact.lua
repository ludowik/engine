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
        if self.bodyA and classnameof(self.bodyA.item) == className then
            items[i] = self.bodyA.item
        elseif self.bodyB and classnameof(self.bodyB.item) == className then
            items[i] = self.bodyB.item
        end        
    end

    return unpack(items)
end
