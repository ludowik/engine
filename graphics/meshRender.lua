class 'MeshRender'

local sizeofFloat = 4 -- ffi.sizeof('GLfloat')

function MeshRender:sendAttribute(attributeName, buffer, nComponents)
    local attribute = self.shader.attributes[attributeName]

    if attribute and buffer and #buffer > 0 then

        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, attribute.id)

        local n = #buffer

        -- TODO : gérer la version correctement
        if true or not attribute.sent or attribute.sent ~= n or attribute.version ~= buffer.version then
            attribute.sent = n
            attribute.version = buffer.version

            local bytes
            if type(buffer) == 'table' then
                if type(buffer[1]) == 'number' then
                    buffer = Buffer('float', buffer)

                elseif ffi.typeof(buffer[1]) == __vec2 then
                    buffer = Buffer('vec2', buffer)

                elseif ffi.typeof(buffer[1]) == __vec3 then
                    buffer = Buffer('vec3', buffer)

                elseif ffi.typeof(buffer[1]) == __color then
                    buffer = Buffer('color', buffer)

                else
                    error(ffi.typeof(buffer[1]))
                end
            end

            gl.glBufferData(gl.GL_ARRAY_BUFFER, buffer:sizeof(), buffer:tobytes(), gl.GL_STATIC_DRAW)
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

        self:sendUniforms(shader.uniforms)

        if config.glMajorVersion >= 4 then
            shader.vao = shader.vao or gl.glGenVertexArray()
            gl.glBindVertexArray(shader.vao)
        end

        local vertexAttrib = self:sendAttribute('vertex', self.vertices, 3)
        assert(vertexAttrib)
        
        local texCoordsAttrib = self:sendAttribute('texCoords', self.texCoords, 2)

        if img and shader.uniforms.tex0 then
            gl.glUniform1i(shader.uniforms.tex0.uniformLocation, 0)
            img:use(gl.GL_TEXTURE0)
        end

        if shader.uniforms.matrixPV then
            local matrixPV = pvMatrix()

            if shader.matrixPV ~= matrixPV then
                shader.matrixPV = matrixPV
                gl.glUniformMatrix4fv(shader.uniforms.matrixPV.uniformLocation, 1, gl.GL_TRUE, matrixPV:tobytes())
            end
        end

        if shader.uniforms.matrixModel then
            local matrixModel = modelMatrix()

            if shader.matrixModel ~= matrixModel then
                shader.matrixModel = matrixModel
                gl.glUniformMatrix4fv(shader.uniforms.matrixModel.uniformLocation, 1, gl.GL_TRUE, matrixModel:tobytes())
            end
        end

        if shader.uniforms.pos then
            gl.glUniform3f(shader.uniforms.pos.uniformLocation, x, y, 0)
        end

        if shader.uniforms.size then
            gl.glUniform3f(shader.uniforms.size.uniformLocation, w, h, 1)
        end

        gl.glDrawArrays(drawMode, 0, #self.vertices)

        if img then
            img:unuse()
        end

        for attributeName,attribute in pairs(self.shader.attributes) do
            gl.glDisableVertexAttribArray(attribute.attribLocation)
        end

        if config.glMajorVersion >= 4 then
            gl.glBindVertexArray(0)
        end

        shader:unuse()
    end

    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
end

function MeshRender:sendUniforms(uniforms)
    if uniforms.stroke and styles.attributes.stroke then
        gl.glUniform4fv(uniforms.stroke.uniformLocation, 1, styles.attributes.stroke:tobytes())
    end

    if uniforms.strokeWidth and styles.attributes.strokeWidth then
        gl.glUniform1f(uniforms.strokeWidth.uniformLocation, styles.attributes.strokeWidth)
    end

    if uniforms.fill and styles.attributes.fill then
        gl.glUniform4fv(uniforms.fill.uniformLocation, 1, styles.attributes.fill:tobytes())
    end
end
