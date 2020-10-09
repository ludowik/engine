class('Rect')

function Rect:init(x, y, w, h)
    self.position = vec3(x, y)
    self.size = vec3(w, h)

    self.absolutePosition = vec3(x, y)
end

function Rect:setPosition(x, y)
    self.position.x = x
    self.position.y = y
    return self
end

function Rect:contains(x, y)
    if y == nil then
        x, y = x.x, x.y
    end

    x = x - self.position.x
    y = y - self.position.y

    if (x >= 0 and x <= self.size.x and
        y >= 0 and y <= self.size.y) then
        return true
    end
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
