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

mt = {}
mt.__index = mt

mt.set = function (self, x, y)
    if x == nil or type(x) == 'number' then
        self.x = x
        self.y = y
    else
        self.x = x.x
        self.y = x.y
    end
    return self
end

mt.clone = function (self)
    return vec2(self)
end

mt.random = function (self, w, h)
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

mt.len = function (self)
    return math.sqrt(self.x^2 + self.y^2)
end

mt.add = function (self, v, coef)
    coef = coef or 1
    self.x = self.x + v.x * coef
    self.y = self.y + v.y * coef                
    return self
end

mt.sub = function (self, v, coef)
    coef = coef or 1
    self.x = self.x - v.x * coef
    self.y = self.y - v.y * coef                
    return self
end

mt.mul = function (self, coef)
    self.x = self.x * coef
    self.y = self.y * coef
    return self
end

mt.normalize = function (self, coef)
    coef = coef or 1
    local len = self:len()
    if len > 0 then
        self.x = self.x * coef / len
        self.y = self.y * coef / len
    end
    return self
end

mt.tobytes = function (v)
    return v.values
end

mt.__len = function (v)
    return 2
end

mt.__pairs = function (v)
    local i = 0
    local attribs = {'x', 'y'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i]
        end
    end
    return f, v, nil
end

vec2 = ffi.metatype('vec2', mt)
