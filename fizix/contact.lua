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
        if self.bodyA and classnameof(self.bodyA.info) == className then
            items[i] = self.bodyA.info
        elseif self.bodyB and classnameof(self.bodyB.info) == className then
            items[i] = self.bodyB.info
        else
            items[i] = false
        end
    end

    return unpack(items)
end
