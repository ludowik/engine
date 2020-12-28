MeshRender = class()

LOCATION_VERTICES = 0
LOCATION_NORMALS = 1
LOCATION_COLORS = 2
LOCATION_TEX_COORDS = 3
LOCATION_INSTANCE_MODEL_MATRIX = 4 -- 5 & 6 & 7
LOCATION_INSTANCE_COLORS = 8
LOCATION_INSTANCE_WIDTH = 9

local ushortSize, uintSize, floatSize1, floatSize2, floatSize3, floatSize4, matrixSize

function MeshRender.setup()
    ushortSize = gl.glSizeOfShort()
    uintSize = gl.glSizeOfInt()

    floatSize1 = gl.glSizeOfFloat()
    floatSize2 = floatSize1 * 2
    floatSize3 = floatSize1 * 3
    floatSize4 = floatSize1 * 4
    matrixSize = floatSize1 * 16
end

function MeshRender:initGL(needUpdate)
    self.needUpdate = needUpdate or self.needUpdate

    if self.texture and type(self.texture) == 'string' then
        self.texture = image(self.texture)
    end

    if (self.needUpdate == true or
        self.lastVertices ~= self.vertices or
        self.lastColors ~= self.colors)
    then
        self.nVertices = self.vertices and #self.vertices  or 0
        self.nIndices  = self.indices  and #self.indices   or 0

        if self.nVertices > 0 then
            self:initVBO()
            self:initVAO()

            self.needUpdate = false
        end

        self.lastVertices = self.vertices
        self.lastColors = self.colors
        self.lastTexture = self.texture
    end
end

function MeshRender:initVBO()
    local nVertices = self.nVertices
    local nIndices  = self.nIndices

    local nNormals   = self.normals   and #self.normals   or 0
    local nColors    = self.colors    and #self.colors    or 0
    local nTexCoords = self.texCoords and #self.texCoords or 0

    assert(
        (nVertices > 0) and
        (nNormals == 0 or nNormals == nVertices) and
        (nColors == 0 or nColors == nVertices) and
        (nTexCoords == 0 or nTexCoords == nVertices), "Mesh incohérence dans les buffers " .. NL ..
        "nVertices  " .. nVertices .. NL ..
        "nIndices   " .. nIndices  .. NL ..      
        "nNormals   " .. nNormals  .. NL ..
        "nColors    " .. nColors   .. NL ..
        "nTexCoords " .. nTexCoords
    )

    local sizeVertices  = floatSize3 * nVertices
    local sizeNormals   = floatSize3 * nNormals
    local sizeColors    = floatSize4 * nColors
    local sizeTexCoords = floatSize2 * nTexCoords

    local sizeIndices = ushortSize * nIndices

    local usage = gl.GL_DYNAMIC_DRAW

    if self.vbo == nil then
        self.vbo = BufferObject(gl.GL_ARRAY_BUFFER)
    end

    if not self.vbo:isBufferObject() then
        self.vbo:generate()
    end

    self.vbo:bind()
    do
        local size = (sizeVertices +
            sizeNormals +
            sizeColors +
            sizeTexCoords)

        if self.vbo.size < size then
            gl.glBufferData(gl.GL_ARRAY_BUFFER, size, nil, usage)
            self.vbo.size = size
        end

        local offset = 0
        gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, nVertices, 3, floatSize1, 'GLfloat', self.vertices)
        offset = offset + sizeVertices

        if nNormals > 0 then
            gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, nNormals, 3, floatSize1, 'GLfloat', self.normals)
            offset = offset + sizeNormals
        end

        if nColors > 0 then
            gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, nColors, 4, floatSize1, 'GLfloat', self.colors)
            offset = offset + sizeColors
        end

        if self.texture and nTexCoords > 0 then
            gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, nTexCoords, 2, floatSize1, 'GLfloat', self.texCoords)
            offset = offset + sizeTexCoords
        end
    end
    self.vbo:unbind()

    if nIndices > 0 then
        if self.ibo == nil then
            self.ibo = BufferObject(gl.GL_ELEMENT_ARRAY_BUFFER)
        end

        if not self.ibo:isBufferObject() then
            self.ibo:generate()
        end

        self.ibo:bind()
        do
            local indices = gl.to(self.indices, nIndices, 1, 'GLushort')
            gl.glBufferData(gl.GL_ELEMENT_ARRAY_BUFFER, sizeIndices, indices, usage)
        end
        self.ibo:unbind()
    end
end

function MeshRender:initVAO()
    local nVertices = self.nVertices
    local nIndices  = self.nIndices

    local nNormals   = self.normals   and #self.normals   or 0
    local nColors    = self.colors    and #self.colors    or 0
    local nTexCoords = self.texCoords and #self.texCoords or 0

    assert(
        (nVertices > 0) and
        (nNormals == 0 or nNormals == nVertices) and
        (nColors == 0 or nColors == nVertices) and
        (nTexCoords == 0 or nTexCoords == nVertices), "Mesh incohérence dans les buffers"
    )

    local sizeVertices  = floatSize3 * nVertices
    local sizeNormals   = floatSize3 * nNormals
    local sizeColors    = floatSize4 * nColors
    local sizeTexCoords = floatSize2 * nTexCoords

    local sizeIndices = ushortSize * nIndices

    self.vao = self.vao or VertexArray()
    if not self.vao:isVertexArray() then
        self.vao:generate()
    end

    self.vao:bind()
    do
        self.vbo:bind()

        local offset = 0
        gl.glVertexAttribPointer(LOCATION_VERTICES, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, offset)
        gl.glVertexAttribDivisor(LOCATION_VERTICES, 0)
        offset = offset + sizeVertices

        if nNormals > 0 then
            gl.glVertexAttribPointer(LOCATION_NORMALS, 3, gl.GL_FLOAT, gl.GL_FALSE, 0, offset)
            gl.glVertexAttribDivisor(LOCATION_NORMALS, 0)
            offset = offset + sizeNormals
        end

        if nColors > 0 then
            gl.glVertexAttribPointer(LOCATION_COLORS, 4, gl.GL_FLOAT, gl.GL_FALSE, 0, offset)
            gl.glVertexAttribDivisor(LOCATION_COLORS, 0)
            offset = offset + sizeColors
        end

        if self.texture and nTexCoords > 0 then
            gl.glVertexAttribPointer(LOCATION_TEX_COORDS, 2, gl.GL_FLOAT, gl.GL_FALSE, 0, offset)
            gl.glVertexAttribDivisor(LOCATION_TEX_COORDS, 0)
            offset = offset + sizeTexCoords
        end

        if nIndices > 0 then
            self.ibo:bind()
        end
    end
    self.vao:unbind()
end

function MeshRender:initDBO(N, from, to)    
    if self.dbo and N and N > 1 and self.instances == self.lastInstances then
        return
    end
    self.lastInstances = self.instances

    --    N = N or 1
    --    from = from or 0
    --    to = to or N

    if self.dbo == nil then
        self.dbo = BufferObject(gl.GL_ARRAY_BUFFER)
    end

    if not self.dbo:isBufferObject() then
        self.dbo:generate()
    end

    self.dbo:bind()
    do
        local sizeModelMatrix = matrixSize
        local sizeColor = floatSize4
        local sizeWidth = floatSize1

        local sizeStruct = (sizeModelMatrix +
            sizeColor +
            sizeWidth)

        local size = sizeStruct
        if N then
            size = size * N
        end

        local usage = gl.GL_STREAM_DRAW
        if self.dbo.size < size then
            gl.glBufferData(gl.GL_ARRAY_BUFFER, size, nil, usage)
            self.dbo.size = size
        end

        if N then
            local offset = 0
            for i=from,to-1 do
                local instance = self.instances[i]

                -- model matrix
                local modelMatrix = instance.modelMatrix or self.modelMatrix or modelMatrix()
                if instance.positionMatrix then
                    modelMatrix = modelMatrix * instance.positionMatrix
                end
                if matrix ~= glm_matrix then
                    modelMatrix = modelMatrix:transpose()
                end
                gl.glBufferSubDataMatrix(gl.GL_ARRAY_BUFFER, offset, matrixSize, modelMatrix)
                offset = offset + matrixSize                        

                -- color
                gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, 1, 4, floatSize1, 'GLfloat',
                    {instance.uniformColor or self.uniformColor or white})
                offset = offset + floatSize4

                -- width
                gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, 1, 1, floatSize1, 'GLfloat',
                    {instance.width or strokeWidth() or 1})
                offset = offset + floatSize1

                -- texture
                self.texture = instance.texture
                if self.texture and type(self.texture) == 'string' then
                    self.texture = image(self.texture)
                end
            end
        else
            -- model matrix
            local offset = 0
            local modelMatrix = self.modelMatrix or modelMatrix()
            if matrix ~= glm_matrix then
                modelMatrix = modelMatrix:transpose()
            end
            gl.glBufferSubDataMatrix(gl.GL_ARRAY_BUFFER, offset, matrixSize, modelMatrix)
            offset = offset + matrixSize

            -- color
            gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, 1, 4, floatSize1, 'GLfloat', {self.uniformColor or white})
            offset = offset + floatSize4

            -- width
            gl.glBufferSubData(gl.GL_ARRAY_BUFFER, offset, 1, 1, floatSize1, 'GLfloat', {strokeWidth() or 1})
            offset = offset + floatSize1
        end

        local offset = 0
        for i=0,3 do
            gl.glVertexAttribPointer(LOCATION_INSTANCE_MODEL_MATRIX+i, 4, gl.GL_FLOAT, gl.GL_FALSE, sizeStruct, offset)
            gl.glVertexAttribDivisor(LOCATION_INSTANCE_MODEL_MATRIX+i, 1)
            gl.glEnableVertexAttribArray(LOCATION_INSTANCE_MODEL_MATRIX+i)

            offset = offset + floatSize4
        end

        gl.glVertexAttribPointer(LOCATION_INSTANCE_COLORS, 4, gl.GL_FLOAT, gl.GL_FALSE, sizeStruct, offset)
        gl.glVertexAttribDivisor(LOCATION_INSTANCE_COLORS, 1)
        gl.glEnableVertexAttribArray(LOCATION_INSTANCE_COLORS)
        offset = offset + floatSize4

        gl.glVertexAttribPointer(LOCATION_INSTANCE_WIDTH, 1, gl.GL_FLOAT, gl.GL_FALSE, sizeStruct, offset)
        gl.glVertexAttribDivisor(LOCATION_INSTANCE_WIDTH, 1)
        gl.glEnableVertexAttribArray(LOCATION_INSTANCE_WIDTH)
        offset = offset + floatSize1
    end
    self.dbo:unbind()
end

function MeshRender:release()
    if self.vbo then self.vbo:release() end
    if self.dbo then self.dbo:release() end
    if self.ibo then self.ibo:release() end
    if self.vao then self.vao:release() end

    self.needUpdate = true
end

function MeshRender:render(primitiveMode, polygonMode)
    self:initGL()

    if self.nVertices <= 0 then
        return
    end

    primitiveMode = primitiveMode or 'triangles'

    self.shader = self.shader or shaders['standard']

    if primitiveMode == 'triangles' then
        self:drawProc(self.shader, gl.GL_TRIANGLES, polygonMode or gl.GL_FILL)

    elseif primitiveMode == 'triangle_strip' then
        self:drawProc(self.shader, gl.GL_TRIANGLE_STRIP, polygonMode or gl.GL_FILL)

    elseif primitiveMode == 'lines' then
        self:drawProc(self.shader, gl.GL_LINES, polygonMode or gl.GL_LINE)

    elseif primitiveMode == 'line_strip' then
        self:drawProc(self.shader, gl.GL_LINE_STRIP, polygonMode or gl.GL_LINE)

    elseif primitiveMode == 'points' then
        self:drawProc(self.shader, gl.GL_POINTS, polygonMode or gl.GL_POINT)

    else
        self:drawProc(self.shader, primitiveMode, polygonMode)

    end

    if self.autoRelease then
        self:release()
    end
end

function MeshRender:drawProcIndirect(shader, primitiveMode, polygonMode)
    local indirectBuffer = ffi.new('GLuint [4]')

    indirectBuffer[0] = self.nVertices
    indirectBuffer[1] = 1
    indirectBuffer[2] = 0
    indirectBuffer[3] = 0

    local bufObj = BufferObject(gl.GL_DRAW_INDIRECT_BUFFER)
    bufObj:generate()
    bufObj:bind()

    gl.glBufferData(gl.GL_DRAW_INDIRECT_BUFFER, ffi.sizeof(indirectBuffer), indirectBuffer, gl.GL_STATIC_DRAW)

    gl.glDrawArraysIndirect(primitiveMode, NULL)

    bufObj:unbind()
    bufObj:release()
end

function MeshRender:drawProc(shader, primitiveMode, polygonMode)
    local nVertices = self.nVertices
    local nIndices  = self.nIndices

    local nNormals   = self.normals   and #self.normals   or 0
    local nColors    = self.colors    and #self.colors    or 0
    local nTexCoords = self.texCoords and #self.texCoords or 0

    local N, from, to
    if self.instances and #self.instances > 0 then
        from = self.instances.i or 1
        N = self.instances.n or #self.instances
        to = from + N
    end

    shader:use(self)
    do
        self.vao:bind()

        self:initDBO(N, from, to)

        gl.glEnableVertexAttribArray(LOCATION_VERTICES)

        for i=0,3 do
            gl.glEnableVertexAttribArray(LOCATION_INSTANCE_MODEL_MATRIX+i)
        end
        gl.glEnableVertexAttribArray(LOCATION_INSTANCE_COLORS)
        gl.glEnableVertexAttribArray(LOCATION_INSTANCE_WIDTH)

        if nNormals > 0 then
            gl.glEnableVertexAttribArray(LOCATION_NORMALS)
        end

        if nColors > 0 then
            gl.glEnableVertexAttribArray(LOCATION_COLORS)
        end

        if self.texture then
            self.texture:needUpdate()
            self.texture:use()

            if nTexCoords > 0 then
                gl.glEnableVertexAttribArray(LOCATION_TEX_COORDS)
            end
        end

        -- TODO : use face culling info
        if polygonMode then
            gl.glPolygonMode(gl.GL_FRONT_AND_BACK, polygonMode)
        end

        if self.nIndices > 0 then
            assert(N == nil or N > 0)
            if N then
                gl.glDrawElementsInstanced(primitiveMode, self.nIndices, gl.GL_UNSIGNED_SHORT, NULL, N)
            else
                gl.glDrawElements(primitiveMode, self.nIndices, gl.GL_UNSIGNED_SHORT, NULL)
            end
        else
            assert(N == nil or N > 0)
            if N then
                gl.glDrawArraysInstanced(primitiveMode, 0, self.nVertices, N)
            else
                gl.glDrawArrays(primitiveMode, 0, self.nVertices)
            end
        end

        do
            for i=0,3 do
                gl.glDisableVertexAttribArray(LOCATION_INSTANCE_MODEL_MATRIX+i)
            end
            gl.glDisableVertexAttribArray(LOCATION_INSTANCE_COLORS)
            gl.glDisableVertexAttribArray(LOCATION_INSTANCE_WIDTH)
        end

        gl.glDisableVertexAttribArray(LOCATION_VERTICES)

        if nNormals > 0 then
            gl.glDisableVertexAttribArray(LOCATION_NORMALS)
        end

        if nColors > 0 then
            gl.glDisableVertexAttribArray(LOCATION_NORMALS)
        end

        if self.texture then
            if nTexCoords > 0 then
                gl.glDisableVertexAttribArray(LOCATION_TEX_COORDS)
            end
            self.texture:unuse()            
        end

        self.vao:unbind()
    end
    shader:unuse()
end

function MeshRender:drawMesh2d(x_, y_, z_, w_, h_, d_, primitiveMode, polygonMode)
    self:drawMesh(
        x_, y_, z_,
        w_, h_, d_,
        primitiveMode, polygonMode, true)
end

function MeshRender:drawMesh(x_, y_, z_, w_, h_, d_, primitiveMode, polygonMode, mesh2d)
    local x = x_ or 0
    local y = y_ or 0
    local z = z_ or 0
    local w = w_ or 1
    local h = h_ or w
    local d = d_ or (mesh2d and 1 or w)

    self.mesh2d = mesh2d

    pushMatrix()
    do
        if mesh2d then
            z = z + meshManager.depth
            meshManager.depth = meshManager:nextDepth()
        end

        if x_ or mesh2d then
            translate(x, y, z)
        end

        if w_ then
            scale(w, h, d)
        end

        mesh.render(self, self.primitiveMode or primitiveMode, self.polygonMode or polygonMode)
    end
    popMatrix()
end

function MeshRender:addMesh2d(x_, y_, z_, w_, h_, d_, primitiveMode, polygonMode)
    self:addMesh(
        x_, y_, z_,
        w_, h_, d_,
        primitiveMode, polygonMode, true)
end

function MeshRender:addMesh(x_, y_, z_, w_, h_, d_, primitiveMode, polygonMode, mesh2d)
    local x = x_ or 0
    local y = y_ or 0
    local z = z_ or 0
    local w = w_ or 1
    local h = h_ or w
    local d = d_ or (mesh2d and 1 or w)

    self.mesh2d = mesh2d

    pushMatrix()
    do
        if mesh2d then
            z = z + meshManager.depth
            meshManager.depth = meshManager:nextDepth()
        end

        if x_ or mesh2d then
            translate(x, y, z)
        end

        if w_ then
            scale(w, h, d)
        end

        meshManager:addMesh(self, self.primitiveMode or primitiveMode, self.polygonMode or polygonMode)
    end
    popMatrix()
end
