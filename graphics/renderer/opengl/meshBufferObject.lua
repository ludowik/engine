BufferObject = class('')

BufferObject.count = 0

function BufferObject:init(type)
    self.type = type or gl.GL_ARRAY_BUFFER
    self.id = 0
    self.size = 0
end

function BufferObject:generate()
    self:release()
    self.id = gl.glGenBuffer()
    BufferObject.count = BufferObject.count + 1
end

function BufferObject:release()
    if self:isBufferObject() then
        gl.glDeleteBuffer(self.id)
        self.id = 0
        self.size = 0
        BufferObject.count = BufferObject.count - 1
    end
end

function BufferObject:isBufferObject()
    return self.id > 0 and gl.glIsBuffer(self.id) == gl.GL_TRUE
end

function BufferObject:bind()
    gl.glBindBuffer(self.type, self.id)
end

function BufferObject:unbind()
    gl.glBindBuffer(self.type, 0)
end
