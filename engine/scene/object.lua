class 'Object' : extends(Rect)

function Object:init(label, ...)
    Rect.init(self, ...)

    if label and #label > 0 then
        self.label = label
    else
        self.label = self.__className..id(self.__className)
    end
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

Object2D  = Object
Object3D  = Object
