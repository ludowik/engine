ffi = require 'ffi'

ffi.cdef [[
    typedef union color {
        struct {
            float r;
            float g;
            float b;
            float a;
        };
        float values[4];
	} color;
]]

color_meta = ffi.metatype('color', {
        __index = {            
            tobytes = function (clr)
                return clr.values
            end,

            set = function (clr, r, g, b, a)
                clr.r = r or 0
                clr.g = g or clr.r
                clr.b = b or clr.r
                clr.a = a or 1
                
                if clr.r > 1 then
                    clr.r = clr.r / 255
                    clr.g = clr.g / 255
                    clr.b = clr.b / 255
                    clr.a = clr.a / 255
                end
            end
        }
    })

function Color(r, g, b, a)
    local self = color_meta()
    self:set(r, g, b, a)
    return self
end

black = Color(0)
white = Color(1)

red   = Color(1, 0, 0)
green = Color(0, 1, 0)
blue  = Color(0, 0, 1)
