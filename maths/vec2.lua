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

mt.__index = function (v, key)
    if type(key) == 'number' then
        return v.values[key-1]
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

function mt.random(w, h)
    if w then
        return vec2(
            random.range(w),
            random.range(h or w))
    else
        return vec2(
            random.random(),
            random.random())
    end
end

function mt:__tostring()
    return (
        "vec2{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. "}")
end
mt.tostring = mt.__tostring

mt.len = function (self)
    return math.sqrt(
        self.x^2 +
        self.y^2)
end

mt.dist = function (self, v)
    return math.sqrt(
        (v.x - self.x)^2 +
        (v.y - self.y)^2)
end

mt.add = function (self, v, coef)
    coef = coef or 1
    self.x = self.x + v.x * coef
    self.y = self.y + v.y * coef                
    return self
end

mt.__add = function (self, v)
    return self:clone():add(v)
end

mt.sub = function (self, v, coef)
    coef = coef or 1
    self.x = self.x - v.x * coef
    self.y = self.y - v.y * coef                
    return self
end

mt.__sub = function (self, v)
    return self:clone():sub(v)
end

mt.__unm = function (self, v)
    return self:clone():mul(-1)
end

mt.mul = function (self, coef)
    self.x = self.x * coef
    self.y = self.y * coef
    return self
end

mt.__mul = function(self, coef)
    if type(self) == 'number' then
        self, coef = coef, self
    end
    return self:clone():mul(coef)
end

mt.div = function (self, coef)
    return self:mul(1/coef)
end

mt.__div = function (self, coef)
    return self:__mul(1/coef)
end

mt.normalize = function (self, coef)
    return self:clone():normalizeInPlace(coef)
end

mt.normalizeInPlace = function (self, coef)
    coef = coef or 1

    local len = self:len()
    if len > 0 then
        self.x = self.x * coef / len
        self.y = self.y * coef / len
    end

    return self
end

function mt:rotate(phi)
    assert(config.noOptimization)

    local c, s = cos(phi), sin(phi)
    return vec2(
        c * self.x - s * self.y,
        s * self.x + c * self.y)
end

function mt:rotateInPlace(phi)
    local c, s = cos(phi), sin(phi)

    local x, y
    x = c * self.x - s * self.y
    y = s * self.x + c * self.y

    self.x = x
    self.y = y

    return self
end

function mt:angleBetween(other)
    local alpha1 = atan2(self.y, self.x)
    local alpha2 = atan2(other.y, other.x)

    return alpha2 - alpha1
end

function mt.from(v1, v2)
    return vec2(
        v1.x - v2.x,
        v1.y - v2.y)
end

mt.tobytes = function (v)
    return v.values
end

mt.__len = function (v)
    return 2
end

mt.__ipairs = function (v)
    local i = 0
    local attribs = {'x', 'y'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return i, v[i]
        end
    end
    return f, v, nil
end

mt.__pairs = function (v)
    local i = 0
    local attribs = {'x', 'y'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], v[i]
        end
    end
    return f, v, nil
end

mt.unpack = function (v)
    return v.x, v.y
end

function mt.draw()
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

    if da < -180 then
        da = da + 360
    elseif da > 180 then
        da = da - 360
    end

    return da
end

-- Determines if a vector |v| is inside a triangle described by the vectors
-- |v1|, |v2| and |v3|.
function isInsideTriangle(v, v1, v2, v3)
    local a1
    local a2

    a1 = enclosedAngle(v1, v2, v3)
    a2 = enclosedAngle(v, v2, v3)
    if a2 > a1 or a2 < 0 then
        return false 
    end

    a1 = enclosedAngle(v2, v3, v1)
    a2 = enclosedAngle(v, v3, v1)
    if a2 > a1 or a2 < 0 then 
        return false 
    end

    a1 = enclosedAngle(v3, v1, v2)
    a2 = enclosedAngle(v, v1, v2)
    if a2 > a1 or a2 < 0 then
        return false 
    end

    return true
end

__vec2 = ffi.metatype('vec2', mt)

class 'vec2' : meta(__vec2)
function vec2:init(x, y)
    return __vec2():set(x, y)
end
