class('Rect')

function Rect:init(x, y, w, h)
    w = w or 10
    h = h or 10

    self.position = vector(x, y)
    self.absolutePosition = vector(x, y)
    
    self.size = vector(w, h)
    
    self.borderWidth = 2
    self.borderColor = gray
end

local function c2x(c)
    return (WIDTH  / 12) * c
end

local function r2y(r)
    return (HEIGHT / 12) * r
end

function Rect:x1()
    local dx = self.alignMode == CENTER and (self.size.x / 2) or 0
    return self.absolutePosition.x - dx
end

function Rect:x2()
    local dx = self.alignMode == CENTER and (self.size.x / 2) or 0
    return self.absolutePosition.x + self.size.x - dx
end

function Rect:y1()
    local dy = self.alignMode == CENTER and (self.size.y / 2) or 0
    return self.absolutePosition.y - dy
end

function Rect:z1()
    local dz = self.alignMode == CENTER and (self.size.z / 2) or 0
    return self.absolutePosition.z - dz
end

function Rect:y2()
    local dy = self.alignMode == CENTER and (self.size.y / 2) or 0
    return self.absolutePosition.y + self.size.y - dy
end

function Rect:z2()
    local dz = self.alignMode == CENTER and (self.size.z / 2) or 0
    return self.absolutePosition.z + self.size.z - dz
end

function Rect:xc()
    local dx = self.alignMode == CENTER and 0 or (self.size.x / 2)
    return self.absolutePosition.x + dx
end

function Rect:yc()
    local dy = self.alignMode == CENTER and 0 or (self.size.y / 2)
    return self.absolutePosition.y + dy
end

function Rect:zc()
    local dz = self.alignMode == CENTER and 0 or (self.size.z / 2)
    return self.absolutePosition.z + dz
end

function Rect:contains(...)
    local v = vec2(...)
    
    if (v.x >= self:x1() and v.x <= self:x2() and
        v.y >= self:y1() and v.y <= self:y2()) then
        return self
    end
end

function Rect:setGridPosition(c, r)
    self:setPosition(c2x(c), r2y(r))
    return self
end

function Rect:setGridSize(col, row)
    self.fixedSize = size(col, row)
    return self
end

function Rect:setPosition(x, y)
    local dx = self.alignMode == CENTER and (self.size.x / 2) or 0
    local dy = self.alignMode == CENTER and (self.size.y / 2) or 0
    self.position.x = x + dx
    self.position.y = y + dy
    return self
end

function Rect:setCenter(x, y)
    local dx = self.alignMode == CENTER and 0 or (self.size.x / 2)
    local dy = self.alignMode == CENTER and 0 or (self.size.y / 2)
    self.position.x = x - dx
    self.position.y = y - dy
    return self
end

function Rect:draw(clr, size)
    self:drawBorder(clr, size)
end

function Rect:drawBorder(clr, size)
    if size or self.borderWidth <= 0 then return end
    
    local x, y = 0, 0 -- self.position.x, self.position.y
    
    stroke(clr or self.borderColor)
    strokeWidth(ceil(size or self.borderWidth))

    noFill()
    
    rectMode(CORNER)    
    rect(x, y, self.size.x, self.size.y)
end

class('Rect3d')

function Rect3d:init(x, y, z, w, h, d)
    self.position = vector(x, y, z)
    self.size = vector(w, h, d)
   
    self.absolutePosition = vector(x, y, z)
end

function Rect3d:setPosition(x, y, z)
    self.position.x = x
    self.position.y = y
    self.position.z = z
    return self
end

function Rect:draw()
    pushMatrix()
    translate(self.position.x, self.position.y, self.position.z)
    box(self.size.x, self.size.y, self.size.z)
    popMatrix()
end
