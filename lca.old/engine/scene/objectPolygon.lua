class('PolygonObject', Object)

function PolygonObject:init(...)
    Object.init(self, ...)
end

function PolygonObject:addToPhysics(bodyType)
    local vertices = vectors2vertices(self.vertices)
    currentEnv.physics:addItem(self,
        bodyType or DYNAMIC, 'polygon', nil, nil, nil, vertices)
end
