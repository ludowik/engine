class 'MeshRender'

function MeshRender:init()
    config.wireframe = config.wireframe or 'fill'
end

function MeshRender:render(shader, drawMode, img, x, y, z, w, h, d, strokeWidth, nInstances)
    assert(shader)
    assert(drawMode)

    self.shader = shader
    self.img = img

    x = x or 0
    y = y or 0
    z = z or zLevel()

    w = w or 1
    h = h or 1
    d = d or 1

    self.pos = vec3(x, y, z)
    self.size = vec3(w, h, d)

    self.shader.uniforms.strokeWidth = strokeWidth

    if self.texture then
        if type(self.texture) == 'string' then
            img = resourceManager:get('image', self.texture, image)
        else
            img = self.texture
        end
    end

    do
        shader:use()

        if config.glMajorVersion >= 4 then
            if shader.vao == nil then
                shader.vao = gl.glGenVertexArray()
                log('shader.vao: '..shader.vao)
            end
            gl.glBindVertexArray(shader.vao)
        end

        self:sendAttributes('vertex', self.vertices, 3)
        self:sendAttributes('color', self.colors, 4)
        self:sendAttributes('texCoords', self.texCoords, 2)
        self:sendAttributes('normal', self.normals, 3)

        self:sendIndices('indice', self.indices, 1)            

        self:sendUniforms(shader.uniformsLocations)

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

        if not ios then
            if img or config.wireframe == 'fill' or config.wireframe == 'fill&line'  then
                gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_FILL)

                if self.indices then
                    gl.glDrawElementsInstanced(drawMode, #self.indices, gl.GL_UNSIGNED_SHORT, NULL, nInstances or 1)
                else
                    gl.glDrawArraysInstanced(drawMode, 0, #self.vertices, nInstances or 1)
                end
            end

            if img then
                img:unuse()
            end

            if config.wireframe == 'line' or config.wireframe == 'fill&line' then
                if shader.uniformsLocations.stroke then
                    gl.glUniform4fv(shader.uniformsLocations.stroke.uniformLocation, 1, red:tobytes())
                end
                if shader.uniformsLocations.fill then
                    gl.glUniform4fv(shader.uniformsLocations.fill.uniformLocation, 1, red:tobytes())
                end

                gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_LINE)
                if self.indices then
                    gl.glDrawElementsInstanced(drawMode, #self.indices, gl.GL_UNSIGNED_SHORT, NULL, nInstances or 1)
                else
                    gl.glDrawArraysInstanced(drawMode, 0, #self.vertices, nInstances or 1)
                end
            end
        else
            gl.glDrawArraysInstanced(drawMode, 0, #self.vertices, nInstances or 1)

            if img then
                img:unuse()
            end
        end

        for attributeName,attribute in pairs(shader.attributes) do
            if attribute.enable then
                gl.glDisableVertexAttribArray(attribute.attribLocation)
            end
        end

        if config.glMajorVersion >= 4 then
            gl.glBindVertexArray(0)
        end

        shader:unuse()
    end
end

function MeshRender:sendAttributes(attributeName, buffer, nComponents, bufferType)
    bufferType = bufferType or gl.GL_ARRAY_BUFFER

    local attribute = self.shader.attributes[attributeName]
    if attribute and buffer and #buffer > 0 then
        self:sendBuffer(attributeName, attribute, buffer, nComponents, bufferType)

        gl.glVertexAttribPointer(attribute.attribLocation, nComponents, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.NULL)
        gl.glEnableVertexAttribArray(attribute.attribLocation)

        attribute.enable = true

        return attribute
    end
end

function MeshRender:sendIndices(attributeName, buffer, nComponents, bufferType)
    bufferType = bufferType or gl.GL_ELEMENT_ARRAY_BUFFER

    local attribute = self.shader.attributes[attributeName]
    if attribute and buffer and #buffer > 0 then        
        self:sendBuffer(attributeName, attribute, buffer, nComponents, bufferType)
    end
end

function MeshRender:sendBuffer(attributeName, attribute, buffer, nComponents, bufferType)
    gl.glBindBuffer(bufferType, attribute.id)

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
                nComponents = 1

            elseif ffi.typeof(buffer[1]) == __vec2 then
                buffer = Buffer('vec2', buffer)
                nComponents = 2

            elseif ffi.typeof(buffer[1]) == __vec3 then
                buffer = Buffer('vec3', buffer)
                nComponents = 3

            elseif ffi.typeof(buffer[1]) == __color then
                buffer = Buffer('color', buffer)
                nComponents = 4

            else
                error(ffi.typeof(buffer[1]))
            end

            log(getFunctionLocation(buffer.id, 2))
            log('convert buffer '..buffer.id..' ('..tostring(buffer)..') for shader '..self.shader.name)
        end

        log(string.format('send buffer {attributeName} (id:{id}, version:{version}) to shader {shaderName}', {
                    attributeName = attributeName,
                    id = buffer.id,
                    version = buffer.version,
                    shaderName = self.shader.name}))

        gl.glBufferData(bufferType, buffer:sizeof(), buffer:tobytes(), gl.GL_STATIC_DRAW)
    end
end

function MeshRender:sendUniforms(uniformsLocations)
    local shader = self.shader
    local img = self.img

    if img then
        img:update()
        img:use(gl.GL_TEXTURE0)

        shader.uniforms.useTexture = 1
        shader.uniforms.tex0 = 0
    else
        shader.uniforms.useTexture = 0
    end

    shader.uniforms.matrixPV = pvMatrix()
    shader.uniforms.matrixModel = modelMatrix()

    shader.uniforms.pos = self.pos
    shader.uniforms.size = self.size

    shader.uniforms.time = ElapsedTime

    if uniformsLocations.cameraPosition and getCamera() then
        gl.glUniform3fv(uniformsLocations.cameraPosition.uniformLocation, 1, getCamera().vEye:tobytes())
    end

    if uniformsLocations.stroke and styles.attributes.stroke then
        shader.uniforms.stroke = styles.attributes.stroke
        --gl.glUniform4fv(uniformsLocations.stroke.uniformLocation, 1, styles.attributes.stroke:tobytes())

        if uniformsLocations.strokeWidth and styles.attributes.strokeWidth then
            shader.uniforms.strokeWidth = shader.uniforms.strokeWidth or styles.attributes.strokeWidth
--        gl.glUniform1f(uniformsLocations.strokeWidth.uniformLocation, styles.attributes.strokeWidth)
        end
    else
        shader.uniforms.strokeWidth = 0
    end

    if uniformsLocations.fill and styles.attributes.fill then
        shader.uniforms.fill = styles.attributes.fill
--        gl.glUniform4fv(uniformsLocations.fill.uniformLocation, 1, styles.attributes.fill:tobytes())
    else
        shader.uniforms.fill = transparent
    end

    if uniformsLocations.tint and styles.attributes.tint then
        shader.uniforms.tint = styles.attributes.tint
--        gl.glUniform4fv(uniformsLocations.tint.uniformLocation, 1, styles.attributes.tint:tobytes())
    end

    if uniformsLocations.useColor then
        shader.uniforms.useColor = self.colors and #self.colors > 0  and 1 or 0
--        if self.colors and #self.colors > 0 then
--            gl.glUniform1i(uniformsLocations.useColor.uniformLocation, 1)
--        else
--            gl.glUniform1i(uniformsLocations.useColor.uniformLocation, 0)
--        end
    end

    if uniformsLocations.useLight then
        shader.uniforms.useLight = self.normals and #self.normals > 0 and styles.attributes.light and config.light and 1 or 0
--        if self.normals and #self.normals > 0 and styles.attributes.light and config.light then
--            gl.glUniform1i(uniformsLocations.useLight.uniformLocation, 1)
--        else
--            gl.glUniform1i(uniformsLocations.useLight.uniformLocation, 0)
--        end
    end

    if self.shader.uniforms then
        for k,v in pairs(self.shader.uniforms) do
            self.shader:send(k, v)
        end
    end
end
