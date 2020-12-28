local vector = class('vector2')

function vector:init(x, y)
    if type(x) == 'table' then
        x, y = x.x, x.y
    end

    self.x = x or 0
    self.y = y or 0
end

vector.properties.get[1] = function (self) return self.x end
vector.properties.get[2] = function (self) return self.y end

vector.properties.set[1] = function (self, x) self.x = x end
vector.properties.set[2] = function (self, y) self.y = y end

function vector:__tostring()
    return (
        "vec2{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. "}")
end
vector.tostring = vector.__tostring

function vector.random(r)
    if r then
        return vector(
            random(-r, r),
            random(-r, r))
    else
        return vector(
            random() * WIDTH,
            random() * HEIGHT)
    end
end

function vector:unpack()
    return self.x, self.y
end

function vector.add(p1, x, y)
    p1.x = p1.x + x
    p1.y = p1.y + y
    return p1
end

function vector.__add(p1, p2)
    return vector(p1):add(p2.x, p2.y)
end

function vector.sub(p1, x, y)
    p1.x = p1.x - x
    p1.y = p1.y - y
    return p1
end

function vector.__sub(p1, p2)
    return vector(p1):sub(p2.x, p2.y)
end

function vector.mul(p, coef)
    if type(coef) == 'number' then
        p.x = p.x * coef
        p.y = p.y * coef
        return p
    end

    return p:dot(coef)
end

function vector.__mul(p, coef)
    if type(p) == 'number' then
        coef, p = p, coef
    end

    if type(coef) == 'number' then
        return vector(
            p.x * coef,
            p.y * coef)
    end

    return p:dot(coef)
end

function vector.div(p, coef)
    return vector.mul(p, 1/coef)
end

function vector.__div(p, coef)
    return vector.__mul(p, 1/coef)
end

function vector.unm(p)
    p.x = -p.x
    p.y = -p.y    
    return p
end

function vector.__unm(p)
    return vector(p):unm()
end

function vector:__eq(v)
    if self.x ~= v.x or self.y ~= v.y then
        return false
    end
    return true
end

function vector:len()
    return math.sqrt(
        self.x^2 +
        self.y^2)
end

function vector:normalize()
    local len = self:len()
    if len > 0 then
        local inv = 1 / len

        return vector(
            self.x * inv,
            self.y * inv)
    end
    return vector()
end

function vector:floor()
    return vector(
        floor(self.x),
        floor(self.y))
end

function vector:dist(v)
    return (v - self):len()
end

function dist(x1, y1, x2, y2)
    return vector(x1, y1):dist(vector(x2, y2))
end

function vector:dot(v)
    return (
        self.x * v.x +
        self.y * v.y)
end

function vector:cross(v)
    return vector(
        self.y * v.z - self.z * v.y,
        self.z * v.x - self.x * v.z)
end

function vector:rotate(phi)
    local c, s = cos(phi), sin(phi)
    return vector(
        c * self.x - s * self.y,
        s * self.x + c * self.y)
end

function vector:angleBetween(other)
    local alpha1 = math.atan2(self.y, self.x)
    local alpha2 = math.atan2(other.y, other.x)

    return alpha2 - alpha1
end

vec2 = vector
