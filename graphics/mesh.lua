class 'Mesh'

function Mesh:init(vertices)
    self.vertices = vertices or {0, 0, 0, 1, 0, 0, 1, 1, 0}
end

class 'MeshRender'

function MeshRender:render(shader)
    shader = shader or defaultShader

    self.buffer = gl.glGenBuffer()
    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.buffer)

    do
        shader:use()

        local bytes = ffi.new('GLfloat[?]', #self.vertices, self.vertices)

        gl.glBufferData(gl.GL_ARRAY_BUFFER, #self.vertices * ffi.sizeof('GLfloat'), bytes, gl.GL_STATIC_DRAW)

        local vertexLocation = gl.glGetAttribLocation(shader.program_id, 'vertex')
        gl.glVertexAttribPointer(vertexLocation, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.NULL)

        gl.glEnableVertexAttribArray(vertexLocation)

        do

            gl.glDrawArrays(gl.GL_TRIANGLES, 0, #self.vertices)

        end

        gl.glDisableVertexAttribArray(self.buffer)

        bytes = nil

        shader:unuse()
    end

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
    gl.glDeleteBuffer(self.buffer)
end

Mesh:extends(MeshRender)
