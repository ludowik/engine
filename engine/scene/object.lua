Object = class('Object', Rect)

function Object:init(label)
    Rect.init(self)

    self.label = label or ''

    self.fixedSize = nil
    self.gridSize = nil
end

function Object:update(dt)
    if self.body then
        self.position = self.body.position
    end
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
