class 'Mesh'

function Mesh:init(vertices)
    self.vertices = vertices or {}
end

class 'MeshRender'

local bytes = nil
local bytes_len = 0

function MeshRender:render(shader)
    shader = shader or defaultShader

    self.buffer = self.buffer or gl.glGenBuffer()
    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.buffer)

    do
        shader:use()

        if bytes == nil or #self.vertices > bytes_len then
            bytes = ffi.new('GLfloat[?]', #self.vertices, self.vertices)
            bytes_len = #self.vertices
        end

        gl.glBufferData(gl.GL_ARRAY_BUFFER, #self.vertices * ffi.sizeof('GLfloat'), bytes, gl.GL_STATIC_DRAW)

        local vertexLocation = gl.glGetAttribLocation(shader.program_id, 'vertex')
        gl.glVertexAttribPointer(vertexLocation, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.NULL)

        gl.glEnableVertexAttribArray(vertexLocation)

        gl.glDrawArrays(gl.GL_POINTS, 0, #self.vertices / 3)

        gl.glDisableVertexAttribArray(self.buffer)

        bytes = nil

        shader:unuse()
    end

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
    gl.glDeleteBuffer(self.buffer)
end

Mesh:extends(MeshRender)
