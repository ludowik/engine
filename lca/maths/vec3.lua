class('vec3')

local function xyz(x, y, z, coef)
    if type(x) == 'table' then 
        return x.x, x.y, x.z or 0, y or 1
    end
    return x, y, z or 0, coef or 1
end

function vec3:init(x, y, z)
    x, y, z = xyz(x, y, z)

    self.x = x or 0
    self.y = y or 0
    self.z = z or 0
end

function vec3:set(x, y, z)
    self:init(x, y, z)
    return self
end

function vec3:clone()
    return vec3(self.x, self.y, self.z)
end

vec3.properties.get[1] = function (self) return self.x end
vec3.properties.get[2] = function (self) return self.y end
vec3.properties.get[3] = function (self) return self.z end

vec3.properties.set[1] = function (self, x) self.x = x end
vec3.properties.set[2] = function (self, y) self.y = y end
vec3.properties.set[3] = function (self, z) self.z = z end

function vec3:unpack()
    return self.x, self.y, self.z
end

function vec3:__tostring()
    return (
        "vec3{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. ", " ..
        "z=" .. ( round(self.z, 2) or 'nan' ) .. "}")
end
vec3.tostring = vec3.__tostring

function vec3:draw(self)
    -- TODO
end

function vec3.random(r)
    r = r or 1
    return vec3(
        random(-1, 1),
        random(-1, 1),
        random(-1, 1))
end

function vec3:normalize(size)
    assert(config.noOptimization)

    local len = self:len()
    if len == 0 then
        return vec3()
    else
        local norm = (size or 1) / len
        return vec3(
            self.x * norm,
            self.y * norm,
            self.z * norm)
    end
end

function vec3:normalizeInPlace(size)
    local len = self:len()
    if len == 0 then
        self.x, self.y, self.z = 0, 0, 0
    else
        local norm = (size or 1) / len
        self.x = self.x * norm
        self.y = self.y * norm
        self.z = self.z * norm
    end

    return self
end

function vec3:len()
    return math.sqrt(
        self.x^2 +
        self.y^2 +
        self.z^2
    )
end

function vec3:dist(v)
    return math.sqrt(
        (v.x - self.x)^2 +
        (v.y - self.y)^2 +
        (v.z - self.z)^2
    )
end

function vec3:dot(v)
    return (
        self.x * v.x +
        self.y * v.y +
        self.z * v.z
    )
end

function vec3:cross(v)
    assert(config.noOptimization)

    return vec3(
        self.y * v.z - self.z * v.y,
        self.z * v.x - self.x * v.z,
        self.x * v.y - self.y * v.x)
end

function vec3:crossInPlace(v)
    local x = self.y * v.z - self.z * v.y
    local y = self.z * v.x - self.x * v.z
    local z = self.x * v.y - self.y * v.x

    self.x = x
    self.y = y
    self.z = z

    return self
end

function vec3:add(x, y, z, coef)
    x, y, z, coef = xyz(x, y, z, coef)

    self.x = self.x + x * coef
    self.y = self.y + y * coef
    self.z = self.z + z * coef
    return self
end

function vec3.__add(v1, v2)
    assert(config.noOptimization)

    return vec3(
        v1.x + v2.x,
        v1.y + v2.y,
        v1.z + (v2.z or 0))
end

function vec3.translate(v1, v2)
    return vec3(
        v1.x + v2.x,
        v1.y + v2.y,
        v1.z + (v2.z or 0))
end

function vec3.sub(p1, x, y, z, coef)
    x, y, z, coef = xyz(x, y, z, coef)

    p1.x = p1.x - x * coef
    p1.y = p1.y - y * coef
    p1.z = p1.z - z * coef
    return p1
end

function vec3.__sub(v1, v2)
    assert(config.noOptimization)

    return vec3(
        v1.x - v2.x,
        v1.y - v2.y,
        v1.z - v2.z)
end

function vec3.from(v1, v2)
    return vec3(
        v1.x - v2.x,
        v1.y - v2.y,
        v1.z - v2.z)
end

function vec3:mul(coef)
    self.x = self.x * coef
    self.y = self.y * coef
    self.z = self.z * coef
    return self
end

function vec3.__mul(v, coef)
    assert(config.noOptimization)

    if type(v) == 'number' then
        v, coef = coef, v
    end
    return vec3(v.x, v.y, v.z):mul(coef)
end

function vec3:div(coef)
    return self:mul(1/coef)
end

function vec3.__div(v, coef)
    assert(config.noOptimization)

    if type(v) == 'number' then
        v, coef = coef, v
    end
    return vec3(v.x, v.y, v.z):mul(1/coef)
end

function vec3.unm(p)
    p.x = -p.x
    p.y = -p.y
    p.z = -p.z
    return p
end

function vec3.__unm(v1, v2)
    assert(config.noOptimization)

    return vec3(
        -v1.x,
        -v1.y,
        -v1.z)
end

function vec3.__eq(v1, v2)
    if (v1.x == v2.x and
        v1.y == v2.y and
        v1.z == v2.z)
    then
        return true
    end
end

function vec3:floor()
    assert(config.noOptimization)

    return vec3(
        floor(self.x),
        floor(self.y),
        floor(self.z))
end

function vec3.test()
    assert(vec3() == vec3(0, 0))
    assert(vec3(1) == vec3(1,0))
    assert(vec3(1,2) == vec3(1,2))
    assert(vec3():normalize() == vec3(0, 0))
    assert(vec3():normalizeInPlace() == vec3(0, 0))
    assert(vec3(1,0):len() == 1)
    assert(vec3(0,1):len() == 1)
    assert(vec3(1,1):mul(2) == vec3(2,2))
    assert(vec3(1,2,3).x == vec3(1,2,3)[1])
    assert(vec3(1,2,3).y == vec3(1,2,3)[2])
    assert(vec3(1,2,3).z == vec3(1,2,3)[3])
end
