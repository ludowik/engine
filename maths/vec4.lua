local __sqrt, __floor = math.sqrt, math.floor

ffi = require 'ffi'

ffi.cdef [[
    typedef union vec4 {
        struct {
            float x;
            float y;
            float z;
            float w;
        };
        float values[4];
	} vec4;
]]

local mt = {}

function mt:__index(key)
    if type(key) == 'number' then
        return self.values[key-1]
    else
        return rawget(mt, key)
    end
end

function mt:set(x, y, z, w)
    if x == nil or type(x) == 'number' then
        self.x = x or 0
        self.y = y or 0
        self.z = z or 0
        self.w = w or 1
    else
        self.x = x.x
        self.y = x.y
        self.z = x.z or 0
        self.w = x.w or 0
    end
    return self
end

function mt:clone()
    return vec4(self)
end

function mt:tovec3()
    return vec3(self.x, self.y, self.z)
end

function mt.random(w, h, d)
    if w and h and d then
        return vec4(
            randomInt(w),
            randomInt(h),
            randomInt(d),
            1)
    else
        w = w or 1
        return vec4(
            w * (random() * 2 - 1),
            w * (random() * 2 - 1),
            w * (random() * 2 - 1),
            1)
    end
end

function mt:__tostring()
    return (
        "vec4{"..
        "x=" .. ( round(self.x, 2) or 'nan' ) .. ", " ..
        "y=" .. ( round(self.y, 2) or 'nan' ) .. ", " ..
        "z=" .. ( round(self.z, 2) or 'nan' ) .. ", " ..
        "w=" .. ( round(self.w, 2) or 'nan' ) .. "}")
end
mt.tostring = mt.__tostring

function mt.__eq(v1, v2)
    if (v1 and
        v2 and
        v1.x == v2.x and
        v1.y == v2.y and
        v1.z == v2.z and
        v1.w == v2.w)
    then
        return true
    end
end

function mt:floor()
    return vec4(
        __floor(self.x),
        __floor(self.y),
        __floor(self.z),
        1)
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

function mt:len()
    return __sqrt(
        self.x^2 +
        self.y^2 +
        self.z^2)
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
    self.x = self.x * coef
    self.y = self.y * coef
    self.z = self.z * coef
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
    return 4
end

function mt:__ipairs()
    local i = 0
    local attribs = {'x', 'y', 'z', 'w'}
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
    local attribs = {'x', 'y', 'z', 'w'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], self[i]
        end
    end
    return f, self, nil
end

function mt:unpack()
    return self.x, self.y, self.z, self.w
end

function mt:draw()
    pushMatrix()
    translate(self.x, self.y, self.z)
    sphere(1)
    popMatrix()
end

function xyzw(x, y, z, w, coef)
    assert(coef == nil)
    if type(x) == 'table' or type(x) == 'cdata' then
        return x.x, x.y, x.z or 0, x.w or 0, y or 1
    end
    return x or 0, y or 0, z or 0, w or 0, coef or 1
end

__vec4 = ffi.metatype('vec4', mt)

class 'vec4' : meta(__vec4)

function vec4:init(x, y, z, w)
    return __vec4():set(x, y, z, w)
end

function vec4.test()
    assert(vec4() == vec4(0, 0))
    assert(vec4(1) == vec4(1,0))
    assert(vec4(1,2) == vec4(1,2))
    assert(vec4():normalize() == vec4(0, 0))
    assert(vec4():normalizeInPlace() == vec4(0, 0))
    assert(vec4(1,0):len() == 1)
    assert(vec4(0,1):len() == 1)
    assert(vec4(1,1):mul(2) == vec4(2,2))
    assert(vec4(1,2,3).x == vec4(1,2,3)[1])
    assert(vec4(1,2,3).y == vec4(1,2,3)[2])
    assert(vec4(1,2,3).z == vec4(1,2,3)[3])
end
