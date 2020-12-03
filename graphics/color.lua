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

function mt:__index(key)
    if type(key) == 'number' then
        return self.values[key-1]
    else
        return rawget(mt, key)
    end
end

function mt:set(r, g, b, a)
    if r == nil or type(r) == 'number' then
        if a then
            self.r = r
            self.g = g
            self.b = b
            self.a = a

        elseif b then
            self.r = r
            self.g = g
            self.b = b
            self.a = (self.r > 1 or self.g > 1 or self.b > 1) and 255 or 1

        elseif g then
            self.r = r
            self.g = r
            self.b = r
            self.a = g

        elseif r then
            self.r = r
            self.g = r
            self.b = r
            self.a = (self.r > 1 or self.g > 1 or self.b > 1) and 255 or 1

        else
            self.r = 0
            self.g = 0
            self.b = 0
            self.a = 1
        end

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

function mt:tobytes()
    return self.values
end

function mt:__len()
    return 4
end

function mt:__ipairs()
    local i = 0
    local attribs = {'r', 'g', 'b', 'a'}
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
    local attribs = {'r', 'g', 'b', 'a'}
    local f = function ()
        if i < #attribs then
            i = i + 1
            return attribs[i], self[i]
        end
    end
    return f, self, nil
end

function mt:unpack()
    return self.r, self.g, self.b, self.a
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

function mt.min(a, b)
    return Color(
        min(a.r, b.r),
        min(a.g, b.g),
        min(a.b, b.b),
        1)
end

function mt.max(a, b)
    return Color(
        max(a.r, b.r),
        max(a.g, b.g),
        max(a.b, b.b),
        1)
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

function mt.grayScaleIntensity(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = 0.299*r + 0.587*g + 0.114*b
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end

mt.grayScale = mt.grayScaleIntensity

function mt.mix(clr1, clr2, dst)
    dst = dst or 0.5
    local src = 1 - dst

    return Color(
        max(0, clr1.r * src + clr2.r * dst),
        max(0, clr1.g * src + clr2.g * dst),
        max(0, clr1.b * src + clr2.b * dst),
        max(0, clr1.a * src + clr2.a * dst))
end

function mt.avg(clr1, clr2)
    return Color(
        (clr1.r + clr2.r) / 2,
        (clr1.g + clr2.g) / 2,
        (clr1.b + clr2.b) / 2,
        (clr1.a + clr2.a) / 2)
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

