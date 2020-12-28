class('Object', Rect, Attribs)

function Object:init(x, y, w, h)
    Rect.init(self, x, y, w, h)
    Attribs.init(self)

    self.restitution = 0.3
    self.friction = 0.2
end

function Object:update(dt)
end

function Object:addToPhysics(bodyType)
    currentEnv.physics:addItem(self, bodyType or DYNAMIC, 'circle')
end
