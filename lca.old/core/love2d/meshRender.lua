class('MeshRender')

defaultformat = {
    {"VertexPosition", "float", 3}, -- The x,y,z position of each vertex
    {"VertexTexCoord", "float", 2}, -- The u,v texture coordinates of each vertex
    {"VertexColor", "byte", 4}, -- The r,g,b,a color of each vertex
    {"VertexNormal", "float", 3} -- The x,y,z normal of each vertex
}

function MeshRender:init()
    self.needUpdate = true
end

function MeshRender:convert()
    self.attributes = {}

    local uniformColor
    if #self.colors == 0 then
        uniformColor = self.uniformColor or fill() or white
    end

    for i,v in ipairs(self.vertices) do
        local clr = uniformColor or self.colors[i]
        local r, g, b, a = color.rgba(clr)

        local t = self.texCoords and self.texCoords[i] or vector()

        local n = self.normals and self.normals[i] or vector(1, 0, 0)

        table.insert(self.attributes, {
                v.x, v.y, v.z,
                t.x, t.y,
                r, g, b, a,
                n.x, n.y, n.z
            })
    end
end

function MeshRender:needUpdate()
end

function MeshRender:update()
    if not self.needUpdate then return end

    self:convert()

    self.mesh = graphics.newMesh(defaultformat, self.attributes, 'triangles', 'static')
    self.mesh:setAttributeEnabled("VertexPosition", true)
    self.mesh:setAttributeEnabled("VertexTexCoord", true)
    self.mesh:setAttributeEnabled("VertexColor", true)

    if self.texture then
        if type(self.texture) == 'string' or type(self.texture) == 'userdata' then
            self.texture = image(self.texture)
        end
        self.texture:update()
        self.mesh:setTexture(self.texture.image)
    end

    self.needUpdate = false
    
    self.attributes = nil
end

function MeshRender:render(...)
    if #self.vertices <= 0 then return end

    self:update()

    self.shader = self.shader or shaders['standard']
    if self.shader.setUniforms then
        self.shader:setUniforms(self)
    else
        graphics.setShader(self.shader.shader)
    end

    if self.colorMode == 'fill' then
        if fill() then
            self.mesh:setAttributeEnabled("VertexColor", false)
            graphics.setColor(fill():rgba())
        end

    elseif self.colorMode == 'uniform' then
        self.mesh:setAttributeEnabled("VertexColor", false)
        graphics.setColor(self.uniformColor:rgba())

    else
        self.mesh:setAttributeEnabled("VertexColor", true)
        graphics.setColor(white:rgba())

    end

    graphics.draw(self.mesh, ...)

    graphics.setShader()
end
