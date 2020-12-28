class('MeshObject', PolygonObject)

function MeshObject:init(object, ...)
    PolygonObject.init(self, ...)
    self.object = object
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
