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

mt = {}
mt.__index = mt

mt.set = function (clr, r, g, b, a)
    if r == nil or type(r) == 'number' then
        clr.r = r or 0
        clr.g = g or clr.r
        clr.b = b or clr.r
        clr.a = a or (clr.r > 1 and 255 or 1)
    else
        clr.r = r.r
        clr.g = r.g
        clr.b = r.b
        clr.a = r.a
    end

    if clr.r > 1 then
        clr.r = clr.r / 255
        clr.g = clr.g / 255
        clr.b = clr.b / 255
        clr.a = clr.a / 255
    end
end

mt.clone = function (self)
    return Color(self)
end

mt.tobytes = function (clr)
    return clr.values
end

mt.__len = function (v)
    return 4
end

mt.__pairs = function (v)
    local i = 0
    local attribs = {'r', 'g', 'b', 'a'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i]
        end
    end
    return f, v, nil
end

color_meta = ffi.metatype('color', mt)

class 'Color'

function Color:init(r, g, b, a)
    local self = color_meta()
    self:set(r, g, b, a)
    return self
end

function Color.random()
    return Color(
        math.random(),
        math.random(),
        math.random(),
        1)
end

local __clr = Color()
function Color.args(r, g, b, a)
    if type(r) == 'cdata' then
        return r
    else
        __clr:set(r, g, b, a)
        return __clr
    end
end

black = Color(0)
white = Color(1)

gray = Color(0.5)

red   = Color(1, 0, 0)
green = Color(0, 1, 0)
blue  = Color(0, 0, 1)

yellow  = Color(1, 1, 0)
magenta = Color(1, 0, 1)
cyan    = Color(0, 1, 1)

transparent = Color(0, 0, 0, 0)
