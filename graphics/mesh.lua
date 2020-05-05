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

        local bytes = ffi.new('GLfloat[?]', #self.vertices, self.vertices)
        
        gl.glBufferData(gl.GL_ARRAY_BUFFER, #self.vertices * ffi.sizeof('GLfloat'), bytes, gl.GL_STATIC_DRAW)
        
        gl.glVertexAttribPointer(self.buffer, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.NULL)
        
        gl.glEnableVertexAttribArray(self.buffer)

        do
            shader:use()

            gl.glDrawArrays(gl.GL_TRIANGLES, 0, #self.vertices / 3)

            shader:unuse()
        end
        
        gl.glDisableVertexAttribArray(self.buffer)

        bytes = nil

    end

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
    gl.glDeleteBuffer(self.buffer)
end

Mesh:extends(MeshRender)
