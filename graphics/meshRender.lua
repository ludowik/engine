class 'MeshRender'

local sizeofFloat = 4 -- ffi.sizeof('GLfloat')

function MeshRender:sendAttribute(attributeName, buffer, nComponents)
    local attribute = self.shader.attributes[attributeName]

    if attribute and buffer and #buffer > 0 then

        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, attribute.id)

        local n = #buffer

        if (attribute.sent == nil or attribute.sent ~= n or
            buffer.id == nil or buffer.id ~= attribute.bufferId or
            buffer.version == nil or buffer.version ~= attribute.bufferVersion)
        then
            attribute.sent = n
            attribute.bufferVersion = buffer.version
            attribute.bufferId = buffer.id

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

function MeshRender:render(shader, drawMode, img, x, y, z, w, h, d)
    assert(shader)
    assert(drawMode)

    x = x or 0
    y = y or 0
    z = z or 0
    
    w = w or 1
    h = h or 1
    d = d or 1

    self.shader = shader

    do
        shader:use()

        self:sendUniforms(shader.uniforms)

        if config.glMajorVersion >= 4 then
            shader.vao = shader.vao or gl.glGenVertexArray()
            gl.glBindVertexArray(shader.vao)
        end

        local vertexAttrib = self:sendAttribute('vertex', self.vertices, 3)
        assert(vertexAttrib, shader.name..':'..#self.vertices)

        local colorAttrib = self:sendAttribute('color', self.colors, 4)
        local texCoordsAttrib = self:sendAttribute('texCoords', self.texCoords, 2)

        if img and shader.uniforms.tex0 then
            if shader.uniforms.useTexture then
                gl.glUniform1i(shader.uniforms.useTexture.uniformLocation, 1)
            end
            
            gl.glUniform1i(shader.uniforms.tex0.uniformLocation, 0)
            
            img:update()
            img:use(gl.GL_TEXTURE0)
        else
            if shader.uniforms.useTexture then
                gl.glUniform1i(shader.uniforms.useTexture.uniformLocation, 0)
            end
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
            gl.glUniform3f(shader.uniforms.pos.uniformLocation, x, y, z)
        end

        if shader.uniforms.size then
            gl.glUniform3f(shader.uniforms.size.uniformLocation, w, h, d)
        end


        -- TODO gérer les indices
        --        gl.glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.buffers.indices)
        --        gl.bufferData(gl.GL_ELEMENT_ARRAY_BUFFER,
        --            self:bufferData(
        --                Uint16Array,
        --                'indices',
        --                1),
        --            gl.GL_STATIC_DRAW)

        --        vertexCount = #self.indices
        --        dataType = gl.GL_UNSIGNED_SHORT
        --        offset = 0

        --        gl.glDrawElementsInstanced(self.drawMode, vertexCount, dataType, gl.glBufferOffset(offset), 1)

        -- TODO gérer le multi-instances
        --        local offset = 0
        --        for i=0,3 do
        --            gl.glVertexAttribPointer(LOCATION_INSTANCE_MODEL_MATRIX+i, 4, gl.GL_FLOAT, gl.GL_FALSE, sizeStruct, offset)
        --            gl.glVertexAttribDivisor(LOCATION_INSTANCE_MODEL_MATRIX+i, 1)
        --            gl.glEnableVertexAttribArray(LOCATION_INSTANCE_MODEL_MATRIX+i)

        --            offset = offset + floatSize4
        --        end

        --        gl.glVertexAttribPointer(LOCATION_INSTANCE_COLORS, 4, gl.GL_FLOAT, gl.GL_FALSE, sizeStruct, offset)
        --        gl.glVertexAttribDivisor(LOCATION_INSTANCE_COLORS, 1)
        --        gl.glEnableVertexAttribArray(LOCATION_INSTANCE_COLORS)
        --        offset = offset + floatSize4

        --        gl.glVertexAttribPointer(LOCATION_INSTANCE_WIDTH, 1, gl.GL_FLOAT, gl.GL_FALSE, sizeStruct, offset)
        --        gl.glVertexAttribDivisor(LOCATION_INSTANCE_WIDTH, 1)
        --        gl.glEnableVertexAttribArray(LOCATION_INSTANCE_WIDTH)

        config.wireframe = 'fill'

        if img and shader.uniforms.tex0 or config.wireframe == 'fill' or config.wireframe == 'fill&line'  then
            gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_FILL)
            gl.glDrawArrays(drawMode, 0, #self.vertices)
        end

        if img == nil and (config.wireframe == 'line' or config.wireframe == 'fill&line') then
            gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_LINE)
            gl.glDrawArrays(drawMode, 0, #self.vertices)
        end

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
    
    if uniforms.tint and styles.attributes.tint then
        gl.glUniform4fv(uniforms.tint.uniformLocation, 1, styles.attributes.tint:tobytes())
    end

    if uniforms.useColor then
        if self.colors and #self.colors > 0 then
            gl.glUniform1i(uniforms.useColor.uniformLocation, 1)
        else
            gl.glUniform1i(uniforms.useColor.uniformLocation, 0)
        end
    end
end
