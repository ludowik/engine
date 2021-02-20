class 'Rect'

function Rect:init(x, y, w, h)
    self.position = vec3(x, y)
    self.size = vec3(w, h)

    self.absolutePosition = vec3(x, y)

    self.rotation = 0
end

function Rect.random(w, h, size)
    return Rect(
        random(w),
        random(h),
        random(size or 10),
        random(size or 10))
end

function Rect:draw()
    rectMode(self.alignMode or CORNER)
    rect(self.position.x, self.position.y, self.size.x, self.size.y)
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

function Rect:setSize(w, h, d)
    if h == nil then
        w, h, d = w.x, w.y, w.z or 0
    end

    self.size.x = w
    self.size.y = h
    self.size.z = d or 0

    return self
end

function Rect:contains(x, y, z)
    if y == nil then
        x, y, z = x.x, x.y, x.z
    end

    x = x - self.position.x
    y = y - self.position.y
    z = (z or 0) - self.position.z

    if (x >= 0 and x <= self.size.x and
        y >= 0 and y <= self.size.y and
        z >= 0 and z <= (self.size.z or 0)) then
        return true
    end
end

function Rect:intersect(rect)
    return AABBintersectAABB(self, rect)
end

function Rect:w()
    return self.size.x
end

function Rect:h()
    return self.size.y
end

function Rect:d()
    return self.size.z
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

function Rect:xmin()
    return min(self:x1(), self:x2())
end

function Rect:xmax()
    return max(self:x1(), self:x2())
end

function Rect:ymin()
    return min(self:y1(), self:y2())
end

function Rect:ymax()
    return max(self:y1(), self:y2())
end

function Rect:zmin()
    return min(self:z1(), self:z2())
end

function Rect:zmax()
    return max(self:z1(), self:z2())
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

class 'Cube' : extends(Rect)

function Cube:init(x, y, z, w, h, d)
    self.position = vec3(x, y, z)
    self.size = vec3(w, h, d)

    self.absolutePosition = vec3(x, y, z)

    self.rotation = 0
end

function Cube.random(w, h, d, size)
    return Cube(
        random(w),
        random(h),
        random(d),
        random(size or 100),
        random(size or 100),
        random(size or 100))
end

function Cube:draw()
    box(self.position.x, self.position.y, self.position.z, self.size.x, self.size.y, self.size.z)
end

function Cube:intersect(cube)
    return cubeIntersectCube(self, cube)
end
