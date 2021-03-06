MeshRender = class 'RendererInterface.OpenGL' : extends(RendererInterface)

function MeshRender.setup()
    config.wireframe = config.wireframe or 'fill'
end

function MeshRender:init()
    self.uniforms = {}

    self.meshPosition = vec3()
    self.meshSize = vec3()
end

function MeshRender:release()
    if self.vao and gl.glIsVertexArray(self.vao) == gl.GL_TRUE then
        gl.glDeleteVertexArray(self.vao)
        self.vao = nil
    end
end

function MeshRender:render(shader, drawMode, img, x, y, z, w, h, d, nInstances)
    assert(shader)
    assert(drawMode)

    if self.texture then
        if type(self.texture) == 'string' then
            img = resourceManager:get('image', self.texture, image)
        else
            img = self.texture
        end
    end

    self.shader = shader
    self.img = img

    x = x or 0
    y = y or 0
    z = z or zLevel()

    w = w or 1
    h = h or 1
    d = d or 1

    self.meshPosition:set(x, y, z)
    self.meshSize:set(w, h, d)

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

        if shader.attributes.inst_pos then
            if self.inst_pos then
                self:sendAttributes('inst_pos', self.inst_pos, 3, nil, true)
            else                
                if shader.buffPos == nil then
                    shader.buffPos = Buffer('vec3')
                end
                shader.buffPos[1] = self.meshPosition                
                self:sendAttributes('inst_pos', shader.buffPos, 3, nil, true)
            end
        end

        if shader.attributes.inst_size then
            if self.inst_size then
                self:sendAttributes('inst_size', self.inst_size, 3, nil, true)
            else
                if shader.buffSize == nil then
                    shader.buffSize = Buffer('vec3')
                end
                shader.buffSize[1] = self.meshSize
                self:sendAttributes('inst_size', shader.buffSize, 3, nil, true)
            end
        end

        self:sendUniforms(shader.uniformsLocations)

        if img or config.wireframe == 'fill' or config.wireframe == 'fill&line'  then
            self:renderDraw(drawMode, img, nInstances)
        end

        if img then
            img:unuse()
        end

        if config.wireframe == 'line' or config.wireframe == 'fill&line' then
            self:renderWireframe(shader, drawMode, img, nInstances)
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

function MeshRender:renderDraw(drawMode, img, nInstances)
    gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_FILL)

    if self.indices and #self.indices > 0 and not ios then
        gl.glDrawElementsInstanced(drawMode, #self.indices, gl.GL_UNSIGNED_SHORT, NULL, nInstances or 1)
    else
        gl.glDrawArraysInstanced(drawMode, 0, #self.vertices, nInstances or 1)
    end
end

function MeshRender:renderWireframe(shader, drawMode, img, nInstances)
    if shader.uniformsLocations.stroke then
        gl.glUniform4fv(shader.uniformsLocations.stroke.uniformLocation, 1, red:tobytes())
    end
    if shader.uniformsLocations.fill then
        gl.glUniform4fv(shader.uniformsLocations.fill.uniformLocation, 1, red:tobytes())
    end

    gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_LINE)

    if self.indices and #self.indices > 0 and not ios then
        gl.glDrawElementsInstanced(drawMode, #self.indices, gl.GL_UNSIGNED_SHORT, NULL, nInstances or 1)
    else
        gl.glDrawArraysInstanced(drawMode, 0, #self.vertices, nInstances or 1)
    end
end

function MeshRender:sendAttributes(attributeName, buffer, nComponents, bufferType, instancedBuffer)
    bufferType = bufferType or gl.GL_ARRAY_BUFFER

    local attribute = self.shader.attributes[attributeName]
    if attribute and buffer and #buffer > 0 then
        buffer = self:sendBuffer(attributeName, attribute, buffer, nComponents, bufferType)

        if instancedBuffer then
            gl.glVertexAttribPointer(attribute.attribLocation, nComponents, gl.GL_FLOAT, gl.GL_FALSE, buffer.sizeof_ctype, ffi.NULL)
            gl.glVertexAttribDivisor(attribute.attribLocation, 1)
        else
            gl.glVertexAttribPointer(attribute.attribLocation, nComponents, gl.GL_FLOAT, gl.GL_FALSE, 0, ffi.NULL)
        end

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

local map = {}
function MeshRender:sendBuffer(attributeName, attribute, buffer, nComponents, bufferType)
    local idBuffer, ref
    if buffer.idBuffer and buffer.idBuffer > 0 then
        idBuffer = buffer.idBuffer
        map[buffer] = map[buffer] or {}
        ref = map[buffer]
    else
        idBuffer = attribute.id
        ref = attribute
    end
    
    gl.glBindBuffer(bufferType, idBuffer)

    local n = #buffer

    if (ref.sent == nil or ref.sent ~= n or
        buffer.id == nil or buffer.id ~= ref.bufferId or
        buffer.version == nil or buffer.version ~= ref.bufferVersion)
    then
        ref.sent = n
        ref.bufferVersion = buffer.version
        ref.bufferId = buffer.id

        local bytes
        if type(buffer) == 'table' then
            local t = ffi.typeof(buffer[1])
            if t == __vec3 or t == __vec3ref then
                buffer = Buffer('vec3', buffer)
                assert(nComponents==3)

            elseif t == __color or t == __colorref  then
                buffer = Buffer('color', buffer)
                assert(nComponents==4)

            elseif t == __vec2 or t == __vec2ref then
                if nComponents == 2 then
                    buffer = Buffer('vec2', buffer)
                elseif nComponents == 3 then
                    buffer = Buffer('vec3', table.map(buffer, function (_, i, v) return v:tovec3() end))
                end

            elseif type(buffer[1]) == 'number' then
                buffer = Buffer('float', buffer)
                assert(nComponents==1)

            else
                error(ffi.typeof(buffer[1]))
            end

            log(getFunctionLocation(buffer.id, 2))
            log('convert buffer '..buffer.id..' ('..tostring(buffer)..') for shader '..self.shader.name)
        end

--        log(string.format('send buffer {attributeName} (id:{id}, version:{version}) to shader {shaderName}', {
--                    attributeName = attributeName,
--                    id = buffer.id,
--                    version = buffer.version,
--                    shaderName = self.shader.name}))

        gl.glBufferData(bufferType, buffer:sizeof(), buffer:tobytes(), gl.GL_STATIC_DRAW)
    end

    return buffer
end

function MeshRender:sendUniforms(uniformsLocations)
    local shader = self.shader
    local uniforms = self.uniforms
    local img = self.img

    if img then
        img:update()
        img:use(gl.GL_TEXTURE0)

        uniforms.useTexture = 1
        uniforms.tex0 = 0
    else
        uniforms.useTexture = 0
    end

    uniforms.matrixPV = pvMatrix()
    uniforms.matrixModel = modelMatrix()

    uniforms.pos = self.meshPosition
    uniforms.size = self.meshSize

    uniforms.time = ElapsedTime

    uniforms.useColor = self.colors and #self.colors > 0  and 1 or 0

    if getCamera() then
        uniforms.cameraPosition = getCamera().vEye:tobytes()
    end

    uniforms.fill = styles.attributes.fill or transparent

    uniforms.stroke = styles.attributes.stroke or transparent
    uniforms.strokeWidth = self.strokeWidth or styles.attributes.strokeWidth or 0

    uniforms.tint = styles.attributes.tint or transparent

    uniforms.lineCapMode = styles.attributes.lineCapMode   

    uniforms.useLight = styles.attributes.light and config.light and 1 or 0

    if uniforms.useLight == 1 then
        uniforms.lights = lights
        
        uniforms.nLights = #lights
        
        if uniformsLocations['lights[0].state'] then
            shader:pushTableToShader(lights, 'lights', 'useLights')
        end
    else
        uniforms.nLights = 0
    end

    shader:sendUniforms(uniforms)
end
