class 'Mesh'

function Mesh:init(vertices)
    self.attributes = {}

    self.vertices = vertices or {}

    self.texCoords = {
        0,0,
        1,0,
        1,1,
        0,0,
        1,1,
        0,1
    }
end

class 'MeshRender'

local sizeofFloat = 4 -- ffi.sizeof('GLfloat')

function MeshRender:sendAttribute(attributeName, data, nComponents)
    if self.attributes[attributeName] == nil then
        self.attributes[attributeName] = {
            attribLocation = gl.glGetAttribLocation(self.shader.program_id, attributeName),
            id = gl.glGenBuffer()
        }
    end

    local attribute = self.attributes[attributeName]
    if attribute.attribLocation >= 0 then
        local n = #data

        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, attribute.id)

        if attribute.bytes == nil or attribute.bytes_size < n then
            attribute.bytes = ffi.new('GLfloat[?]', n)
            attribute.bytes_size = n
        end

        for i=1,n do
            attribute.bytes[i-1] = data[i]
        end

        gl.glBufferData(gl.GL_ARRAY_BUFFER, n * sizeofFloat, attribute.bytes, gl.GL_STATIC_DRAW)

        gl.glVertexAttribPointer(attribute.attribLocation, nComponents, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.NULL)
        gl.glEnableVertexAttribArray(attribute.attribLocation)

        return attribute
    end
end

function MeshRender:render(shader, drawMode, img, x, y, w, h)
    assert(shader)
    assert(drawMode)

    x = x or 0
    y = y or 0
    w = w or 1
    h = h or 1

    self.shader = shader

    do
        shader:use()

        local vertexAttrib = self:sendAttribute('vertex', self.vertices, 3)
        local pointAttrib = self:sendAttribute('point', self.points, 2)
        local texCoordsAttrib = self:sendAttribute('texCoords', self.texCoords, 2)

        if img then
            local textureUniforms = gl.glGetUniformLocation(shader.program_id, 'tex0')
            gl.glUniform1i(textureUniforms, 0)

            img:use(gl.GL_TEXTURE0)
        end

        local matrixProjectionUniforms = gl.glGetUniformLocation(shader.program_id, 'matrixProjection')
        if matrixProjectionUniforms >= 0 then
            gl.glUniform4f(matrixProjectionUniforms,
                x + transform.x,
                y + transform.y,
                transform.w,
                transform.h
            )
        end
        
        local matrixModelUniforms = gl.glGetUniformLocation(shader.program_id, 'matrixModel')
        if matrixModelUniforms >= 0 then
            gl.glUniform4f(matrixModelUniforms,
                w, h, 0, 0
            )
        end

        if vertexAttrib then
            gl.glDrawArrays(drawMode, 0, #self.vertices / 3)
        else
            gl.glDrawArrays(drawMode, 0, #self.points / 2)
        end

        if img then
            img:unuse()
        end

        for attributeName,attribute in pairs(self.attributes) do
            if attribute.attribLocation >= 0 then
                gl.glDisableVertexAttribArray(attribute.attribLocation)
            end
        end

        shader:unuse()
    end

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
end

Mesh:extends(MeshRender)
