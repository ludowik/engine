ffi = require 'ffi'

ffi.cdef [[
    typedef union {
        struct {
            float x;
            float y;
        };
        float values[2];
	} vec2;
]]

vec2 = ffi.metatype('vec2', {
        __index = {
            len = function (self)
                return math.sqrt(self.x^2 + self.y^2)
            end,

            clone = function (self)
                return vec2(self)
            end,

            set = function (self, x, y)
                self.x = x
                self.y = y
            end,

            add = function (self, v, coef)
                coef = coef or 1
                self.x = self.x + v.x * coef
                self.y = self.y + v.y * coef                
                return self
            end,

            mul = function (self, coef)
                self.x = self.x * coef
                self.y = self.y * coef
                return self
            end,

            normalize = function (self, coef)
                coef = coef or 1
                local len = self:len()
                if len > 0 then
                    self.x = self.x * coef / len
                    self.y = self.y * coef / len
                end
                return self
            end
        }
    }
)

