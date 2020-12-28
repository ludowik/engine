VertexArray = class('vertex_array')
VertexArray.count = 0

function VertexArray:init()
    self.id = 0
    self.size = 0
end

function VertexArray:generate()
    self:release()
    self.id = gl.glGenVertexArray()
    VertexArray.count = VertexArray.count + 1
end

function VertexArray:release()
    if self:isVertexArray() then
        gl.glDeleteVertexArray(self.id)
        self.id = 0
        self.size = 0
        VertexArray.count = VertexArray.count - 1
    end
end

function VertexArray:isVertexArray()
    return self.id > 0 and gl.glIsVertexArray(self.id) == gl.GL_TRUE
end

function VertexArray:bind()
    gl.glBindVertexArray(self.id)
end

function VertexArray:unbind()
    gl.glBindVertexArray(0)
end
