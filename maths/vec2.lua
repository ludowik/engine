local __cos, __sin, __degrees, __radians, __atan2, __sqrt = math.cos, math.sin, math.deg, math.rad, math.atan2, math.sqrt

ffi = require 'ffi'

ffi.cdef [[
    typedef union vec2 {
        struct {
            float x;
            float y;
        };
        float values[2];
	} vec2;
]]

local mt = {}

function mt:__index(key)
    if type(key) == 'number' then
        return self.values[key-1]
    else
        return rawget(mt, key)
    end
end

function mt:set(x, y)
    if x == nil or type(x) == 'number' then
        self.x = x or 0
        self.y = y or 0
    else
        self.x = x.x
        self.y = x.y
    end
    return self
end

function mt:clone()
    return vec2(self)
end

function mt:tovec3()
    return vec3(self.x, self.y, 0)
end

function mt:round()
    self.x = round(self.x)
    self.y = round(self.y)

    return self
end

function mt.random(w, h)
    if w and h then
        return vec2(
            randomInt(w),
            randomInt(h))
    else
        w = w or 1
        return vec2(
            w * (random() * 2 - 1),
            w * (random() * 2 - 1))
    end
end

function mt:__tostring()
    return (
        "vec2{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. "}")
end
mt.tostring = mt.__tostring

function mt.__eq(v1, v2)
    if (v1 and
        v2 and
        v1.x == v2.x and
        v1.y == v2.y)
    then
        return true
    end
end

function mt:floor()
    return vec2(
        floor(self.x),
        floor(self.y))
end

function mt:len()
    return __sqrt(
        self.x^2 +
        self.y^2)
end

function mt:lenSquared()
    return 
        self.x^2 +
        self.y^2
end

function mt:dist(v)
    return __sqrt(
        (v.x - self.x)^2 +
        (v.y - self.y)^2)
end

function mt:add(v, coef)
    coef = coef or 1
    self.x = self.x + v.x * coef
    self.y = self.y + v.y * coef
    return self
end

function mt:__add(v)
    return self:clone():add(v)
end

function mt:sub(v, coef)
    coef = coef or 1
    self.x = self.x - v.x * coef
    self.y = self.y - v.y * coef
    return self
end

function mt:__sub(v)
    return self:clone():sub(v)
end

function mt:unm()
    self.x = -self.x
    self.y = -self.y
    return self
end

function mt:__unm()
    return self:clone():unm()
end

function mt:mul(coef)
    if type(coef) == 'number' then
        self.x = self.x * coef
        self.y = self.y * coef
    else
        self.x = self.x * coef.x
        self.y = self.y * coef.y
    end
    return self
end

function mt:__mul(coef)
    if type(self) == 'number' then
        self, coef = coef, self
    end
    return self:clone():mul(coef)
end

function mt:div(coef)
    return self:mul(1/coef)
end

function mt:__div(coef)
    return self:__mul(1/coef)
end

function mt:normalize(coef)
    return self:clone():normalizeInPlace(coef)
end

function mt:normalizeInPlace(coef)
    coef = coef or 1

    local len = self:len()
    if len > 0 then
        self.x = self.x * coef / len
        self.y = self.y * coef / len
    end

    return self
end

function mt:crossByScalar(s)
    return vec2(s * self.y, -s * self.x)
end

function mt:crossFromScalar(s)
    return vec2(-s * self.y, s * self.x)
end

function mt:cross(v)
    return self:clone():crossInPlace(v)
end

function mt:crossInPlace(v)
    local x = self.y * v.z - self.z * v.y
    local y = self.z * v.x - self.x * v.z

    self.x = x
    self.y = y

    return self
end

function mt:rotate(phi, origin, mode)
    return self:clone():rotateInPlace(phi, origin, mode)
end

function mt:rotateInPlace(phi, origin, mode)
    local c, s
    
    mode = mode or angleMode()    
    if mode == DEGREES then
        c, s = __cos(__radians(phi)), __sin(__radians(phi))
    else
        c, s = __cos(phi), __sin(phi)
    end

    if origin then
        self:sub(origin)
    end

    local x, y
    x = c * self.x - s * self.y
    y = s * self.x + c * self.y

    self.x = x
    self.y = y

    if origin then
        self:add(origin)
    end

    return self
end

function mt:angleBetween(other)
    local alpha1 = __atan2(self.y, self.x)
    local alpha2 = __atan2(other.y, other.x)

    return alpha2 - alpha1
end

function mt:dot(v)
    return (
        self.x * v.x +
        self.y * v.y
    )
end

function mt:tobytes()
    return self.values
end

function mt:__len()
    return 2
end

function mt:__ipairs()
    local i = 0
    local attribs = {'x', 'y'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return i, self[i]
        end
    end
    return f, self, nil
end

function mt:__pairs()
    local i = 0
    local attribs = {'x', 'y'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], self[i]
        end
    end
    return f, self, nil
end

function mt:unpack()
    return self.x, self.y
end

function mt:draw()
    point(self.x, self.y)
end

local ORDER = 'counter-clockwise'

function mt.enclosedAngle(v1, v2, v3)
    local a1 = __atan2(v1.y - v2.y, v1.x - v2.x)
    local a2 = __atan2(v3.y - v2.y, v3.x - v2.x)

    local da
    if ORDER == 'clockwise' then
        da = __degrees(a2 - a1)
    else
        da = __degrees(a1 - a2)
    end

    if da < -180 then
        da = da + 360
    elseif da > 180 then
        da = da - 360
    end

    return da
end

-- Determines if a vector |v| is inside a triangle described by the vectors
-- |v1|, |v2| and |v3|.
function mt.isInsideTriangle(v, v1, v2, v3)
    local a1
    local a2

    a1 = mt.enclosedAngle(v1, v2, v3)
    a2 = mt.enclosedAngle(v, v2, v3)
    if a2 > a1 or a2 < 0 then
        return false
    end

    a1 = mt.enclosedAngle(v2, v3, v1)
    a2 = mt.enclosedAngle(v, v3, v1)
    if a2 > a1 or a2 < 0 then
        return false
    end

    a1 = mt.enclosedAngle(v3, v1, v2)
    a2 = mt.enclosedAngle(v, v1, v2)
    if a2 > a1 or a2 < 0 then
        return false
    end

    return true
end

function xy(x, y, coef)
    assert(coef == nil)
    if type(x) == 'table' or type(x) == 'cdata' then
        return x.x, x.y, y or 1
    end
    return x or 0, y or 0, coef or 1
end

__vec2 = ffi.metatype('vec2', mt)
__vec2ref = ffi.typeof('vec2&')

class 'vec2' : meta(__vec2)

function vec2:init(x, y)
    return __vec2():set(x, y)
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
