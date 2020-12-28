mesh = class('Mesh', MeshRender)

function Mesh:init(vertices)
    MeshRender.init(self)

    self:clear()
    self.vertices = vertices or self.vertices
end

function Mesh:clear()
    self.vertices = {}
    self.indices = {}
    self.colors = {}

    self.colorMode = 'fill'

    self.texCoords = {}
    self.normals = {}

    self.needUpdate = true
    self.autoRelease = false
end

function Mesh:setColors(...)
    self.colorMode = 'uniform'

    local clr = color(...)
    self.uniformColor = clr

    if self.colors == nil or #self.colors > 0 then
        self.colors = {}
    end
end

function Mesh:vertex(i, v)
    self.needUpdate = true
    self.vertices[i] = v
end

function Mesh:color(i, ...)
    self.colorMode = 'colors'
    self.needUpdate = true
    self.colors[i] = color(...)
end

function Mesh:addRect(x, y, w, h, r)
    self.needUpdate = true

    local idx = #self.vertices + 1

    self:setRectTex(idx, 0, 0, 1, 1)
    self:setRectColor(idx, 1, 1, 1, 1)
    self:setRect(idx, x, y, w, h, r)

    return idx
end

function Mesh:setRect(idx, x, y, w, h, r)
    self.needUpdate = true

    r = r or 0

    self.vertices[idx+0] = vector(-w/2,  h/2, 0)
    self.vertices[idx+1] = vector(-w/2, -h/2, 0)
    self.vertices[idx+2] = vector( w/2, -h/2, 0)
    self.vertices[idx+3] = vector(-w/2,  h/2, 0)
    self.vertices[idx+4] = vector( w/2, -h/2, 0)
    self.vertices[idx+5] = vector( w/2,  h/2, 0)

    if r ~= 0 then
        local c = cos(r)
        local s = sin(r)

        for i = idx, idx+5 do
            local v = self.vertices[i]
            self.vertices[i] = vector(
                v.x * c - v.y * s,
                v.y * c + v.x * s,
                0)
        end
    end

    local position = vector(x, y, 0)
    for i = idx, idx+5 do
        self.vertices[i] = self.vertices[i] + position
    end
end

function Mesh:addRectCorner(x, y, w, h, r)
    self.needUpdate = true

    local idx = #self.vertices + 1

    self:setRectTex(idx, 0, 0, 1, 1)
    self:setRectColor(idx, 1, 1, 1, 1)
    self:setRectCorner(idx, x, y, w, h, r)

    return idx
end

function Mesh:setRectCorner(idx, x, y, w, h)
    self.needUpdate = true

    self.vertices[idx+0] = vector(x  , y+h, 0)
    self.vertices[idx+1] = vector(x  , y  , 0)
    self.vertices[idx+2] = vector(x+w, y  , 0)
    self.vertices[idx+3] = vector(x  , y+h, 0)
    self.vertices[idx+4] = vector(x+w, y  , 0)
    self.vertices[idx+5] = vector(x+w, y+h, 0)    
end

function Mesh:setRectTex(idx, s, t, w, h)
    self.needUpdate = true

    local th = t+h
    local sw = s+w

    self.texCoords = self.texCoords or {}

    self.texCoords[idx+0] = vec2(s , th)
    self.texCoords[idx+1] = vec2(s , t)
    self.texCoords[idx+2] = vec2(sw, t)
    self.texCoords[idx+3] = vec2(s , th)
    self.texCoords[idx+4] = vec2(sw, t)
    self.texCoords[idx+5] = vec2(sw, th)
end

function Mesh:setRectColor(idx, ...)
    self.needUpdate = true

    local clr = color(...)

    self.colors = self.colors or {}
    for i = idx, idx+5 do
        self.colors[i] = clr
    end
end

function Mesh:setGradient(clr1, clr2)
    local clr = color(clr1)
    local step = (clr2 - clr1) / (#self.vertices - 1)
    for i=1,#self.vertices do
        self:color(i, clr.r, clr.g, clr.b, clr.a)
        clr.r = clr.r + step.r
        clr.g = clr.g + step.g
        clr.b = clr.b + step.b
        clr.a = clr.a + step.a
    end
end

function Mesh:normalize(norm)
    norm = norm or 1
    Model.normalize(self.vertices, norm)
    return self
end

function Mesh:center()
    Model.center(self.vertices)
    return self
end

function Mesh:draw(...)
    if #self.colors > 0 then
        self.colorMode = 'colors'
    end

    if meshManager then
        meshManager:addMesh(self, ...)
    else
        self:render(...)
    end
end

function Mesh:resize(size)
    return self
end

function Mesh:buffer(name)
    local t
    if name == 'position' then
        t = self.vertices
    elseif name == 'texCoord' then
        t = self.texCoord
    elseif name == 'color' then
        t = self.colors
    elseif name == 'normal' then
        t = self.normals
    end

    if t then
        local mt = {
            resize = function () end
        }
        mt.__index = mt

        setmetatable(t, mt)

        return t
    end
end
