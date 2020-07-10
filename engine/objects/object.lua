Object = class('Object', Rect)

function Object:init(label)
    Rect.init(self)
    
    self.label = label or ''

    self.position = vec3()
    self.absolutePosition = vec3()

    self.size = vec3()
    self.fixedSize = nil
    self.gridSize = nil
end

function Object:update(dt)
end

function Object:draw()
    rect(self.position.x, self.position.y, self.size.x, self.size.y)
end

function Object:addToPhysics(bodyType)
    assert()
end

function Object:setFixedSize(x, y)
    x = x or ws()
    y = y or hs()

    self.fixedSize = vec2(x, y)
    return self
end

function Object:setGridSize(i, j)
    i = i or 1
    j = j or 1

    self.gridSize = vec2(i, j)
    return self
end
