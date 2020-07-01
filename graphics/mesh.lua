class 'Mesh'

function Mesh:init(vertices, colors)
    self.vertices = vertices or {}
    self.colors = colors or {}
end

function Mesh:buffer(name)
    if name == 'position' then
        self[name] = Buffer('vec3')
    elseif name == 'normal' then
        self[name] = Buffer('vec3')
    elseif name == 'color' then
        self[name] = Buffer('color')
    end

    return self[name]
end

function Mesh:setColors(clr)
end

function Mesh:draw()
    self:render(shaders['default'], gl.GL_TRIANGLES)
end

class 'MeshRender'

local sizeofFloat = 4 -- ffi.sizeof('GLfloat')

function MeshRender:sendAttribute(attributeName, data, nComponents)
    local attribute = self.shader.attributes[attributeName]

    if attribute and data then

        gl.glBindBuffer(gl.GL_ARRAY_BUFFER, attribute.id)

        local n = #data

        -- TODO : gérer la version correctement
        if true or not attribute.sent or attribute.sent ~= n or attribute.version ~= data.version then
            attribute.sent = n
            attribute.version = data.version

            local bytes
            if type(data) == 'table' then
                if type(data[1]) == 'number' then
                    bytes = Buffer('float', data)
                elseif getmetatable(data[1]) == vec2 then
                    bytes = Buffer('vec2', data)
                elseif getmetatable(data[1]) == vec3 then
                    bytes = Buffer('vec3', data)
                end
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

        self:sendUniforms(shader.uniforms)

        if gl.majorVersion >= 4 then
            shader.vao = shader.vao or gl.glGenVertexArray()
            gl.glBindVertexArray(shader.vao)
        end

        local vertexAttrib = self:sendAttribute('vertex', self.vertices, 3)
        local pointAttrib = self:sendAttribute('point', self.points, 2)
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

        if vertexAttrib then
            gl.glDrawArrays(drawMode, 0, #self.vertices / 3)
        elseif pointAttrib then
            gl.glDrawArrays(drawMode, 0, #self.points / 2)
        end

        if img then
            img:unuse()
        end

        for attributeName,attribute in pairs(self.shader.attributes) do
            gl.glDisableVertexAttribArray(attribute.attribLocation)
        end

        if gl.majorVersion >= 4 then
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

Mesh:extends(MeshRender)
