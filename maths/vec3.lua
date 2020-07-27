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

function mt:set(x, y, z)
    if x == nil or type(x) == 'number' then
        self.x = x or 0
        self.y = y or 0
        self.z = z or 0
    else
        self.x = x.x
        self.y = x.y
        self.z = x.z or 0
    end
    return self
end

function mt:clone()
    return vec3(self)
end

function mt:tovec3()
    return self
end

function mt.random(w, h, d)
    if w and h and d then
        return vec3(
            random.range(w),
            random.range(h),
            random.range(d))
    else
        w = w or 1
        return vec3(
            w * (random.random() * 2 - 1),
            w * (random.random() * 2 - 1),
            w * (random.random() * 2 - 1))
    end
end

function mt:__tostring()
    return (
        "vec3{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. ", " ..
        "z=" .. ( round(self.z, 2) or 'nan' ) .. "}")
end
mt.tostring = mt.__tostring

function mt.__eq(v1, v2)
    if (v1 and
        v2 and
        v1.x == v2.x and
        v1.y == v2.y and
        v1.z == v2.z)
    then
        return true
    end
end

function mt:floor()
    return vec3(
        floor(self.x),
        floor(self.y),
        floor(self.z))
end

mt.len = function (self)
    return math.sqrt(self.x^2 + self.y^2 + self.z^2)
end

mt.dist = function (self, v)
    return math.sqrt(
        (v.x - self.x)^2 +
        (v.y - self.y)^2 +
        (v.z - self.z)^2)
end

mt.add = function (self, v, coef)
    coef = coef or 1
    self.x = self.x + v.x * coef
    self.y = self.y + v.y * coef
    self.z = self.z + (v.z or 0) * coef
    return self
end

mt.__add = function (self, v)
    return self:clone():add(v)
end

mt.sub = function (self, v, coef)
    coef = coef or 1
    self.x = self.x - v.x * coef
    self.y = self.y - v.y * coef
    self.z = self.z - (v.z or 0) * coef
    return self
end

mt.__sub = function (self, v)
    return self:clone():sub(v)
end

function mt.unm(p)
    p.x = -p.x
    p.y = -p.y
    p.z = -p.z
    return p
end

mt.__unm = function (self, v)
    return self:clone():mul(-1)
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

mt.tobytes = function (v)
    return v.values
end

mt.__len = function (v)
    return 3
end

mt.__ipairs = function (v)
    local i = 0
    local attribs = {'x', 'y', 'z'}
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
    local attribs = {'x', 'y', 'z'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], v[i]
        end
    end
    return f, v, nil
end

mt.unpack = function (v)
    return v.x, v.y, v.z
end

function mt.draw(v)
    pushMatrix()
    translate(v.x, v.y, v.z)
    sphere(1)
    popMatrix()
end

__vec3 = ffi.metatype('vec3', mt)

class 'test__vec3' : meta(__vec3)
function vec3(x, y, z)
    return __vec3():set(x, y, z)
end

function xyz(x, y, z, coef)
    assert(coef == nil)
    if type(x) == 'table' or type(x) == 'cdata' then 
        return x.x, x.y, x.z or 0, y or 1
    end
    return x or 0, y or 0, z or 0, coef or 1
end

function test__vec3.test()
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
