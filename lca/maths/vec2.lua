class('vec2')

local function xy(x, y, coef)
    if type(x) == 'table' then 
        return x.x, x.y, y or 1
    end
    return x, y, coef or 1
end

function vec2:init(x, y)
    x, y = xy(x, y)

    self.x = x or 0
    self.y = y or 0
end

function vec2:set(x, y)
    self:init(x, y)
    return self
end

function vec2:clone()
    return vec2(self.x, self.y)
end

vec2.properties.get[1] = function (self) return self.x end
vec2.properties.get[2] = function (self) return self.y end

vec2.properties.set[1] = function (self, x) self.x = x end
vec2.properties.set[2] = function (self, y) self.y = y end

function vec2:unpack()
    return self.x, self.y
end

function vec2:__tostring()
    return (
        "vec2{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. "}")
end
vec2.tostring = vec2.__tostring

function vec2:draw()
    point(self.x, self.y)
end

function vec2.random(min, max)
    if min then
        return vec2(
            random(min, max),
            random(min, max))
    else
        return vec2(
            random(W),
            random(H))
    end
end

function vec2:normalize(size)
    assert(config.noOptimization)

    local len = self:len()
    if len == 0 then
        return vec2()
    else
        local norm = (size or 1) / len
        return vec2(
            self.x * norm,
            self.y * norm)
    end
end

function vec2:normalizeInPlace(size)
    local len = self:len()
    if len == 0 then
        self.x, self.y = 0, 0
    else
        local norm = (size or 1) / len
        self.x = self.x * norm
        self.y = self.y * norm
    end

    return self
end

function vec2:len()
    return math.sqrt(
        self.x^2 +
        self.y^2
    )
end

function vec2:dist(v)
    return math.sqrt(
        (v.x - self.x)^2 +
        (v.y - self.y)^2
    )
end

function dist(x1, y1, x2, y2)
    assert(config.noOptimization)

    return vec2(x1, y1):dist(vec2(x2, y2))
end

function vec2:dot(v)
    return (
        self.x * v.x +
        self.y * v.y
    )
end

function vec2:rotate(phi)
    assert(config.noOptimization)

    local c, s = cos(phi), sin(phi)
    return vec2(
        c * self.x - s * self.y,
        s * self.x + c * self.y)
end

function vec2:rotateInPlace(phi)
    local c, s = cos(phi), sin(phi)

    local x, y
    x = c * self.x - s * self.y
    y = s * self.x + c * self.y

    self.x = x
    self.y = y

    return self
end

function vec2:angleBetween(other)
    local alpha1 = atan2(self.y, self.x)
    local alpha2 = atan2(other.y, other.x)

    return alpha2 - alpha1
end

function vec2:mul(coef)
    self.x = self.x * coef
    self.y = self.y * coef
    return self
end

function vec2.__mul(v, coef)
    assert(config.noOptimization)

    if type(v) == 'number' then
        v, coef = coef, v
    end
    return vec2(v.x, v.y):mul(coef)
end

function vec2:div(coef)
    return self:mul(1/coef)
end

function vec2.__div(v, coef)
    assert(config.noOptimization)

    if type(v) == 'number' then
        v, coef = coef, v
    end
    return vec2(v.x, v.y):mul(1/coef)
end

function vec2.add(p1, x, y, coef)
    x, y, coef = xy(x, y, coef)

    p1.x = p1.x + x * coef
    p1.y = p1.y + y * coef
    return p1
end

function vec2.__add(v1, v2)
    assert(config.noOptimization)

    return vec2(
        v1.x + v2.x,
        v1.y + v2.y)
end

function vec2.sub(p1, x, y, coef)
    x, y, coef = xy(x, y, coef)

    p1.x = p1.x - x * coef
    p1.y = p1.y - y * coef
    return p1
end

function vec2.__sub(v1, v2)
    assert(config.noOptimization)

    return vec2(
        v1.x - v2.x,
        v1.y - v2.y)
end

function vec2.from(v1, v2)
    return vec2(
        v1.x - v2.x,
        v1.y - v2.y)
end

function vec2.unm(p)
    p.x = -p.x
    p.y = -p.y    
    return p
end

function vec2.__unm(v1)
    assert(config.noOptimization)

    return vec2(
        -v1.x,
        -v1.y)
end

function vec2.__eq(v1, v2)
    if (v1.x == v2.x and
        v1.y == v2.y)
    then
        return true
    end
end

function vec2:floor()
    assert(config.noOptimization)

    return vec2(
        floor(self.x),
        floor(self.y))
end


function vec2:cross(v)
    assert(config.noOptimization)

    return vec2(
        self.y * v.z - self.z * v.y,
        self.z * v.x - self.x * v.z)
end

local ORDER = 'counter-clockwise'

function enclosedAngle(v1, v2, v3)
    local a1 = math.atan2(v1.y - v2.y, v1.x - v2.x)
    local a2 = math.atan2(v3.y - v2.y, v3.x - v2.x)
    local da
    if ORDER == 'clockwise' then
        da = math.deg(a2 - a1)
    else
        da = math.deg(a1 - a2)
    end
    if da < -180 then da = da + 360 elseif da > 180 then da = da - 360 end
    return da
end

-- Determines if a vector |v| is inside a triangle described by the vectors
-- |v1|, |v2| and |v3|.
function isInsideTriangle(v, v1, v2, v3)
    local a1
    local a2
    a1 = enclosedAngle(v1, v2, v3)
    a2 = enclosedAngle(v, v2, v3)
    if a2 > a1 or a2 < 0 then return false end
    a1 = enclosedAngle(v2, v3, v1)
    a2 = enclosedAngle(v, v3, v1)
    if a2 > a1 or a2 < 0 then return false end
    a1 = enclosedAngle(v3, v1, v2)
    a2 = enclosedAngle(v, v1, v2)
    if a2 > a1 or a2 < 0 then return false end
    return true
end

function vec2.test()
    assert(vec2() == vec2(0, 0))
    assert(vec2(1) == vec2(1,0))
    assert(vec2(1,2) == vec2(1,2))
    assert(vec2():normalize() == vec2(0, 0))
    assert(vec2(1,0):len() == 1)
    assert(vec2(0,1):len() == 1)
    assert(vec2(1,1):mul(2) == vec2(2,2))
    assert(vec2(1,2).x == vec2(1,2)[1])
    assert(vec2(1,2).y == vec2(1,2)[2])
end
