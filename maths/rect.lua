class 'Rect'

function Rect:init(x, y, w, h)
    self.position = vec3(x, y)
    self.size = vec3(w, h)

    self.absolutePosition = vec3(x, y)

    self.rotation = 0
end

function Rect:setPosition(x, y, z)
    if y == nil then
        x, y, z = x.x, x.y, x.z or 0
    end

    self.position.x = x
    self.position.y = y
    self.position.z = z or 0

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

function Rect:w()
    return self.size.x
end

function Rect:h()
    return self.size.y
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

function Rect:leftBottom()
    return vec3(
        min(self:x1(), self:x2()),
        min(self:y1(), self:y2()))
end

function Rect:leftTop()
    return vec3(
        min(self:x1(), self:x2()),
        max(self:y1(), self:y2()))
end

function Rect:rightBottom()
    return vec3(
        max(self:x1(), self:x2()),
        min(self:y1(), self:y2()))
end

function Rect:rightTop()
    return vec3(
        max(self:x1(), self:x2()),
        max(self:y1(), self:y2()))
end

function Rect:center()
    return vec3(
        self:xc(),
        self:yc())
end

function Rect:fx()
    local w, h = self:w(), self:h()
    if w == 0 then
        return self.position.x, nil
    end
    local a = h / w
    local b = self:y2() - (a * self:x2())
    return a, b
end
