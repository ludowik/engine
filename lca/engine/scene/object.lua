class('Object', Rect)

function Object:init(label)
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

class('CircleObject', Object)

function CircleObject:init(x, y, radius)
    Object.init(self)

    self.position:set(x, y)
    self.radius = radius
    self.shapeType = CIRCLE
end

function CircleObject:addToPhysics(bodyType)
    return fizix:add(self, bodyType or DYNAMIC, self.shapeType, self.radius)
end

class('RectObject', Object)

function RectObject:init(x, y, w, h)
    Object.init(self)

    self.position:set(x, y)
    self.size:set(w, h)
    self.shapeType = POLYGON
end

function RectObject:addToPhysics(bodyType)
    local x, y, w, h = self.position.x, self.position.y, self.size.x, self.size.y
    return fizix:add(self, bodyType or DYNAMIC, self.shapeType, {
            vec2(x, y),
            vec2(x+w, y),
            vec2(x+w, y+h),
            vec2(x, y+h)
        })
end

class('PolygonObject', Object)

function PolygonObject:init(x, y)
    Object.init(self)

    self.position:set(x, y)
    self.shapeType = POLYGON
end

function PolygonObject:addToPhysics(bodyType)
    return fizix:add(self, bodyType or DYNAMIC, self.shapeType, self.vertices)
end

class('MeshObject', Object)

function MeshObject:init(object, ...)
    Object.init(self)

    self.shapeType = CIRCLE

    self.object = object
    if object then
        object.shader = object.shader or Shader.shaders['default']
    end
end

function MeshObject:addToPhysics(bodyType)
    return fizix:add(self, bodyType or DYNAMIC, self.shapeType, self.radius)
end

function MeshObject:draw()
    pushMatrix()
    do
        if self.position then
            translate(self.position.x, self.position.y, self.position.z)
        end

        if self.scale then
            scale(self.scale.x, self.scale.y, self.scale.z)
        end

        self.object:draw()
    end
    popMatrix()
end
