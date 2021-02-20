local __sqrt, __floor = math.sqrt, math.floor

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

function mt:__index(key)
    if type(key) == 'number' then
        return self.values[key-1]
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
            randomInt(w),
            randomInt(h),
            randomInt(d))
    else
        w = w or 1
        return vec3(
            w * (random() * 2 - 1),
            w * (random() * 2 - 1),
            w * (random() * 2 - 1))
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
        __floor(self.x),
        __floor(self.y),
        __floor(self.z))
end

function mt:len()
    return __sqrt(
        self.x^2 +
        self.y^2 +
        self.z^2)
end

function mt:lenSquared()
    return 
        self.x^2 +
        self.y^2 +
        self.z^2
end

function mt:dist(v)
    return __sqrt(
        (v.x - self.x)^2 +
        (v.y - self.y)^2 +
        (v.z - self.z)^2)
end

function mt:add(v, coef)
    coef = coef or 1
    self.x = self.x + v.x * coef
    self.y = self.y + v.y * coef
    self.z = self.z + (v.z or 0) * coef
    return self
end

function mt:__add(v)
    return self:clone():add(v)
end

function mt:sub(v, coef)
    coef = coef or 1
    self.x = self.x - v.x * coef
    self.y = self.y - v.y * coef
    self.z = self.z - (v.z or 0) * coef
    return self
end

function mt:__sub(v)
    return self:clone():sub(v)
end

function mt:unm()
    self.x = -self.x
    self.y = -self.y
    self.z = -self.z
    return self
end

function mt:__unm()
    return self:clone():unm()
end

function mt:mul(coef)
    if type(coef) == 'number' then
        self.x = self.x * coef
        self.y = self.y * coef
        self.z = self.z * coef
    else
        self.x = self.x * coef.x
        self.y = self.y * coef.y
        self.z = self.z * coef.z
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
        self.z = self.z * coef / len
    end

    return self
end

function mt:cross(v)
    return self:clone():crossInPlace(v)
end

function mt:crossInPlace(v)
    local x = self.y * v.z - self.z * v.y
    local y = self.z * v.x - self.x * v.z
    local z = self.x * v.y - self.y * v.x

    self.x = x
    self.y = y
    self.z = z

    return self
end

function mt:dot(v)
    return (
        self.x * v.x +
        self.y * v.y +
        self.z * v.z
    )
end

function mt:tobytes()
    return self.values
end

function mt:__len()
    return 3
end

function mt:__ipairs()
    local i = 0
    local attribs = {'x', 'y', 'z'}
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
    local attribs = {'x', 'y', 'z'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], self[i]
        end
    end
    return f, self, nil
end

function mt:unpack()
    return self.x, self.y, self.z
end

function mt:draw()
    pushMatrix()
    translate(self.x, self.y, self.z)
    sphere(1)
    popMatrix()
end

function xyz(x, y, z, coef)
    assert(coef == nil)
    if type(x) == 'table' or type(x) == 'cdata' then
        return x.x, x.y, x.z or 0, y or 1
    end
    return x or 0, y or 0, z or 0, coef or 1
end

__vec3 = ffi.metatype('vec3', mt)
__vec3ref = ffi.typeof('vec3&')

class 'vec3' : meta(__vec3)

function vec3:init(x, y, z)
    return __vec3():set(x, y, z)
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
