class 'Mesh'

function Mesh:init(vertices)
    self.vertices = vertices or {}
end

class 'MeshRender'

local sizeofFloat = 4 -- ffi.sizeof('GLfloat')

function MeshRender:sendAttribute(attributeName, data, nComponents)
    local attribute = self.shader.attributes[attributeName]
    if attribute and attribute.attribLocation >= 0 then
        local n = #data

        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, attribute.id)

        local bytes
        if type(data) == 'table' then
            if attribute.bytes == nil or attribute.bytes_size < n then
                attribute.bytes = ffi.new('GLfloat[?]', n)
                attribute.bytes_size = n
            end

            for i=1,n do
                attribute.bytes[i-1] = data[i]
            end

            bytes = attribute.bytes
        else
            bytes = data:tobytes()
        end

        gl.glBufferData(gl.GL_ARRAY_BUFFER, n * sizeofFloat, bytes, gl.GL_STATIC_DRAW)

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

        self:sendUniforms(shader)

        local vertexAttrib = self:sendAttribute('vertex', self.vertices, 3)
        local pointAttrib = self:sendAttribute('point', self.points, 2)
        local texCoordsAttrib = self:sendAttribute('texCoords', self.texCoords, 2)

        if img then
            local textureUniforms = shader.uniforms.tex0.uniformLocation
            gl.glUniform1i(textureUniforms, 0)

            img:use(gl.GL_TEXTURE0)
        end

        local matrixProjectionUniforms = shader.uniforms.matrixProjection.uniformLocation
        if matrixProjectionUniforms >= 0 then
            gl.glUniform4f(matrixProjectionUniforms,
                x + transform.x,
                y + transform.y,
                transform.w,
                transform.h
            )
        end

        local matrixModelUniforms = shader.uniforms.matrixModel.uniformLocation
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

        for attributeName,attribute in pairs(self.shader.attributes) do
            gl.glDisableVertexAttribArray(attribute.attribLocation)
        end

        shader:unuse()
    end

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
end

function MeshRender:sendUniforms(shader)
    local strokeLocation = gl.glGetUniformLocation(shader.program_id, 'stroke')
    if strokeLocation >= 0 then
        gl.glUniform4fv(strokeLocation, 1, stroke():tobytes())
    end
end

Mesh:extends(MeshRender)
