class('vector')

function vector:init(x, y, z)
    if type(x) == 'table' then
        x, y, z = x.x, x.y, x.z
    end

    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

vector.properties.get[1] = function (self) return self.x end
vector.properties.get[2] = function (self) return self.y end
vector.properties.get[3] = function (self) return self.z end

vector.properties.set[1] = function (self, x) self.x = x end
vector.properties.set[2] = function (self, y) self.y = y end
vector.properties.set[3] = function (self, z) self.z = z end

function vector:__tostring()
    return (
        "vec3{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. ", " ..
        "z=" .. ( round(self.z, 2) or 'nan' ) .. "}")
end
vector.tostring = vector.__tostring

function vector.random(r)
    if r then
        return vector(
            random(-r, r),
            random(-r, r),
            random(-r, r))
    else
        return vector(
            random() * WIDTH,
            random() * HEIGHT,
            random() * HEIGHT)
    end
end

function vector:unpack()
    return self.x, self.y, self.z
end

function vector.add(p1, x, y, z)
    p1.x = p1.x + x
    p1.y = p1.y + y
    p1.z = p1.z + (z or 0)
    return p1
end

function vector.__add(p1, p2)
    return vector(p1):add(p2.x, p2.y, p2.z)
end

function vector.sub(p1, x, y, z)
    p1.x = p1.x - x
    p1.y = p1.y - y
    p1.z = p1.z - (z or 0)
    return p1
end

function vector.__sub(p1, p2)
    return vector(p1):sub(p2.x, p2.y, p2.z)
end

function vector.__mul(p, coef)
    if type(p) == 'number' then
        coef, p = p, coef
    end

    if type(coef) == 'number' then
        return vector(
            p.x * coef,
            p.y * coef,
            p.z * coef)
    end

    return p:dot(coef)
end

function vector.__div(p, coef)
    return vector.__mul(p, 1/coef)
end

function vector.__unm(p)
    return vector(
        -p.x,
        -p.y,
        -p.z)
end

function vector:__eq(v)
    if self.x ~= v.x or self.y ~= v.y or self.z ~= v.z then
        return false
    end
    return true
end

function vector:len()
    return math.sqrt(
        self.x^2 +
        self.y^2 +
        self.z^2)
end

function vector:normalize()
    local len = self:len()
    if len > 0 then
        local inv = 1 / len

        return vector(
            self.x * inv,
            self.y * inv,
            self.z * inv)
    end
    return vector()
end

function vector:floor()
    return vector(
        floor(self.x),
        floor(self.y),
        floor(self.z))
end

function vector:dist(v)
    return (v - self):len()
end

function vector:dot(v)
    return (
        self.x * v.x +
        self.y * v.y +
        self.z * v.z)
end

function vector:cross(v)
    return vector(
        self.y * v.z - self.z * v.y,
        self.z * v.x - self.x * v.z,
        self.x * v.y - self.y * v.x)
end

vec3 = vector
