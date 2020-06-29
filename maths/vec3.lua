ffi = require 'ffi'

ffi.cdef [[
    typedef union vec3 {
        struct {
            float x;
            float y;
            float z;
        };
        float values[3];
	} vec3;
]]

local mt = {}

mt.__index = function (v, key)
    if type(key) == 'number' then
        return v.values[key-1]
    else
        return rawget(mt, key)
    end
end

mt.len = function (self)
    return math.sqrt(self.x^2 + self.y^2 + self.z^2)
end

mt.clone = function (self)
    return vec3(self)
end

mt.set = function (self, x, y, z)
    if type(x) == 'number' then
        self.x = x
        self.y = y
        self.z = z
    else
        self.x = x.x
        self.y = x.y
        self.z = x.z
    end
    return self
end

mt.random = function (self, w, h, d)
    if w then
        return vec3(
            random.range(w),
            random.range(h or w),
            random.range(d or w))
    else
        return vec3(
            random.random(),
            random.random(),
            random.random())
    end
end

mt.add = function (self, v, coef)
    coef = coef or 1
    self.x = self.x + v.x * coef
    self.y = self.y + v.y * coef
    self.z = self.z + v.z * coef
    return self
end

mt.__add = function (self, v)
    return self:clone():add(v)
end

mt.sub = function (self, v, coef)
    coef = coef or 1
    self.x = self.x - v.x * coef
    self.y = self.y - v.y * coef
    self.z = self.z - v.z * coef
    return self
end

mt.__sub = function (self, v)
    return self:clone():sub(v)
end

mt.mul = function (self, coef)
    self.x = self.x * coef
    self.y = self.y * coef
    self.z = self.z * coef
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
        self.z = self.z * coef / len
    end

    return self
end

mt.cross = function (self, v)
    return self:clone():crossInPlace(v)
end

mt.crossInPlace = function (self, v)
    local x = self.y * v.z - self.z * v.y
    local y = self.z * v.x - self.x * v.z
    local z = self.x * v.y - self.y * v.x

    self.x = x
    self.y = y
    self.z = z

    return self
end

mt.dot = function (self, v)
    return (
        self.x * v.x +
        self.y * v.y +
        self.z * v.z
    )
end

mt.tobytes = function (clr)
    return clr.values
end

mt.__len = function (clr)
    return 3
end

vec3 = ffi.metatype('vec3', mt)
