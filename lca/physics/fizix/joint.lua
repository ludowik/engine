local Joint = class('Fizix.Joint')

Fizix.Joint = Joint

function Joint.setup()
    REVOLUTE = REVOLUTE or 'revolute'
    PRISMATIC = PRISMATIC or 'prismatic'
    DISTANCE = DISTANCE or 'distance'
    WELD = WELD or 'weld'
    ROPE = ROPE or 'rope'
end

function Joint:init(jointType, anchorA, anchorB)
    self.anchorA = anchorA
    self.anchorB = anchorB
end

function Joint:destroy()
end
