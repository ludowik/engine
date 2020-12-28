Joint = class('love.box2d.Joint')

REVOLUTE = 'revolute'
PRISMATIC = 'prismatic'
DISTANCE = 'distance'
WELD = 'weld'
ROPE = 'rope'

function Joint:init(physics, jointType, ...)
    self.physics = physics    
    self.joint = Joint[jointType](...)
    
    physics.joints[self.joint] = self
end

function Joint.revolute(a, b, anchor)
    return lca.physics.newRevoluteJoint(a.body, b.body, anchor.x, anchor.y, true)
end

function Joint.prismatic(a, b, anchor, direction)
    return lca.physics.newPrismaticJoint(a.body, b.body, anchor.x, anchor.y, direction.x, direction.y, true)
end

function Joint.distance(a, b, anchorA, anchorB)
    return lca.physics.newDistanceJoint(a.body, b.body, anchorA.x, anchorA.y, anchorB.x, anchorB.y, true)
end

function Joint.weld(a, b, anchor)
    return lca.physics.newWeldJoint(a.body, b.body, anchor.x, anchor.y, true)
end

function Joint.rope(a, b, anchorA, anchorB, maxLenght)
    return lca.physics.newRopeJoint(a.body, b.body, anchorA.x, anchorA.y, anchorB.x, anchorB.y, maxLenght)
end

function Joint:destroy()
    if not self.joint:isDestroyed() then
        self.joint:destroy()
    end
end

function Joint.properties.get:anchorA()
    local x, y = self.joint:getAnchors()
    return vec3(x, y)
end

function Joint.properties.get:anchorB()
    local _, _, x, y = self.joint:getAnchors()
    return vec3(x, y)
end

