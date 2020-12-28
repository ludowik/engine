class('MeshRender')

function MeshRender:init()
    self.shader = Shader.shaders['default']
    self.needUpdate = true
end

function MeshRender:convert()
    self.data = self.data or {}

    local uniformColor
    if #self.colors == 0 then
        uniformColor = self.uniformColor or fill() or white
    end

    local n
    if #self.indices > 0 then
        n = #self.indices
    else
        n = #self.vertices
    end

    local i
    for j=1,n do
        self.data[j] = self.data[j] or {}

        if #self.indices > 0 then
            i = self.indices[j] + 1
        else
            i = j
        end

        self.data[j][1] = self.vertices[i].x
        self.data[j][2] = self.vertices[i].y
        self.data[j][3] = self.vertices[i].z

        if self.texCoords and #self.texCoords > 0 then
            self.data[j][4] = self.texCoords[i].x
            self.data[j][5] = self.texCoords[i].y
        end

        if self.colors and #self.colors > 0 then
            self.data[j][6] = self.colors[i].r
            self.data[j][7] = self.colors[i].g
            self.data[j][8] = self.colors[i].b
            self.data[j][9] = self.colors[i].a

        elseif self.colorMode == 'uniform' then
            self.data[j][6] = uniformColor.r
            self.data[j][7] = uniformColor.g
            self.data[j][8] = uniformColor.b
            self.data[j][9] = uniformColor.a
        end

        if self.normals and #self.normals > 0 then
            self.data[j][10] = self.normals[i].x
            self.data[j][11] = self.normals[i].y
            self.data[j][12] = self.normals[i].z
        end
    end
end

function MeshRender:update()
    if self.needUpdate == false then return end
    self.needUpdate = false

    self:convert()

    if self.mesh == nil then
        self.mesh = love.graphics.newMesh(graphics2d.defaultformat,
            self.data,
            'triangles', 'static')

        self.mesh:setAttributeEnabled("VertexPosition", true)
        self.mesh:setAttributeEnabled("VertexTexCoord", true)
        self.mesh:setAttributeEnabled("VertexColor", true)
        self.mesh:setAttributeEnabled("VertexNormal", true)
    end

    if self.texture then
        local texture
        if type(self.texture) == 'string' then
            texture = image.getImage(self.texture)
        else
            texture = self.texture
        end
        self.mesh:setTexture(texture.image)
    else
        self.mesh:setTexture()
    end
end

function MeshRender:draw()
    self:render()

    if config.wireframe and self.texture == nil then
        love.graphics.setWireframe(true)
        pushStyle()
        do
            fill(red)
            self:render()
        end
        popStyle()
        love.graphics.setWireframe(false)
    end
end

function MeshRender:render()
    if #self.vertices == 0 then return end

    self:update()

    local shader = self.shader or Shader.shaders['mesh']
    graphics2d.setShader(shader)

    love.graphics.draw(self.mesh)

    graphics2d.setShader()
end
