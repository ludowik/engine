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

local mt = {}

mt.__index = function (v, key)
    if type(key) == 'number' then
        return v.values[key-1]
    else
        return rawget(mt, key)
    end
end

function mt:set(r, g, b, a)
    if r == nil or type(r) == 'number' then
        self.r = r or 0
        self.g = g or self.r
        self.b = b or self.r
        self.a = a or (self.r > 1 and 255 or 1)
    else
        self.r = r.r
        self.g = r.g
        self.b = r.b
        self.a = r.a
    end

    if self.r > 1 then
        self.r = self.r / 255
        self.g = self.g / 255
        self.b = self.b / 255
        self.a = self.a / 255
    end
    return self
end

function mt:clone()
    return Color(self)
end

function mt:__tostring()
    return (
        "color{"..
        "r=" .. ( round(self.r, 2) or 'nan' ) .. ", " ..
        "g=" .. ( round(self.g, 2) or 'nan' ) .. ", " ..
        "b=" .. ( round(self.b, 2) or 'nan' ) .. ", " ..
        "a=" .. ( round(self.a, 2) or 'nan' ) .. "}")
end
mt.tostring = mt.__tostring

mt.tobytes = function (clr)
    return clr.values
end

mt.__len = function (v)
    return 4
end

mt.__ipairs = function (v)
    local i = 0
    local attribs = {'r', 'g', 'b', 'a'}
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
    local attribs = {'r', 'g', 'b', 'a'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], v[i]
        end
    end
    return f, v, nil
end

mt.unpack = function (v)
    return v.r, v.g, v.b, v.a
end

function mt.random()
    return Color(
        math.random(),
        math.random(),
        math.random(),
        1)
end

function mt.__add(clr1, clr2)
    return Color(
        min(1, clr1.r + clr2.r),
        min(1, clr1.g + clr2.g),
        min(1, clr1.b + clr2.b),
        min(1, clr1.a + clr2.a))
end

function mt:mul(coef)
    self.r = self.r * coef
    self.g = self.g * coef
    self.b = self.b * coef
    self.a = self.a * coef
    return self
end

function mt:__mul(coef)
    return Color(self):mul(coef)
end

function mt:__sub(clr)
    return Color(
        ( self.r - clr.r ),
        ( self.g - clr.g ),
        ( self.b - clr.b ),
        ( self.a - clr.a )
    )
end

function mt.__div(p, coef)
    return Color.__mul(p, 1/coef)
end

function mt.__eq(clr1, clr2)
    if (clr1 and
        clr2 and 
        clr1.r == clr2.r and
        clr1.g == clr2.g and
        clr1.b == clr2.b and
        clr1.a == clr2.a)
    then
        return true
    end
end

function mt.grayScaleLightness(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = (max(r,g,b) + min(r,g,b)) / 2
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end

function mt.grayScaleAverage(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = (r+g+b) / 3
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end

function mt.grayScaleLuminosity(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = 0.21*r + 0.72*g + 0.07*b
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end
mt.grayScale = mt.grayScaleLuminosity

function mt.mix(clr1, clr2, dst)
    local src = 1-dst
    return Color(
        min(0, clr1.r * src + clr2.r * dst),
        min(0, clr1.g * src + clr2.g * dst),
        min(0, clr1.b * src + clr2.b * dst),
        min(0, clr1.a * src + clr2.a * dst))
end

function mt.alpha(clr, a)
    return Color(
        clr.r,
        clr.g,
        clr.b,
        a > 1 and a / 255 or a)
end

function mt.darken(clr, pct)
    pct = pct or -50
    return clr:lighten(pct)
end

function mt.lighten(clr, pct)
    pct = pct or 50    
    local h, s, l, a = rgb2hsl(clr.r, clr.g, clr.b, clr.a)
    l = l + l * pct / 100
    return hsl(h,s,l,a)
end

function mt.opposite(clr)
    return Color.complementary(clr, white)
end

function mt.complementary(clr, neutral)
    neutral = neutral or white
    return Color(
        neutral.r - clr.r,
        neutral.g - clr.g,
        neutral.b - clr.b,
        clr.a)
end

function mt.visibleColor(clr)
    local cm = ( clr.r + clr.g + clr.b ) / 3

    local m

    if cm < 128 then
        m = 255
    else
        m = 0
    end

    return Color(
        m,
        m,
        m,
        clr.a)
end

__color = ffi.metatype('color', mt)

color = class 'Color' : meta(__color)
function Color:init(r, g, b, a)
    return __color():set(r, g, b, a)
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

brown = Color(165, 42, 42, 255)

transparent = Color(0, 0, 0, 0)
