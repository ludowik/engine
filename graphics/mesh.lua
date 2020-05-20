class 'Mesh'

function Mesh:init(vertices)
    self.vertices = vertices or {}
end

class 'MeshRender'

local sizeofFloat = 4 -- ffi.sizeof('GLfloat')

function MeshRender:sendAttribute(attributeName, data, nComponents)
    local attribute = self.shader.attributes[attributeName]

    if attribute then
        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, attribute.id)

        local n = #data
        if not attribute.sent or attribute.sent ~= n then
            attribute.sent = n

            local bytes
            if type(data) == 'table' then
                assert()
            else
                bytes = data:tobytes()
            end

            gl.glBufferData(gl.GL_ARRAY_BUFFER, n * sizeofFloat, bytes, gl.GL_STATIC_DRAW)
        end

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

        if img and shader.uniforms.tex0 then
            gl.glUniform1i(shader.uniforms.tex0.uniformLocation, 0)
            img:use(gl.GL_TEXTURE0)
        end

        if shader.uniforms.matrixProjection then
            local matrixProjection = pvMatrix()

            local matrixModel = modelMatrix()
            :translate(x, y, 0)
            :scale(w, h, 1)

            gl.glUniformMatrix4fv(shader.uniforms.matrixProjection.uniformLocation, 1, gl.GL_TRUE, matrixProjection:tobytes())
            gl.glUniformMatrix4fv(shader.uniforms.matrixModel.uniformLocation, 1, gl.GL_TRUE, matrixModel:tobytes())
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
    if shader.uniforms.stroke and stroke() then
        gl.glUniform4fv(shader.uniforms.stroke.uniformLocation, 1, stroke():tobytes())
    end
    if shader.uniforms.fill and fill() then
        gl.glUniform4fv(shader.uniforms.fill.uniformLocation, 1, fill():tobytes())
    end
end

Mesh:extends(MeshRender)