class('MeshRender')

function MeshRender.setup()
    gl.bufferData = function (target, buffer, usage)
        gl.glBufferData(target,
            buffer.count * buffer.dataSize,
            buffer.data.data,
            usage)
    end

    buffersDef = {
        {name = 'vertices'    , numComponents = 3, dataType = gl.GL_FLOAT, convert = Float32Array},
        {name = 'colors'      , numComponents = 4, dataType = gl.GL_FLOAT, convert = Color32Array},
        {name = 'normals'     , numComponents = 3, dataType = gl.GL_FLOAT, convert = Float32Array},
        {name = 'translations', numComponents = 2, dataType = gl.GL_FLOAT, convert = Float32Array},
        {name = 'texCoords'   , numComponents = 2, dataType = gl.GL_FLOAT, convert = Float32Array},
    }

    ctype = {
        float = ffi.typeof('float[?]'),
        ushort = ffi.typeof('unsigned short[?]'),
    }

    function ctypeFloat(n)
        return ctypeData('float', n)
    end

    function ctypeUshort(n, array)
        return ctypeData('unsigned short', n)
    end

    function ctypeData(ctype, n)
        local buffer = Buffer(ctype, n)
        return buffer -- ctype.float(n, init)
    end
end

function MeshRender:init()
    self.shader = Shader.shaders['default']
    self.drawMode = gl.GL_TRIANGLES
    self.depthMode = false

    self.buffers = nil
    self.buffersData = nil
end

function MeshRender:initBuffers(gl)
    if self.buffers == nil then
        self.buffers = Array()
        self.buffersData = Array()

        for i,bufferDef in ipairs(buffersDef) do
            if self.buffers[bufferDef.name] == nil then
                self.buffers[bufferDef.name] = gl.glGenBuffer()
            end
        end

        if not self.buffers.indices then
            self.buffers.indices = gl.glGenBuffer()
        end
    end
end

function MeshRender:releaseBuffers()
    for i,bufferDef in ipairs(buffersDef) do
        gl.deleteBuffer(self.buffers[bufferDef.name])
    end

    gl.deleteBuffer(self.buffers.indices)

    self.buffers = nil
    self.buffersData = nil
end

function MeshRender:update(dt)
end

function MeshRender:draw()
    if #self.vertices == 0 then return end

    if #self.normals > 0 then
        self.shader = self.shader or Shader.shaders['default']
    else
        self.shader = self.shader or Shader.shaders['basic']
    end

    if self.shader.name == 'default' then
        self.shader.uniforms.fillColor = fill()
        self.shader.uniforms.tintColor = tint()

        self.shader.uniforms.useLight = light() and 1 or 0

        self.shader.uniforms.useColors = #self.colors

    elseif self.shader.name == 'basic' then
        self.shader.uniforms.strokeColor = stroke()
        self.shader.uniforms.tintColor = tint()

        self.shader.uniforms.useLight = light() and 1 or 0

        self.shader.uniforms.useColors = #self.colors

    else
        self.shader.uniforms.strokeColor = stroke()
        self.shader.uniforms.fillColor = fill()
        self.shader.uniforms.tintColor = tint()

        self.shader.uniforms.useLight = light() and 1 or 0

        self.shader.uniforms.useColors = #self.colors
    end

    depthMode(true)

    self:render(true)
end

function MeshRender:bufferData(dataFunc, arrayName, numComponents)
    if self[arrayName] and #self[arrayName] > 0 then
        self.buffersData[arrayName] = dataFunc(
            self[arrayName],
            self.buffersData[arrayName],
            numComponents)
    end
    return self.buffersData[arrayName]
end

ffiFloat32Array = class('Float32Array')

function Float32Array(array, buffer, numComponents)
    if buffer and array == buffer.array and #array == buffer.arraySize then return buffer end

    ffiFloat32Array()

    local count

    local itemType = type(array[1])
    if itemType == 'table' or itemType == 'cdata' then
        count = #array * numComponents
    else
        count = #array
    end

    local verticeSize = gl.glSizeOfFloat()
    if buffer == nil then
        buffer = {
            count = count,
            dataSize = verticeSize,
            data = ctypeFloat(count),
            array = array,
            arraySize = #array
        }
    else
        buffer.count = count
        buffer.array = array
        buffer.arraySize = #array
    end

    buffer.data.count = 0

    local vType
    for i,v in ipairs(array) do
        vType = type(v)

        if vType == 'table' or vType == 'cdata' then
            if numComponents == 3 then
                buffer.data[#buffer.data] = v.x
                buffer.data[#buffer.data] = v.y
                buffer.data[#buffer.data] = v.z or 0
            elseif numComponents == 2 then
                buffer.data[#buffer.data] = v.x
                buffer.data[#buffer.data] = v.y
            else
                assert()
            end
        else
            buffer.data[#buffer.data] = v
        end
    end
    
    buffer.alreadySent = false

    return buffer
end

ffiColor32Array = class('Color32Array')

function Color32Array(array, buffer, numComponents)
    if buffer and array == buffer.array and #array == buffer.arraySize then return buffer end

    ffiColor32Array()
    numComponents = numComponents or 4

    local count = #array * numComponents

    local colorSize = gl.glSizeOfFloat()
    if buffer == nil then
        buffer = {
            count = count,
            dataSize = colorSize,
            data = ctypeFloat(count),
            array = array,
            arraySize = #array
        }
    else
        buffer.count = count
        buffer.dataSize = colorSize
        buffer.array = array
        buffer.arraySize = #array
    end

    buffer.data.count = 0

    for i,v in ipairs(array) do
        buffer.data[#buffer.data] = v.r
        buffer.data[#buffer.data] = v.g
        buffer.data[#buffer.data] = v.b
        buffer.data[#buffer.data] = v.a
    end

    buffer.alreadySent = false
    
    return buffer
end

ffiUint16Array = class('Uint16Array')

function Uint16Array(array, buffer)
    if buffer and array == buffer.array and #array == buffer.arraySize then return buffer end

    ffiUint16Array()

    local count = #array

    local indexSize = gl.glSizeOfInt()
    if buffer == nil then
        buffer = {
            count = count,
            dataSize = indexSize,
            data = ctypeUshort(#array),
            array = array,
            arraySize = #array
        }
    else
        buffer.count = count
        buffer.array = array
        buffer.arraySize = #array
    end

    buffer.data.count = 0

    for i=1,#array do
        buffer.data[i-1] = array[i]
    end
    
    buffer.alreadySent = false

    return buffer
end

function MeshRender:render(depth)
    if self.texture or config.wireframe == 'fill' or config.wireframe == 'fill&line'  then
        gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_FILL)
        self:_render(depth)
    end

    if self.texture == nil and (config.wireframe == 'line' or config.wireframe == 'fill&line') then
        gl.glPolygonMode(gl.GL_FRONT_AND_BACK, gl.GL_LINE)
        self.shader.uniforms.useColors = 0
        fill(gray)
        self:_render(depth)
    end
end

function MeshRender:_render(depth, shader)
    shader = shader or self.shader

    self:initBuffers(gl)

    gl.glUseProgram(shader.ids.program)

    shader:pushToShader(shader.uniforms)

    local numComponents, dataType, normalize, stride, offset

    for i,bufferDef in ipairs(buffersDef) do
        if shader.attribLocations[bufferDef.name] ~= -1 then
            if self[bufferDef.name] and #self[bufferDef.name] > 0 then
                numComponents = bufferDef.numComponents
                dataType = bufferDef.dataType

                normalize = false

                stride = 0
                offset = 0

                gl.glBindBuffer(gl.GL_ARRAY_BUFFER, self.buffers[bufferDef.name])

                local data = self:bufferData(
                    bufferDef.convert,
                    bufferDef.name,
                    numComponents)
                
                if not data.alreadySent then
                    gl.bufferData(gl.GL_ARRAY_BUFFER, data, gl.GL_STATIC_DRAW)
                    data.alreadySent = true
                end

                gl.glVertexAttribPointer(shader.attribLocations[bufferDef.name], numComponents, dataType, normalize, stride, offset)
                gl.glEnableVertexAttribArray(shader.attribLocations[bufferDef.name])
            end
        end
    end

    if self.texture then
        local img = self.texture
        if type(img) == 'string' then
            img = image(img)
        end

        img:use()

        shader:pushToShader({
                useTexture = 1,
                uSampler = 0
            })

        graphics.texturememory = graphics.texturememory + (img.width * img.height * 4)
    end

    -- TODO : toujours envoyer les matrices ?
    local pvMatrix = pvMatrix()
    if true or shader.pvMatrix ~= pvMatrix then
        shader.pvMatrix = pvMatrix
        gl.glUniformMatrix4fv(shader.uniformLocations.pvMatrix, 1, gl.GL_TRUE, pvMatrix)
    end

    local modelMatrix = self.modelMatrix or modelMatrix()
    if true or shader.modelMatrix ~= modelMatrix then
        shader.modelMatrix = modelMatrix
        gl.glUniformMatrix4fv(shader.uniformLocations.modelMatrix, 1, gl.GL_TRUE, modelMatrix)
    end

    if self.indices and #self.indices > 0 then
        gl.glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.buffers.indices)
        gl.bufferData(gl.GL_ELEMENT_ARRAY_BUFFER,
            self:bufferData(
                Uint16Array,
                'indices',
                1),
            gl.GL_STATIC_DRAW)

        vertexCount = #self.indices
        dataType = gl.GL_UNSIGNED_SHORT
        offset = 0

        gl.glDrawElementsInstanced(self.drawMode, vertexCount, dataType, gl.glBufferOffset(offset), 1)
    else
        first = 0
        if type(self.vertices[1]) == 'table' then
            vertexCount = #self.vertices
        else
            vertexCount = #self.vertices / 3
        end

--        gl.glDrawArraysInstanced(self.drawMode, first, vertexCount, 1)
        gl.glDrawArrays(self.drawMode, 0, vertexCount)
    end

    graphics.drawcalls = graphics.drawcalls + 1

    if self.texture then
        shader:pushToShader({
                useTexture = 0,
            })

        image:unuse()
    end
end
