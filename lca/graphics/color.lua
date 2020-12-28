color = class('Color')

function Color.setup()
    black = Color(0)
    white = Color(1)

    gray = Color(0.5)
    darkgray = Color(0.35)

    red   = Color(1.0, 0.2, 0.2)
    green = Color(0.2, 1.0, 0.2)
    blue  = Color(0.2, 0.2, 1.0)

    yellow = red + green
    pink   = red + blue
    cyan   = green + blue

    brown   = Color(176, 152, 119)
    orange  = Color(255, 165,   0)
    fushia  = Color(225,  48, 123)
    purple  = Color(128,   0, 128)
    navy    = Color(  9,  50, 104)
    gold    = Color(255, 215,   0)
    magenta = Color(255,   0, 255)
    violet  = Color(238, 130, 238)

    pastelRed = Color(255, 105, 97)

    transparent = Color(0, 0)
end

function Color.from(r, g, b, a)
    if type(r) == 'table' then
        return r:clone()
    else
        return Color(r, g, b, a)
    end
end

function Color:init(r, g, b, a)
    if type(r) == 'table' then
        assert()
    else
        if r and r > 1 then r = r / 255 end
        if g and g > 1 then g = g / 255 end
        if b and b > 1 then b = b / 255 end
        if a and a > 1 then a = a / 255 end

        self.r = r or 0
        self.g = b and g or self.r
        self.b = b or self.r
        self.a = a or b and 1 or g or 1
    end
end

function Color:set(r, g, b, a)
    if type(r) == 'table' then
        self.r = r.r
        self.g = r.g
        self.b = r.b
        self.a = r.a
    else
        self:init(r, g, b, a)
    end
end

function Color:clone()
    return Color(self.r, self.g, self.b, self.a)
end

function Color.random(clr, d)
    if clr and d then
        return Color(
            clamp(random(clr.r-d, clr.r+d), 0, 1),
            clamp(random(clr.g-d, clr.g+d), 0, 1),
            clamp(random(clr.b-d, clr.b+d), 0, 1),
            1)
    else
        return Color(
            random(),
            random(),
            random(),
            1)
    end
end

function Color:__tostring()
    return (
        "r="..floor(self.r * 255)..", "..
        "g="..floor(self.g * 255)..", "..
        "b="..floor(self.b * 255)..", "..
        "a="..floor(self.a * 255))
end

function Color:format()
    return (
        "Color("..self.r..", "..
        self.g..", "..
        self.b..", "..
        self.a)..")"
end

function Color:unpack()
    return self.r, self.g, self.b, self.a
end

function Color.__add(clr1, clr2)
    return Color(
        min(1, clr1.r + clr2.r),
        min(1, clr1.g + clr2.g),
        min(1, clr1.b + clr2.b),
        min(1, clr1.a + clr2.a))
end

function Color:mul(coef)
    self.r = self.r * coef
    self.g = self.g * coef
    self.b = self.b * coef
    self.a = self.a * coef
    return self
end

function Color:__mul(coef)
    return Color(self):mul(coef)
end

function Color:__sub(clr)
    return Color(
        ( self.r - clr.r ),
        ( self.g - clr.g ),
        ( self.b - clr.b ),
        ( self.a - clr.a )
    )
end

function Color.__div(p, coef)
    return Color.__mul(p, 1/coef)
end

function Color.__eq(clr1, clr2)
    if (clr1.r == clr2.r and
        clr1.g == clr2.g and
        clr1.b == clr2.b and
        clr1.a == clr2.a)
    then
        return true
    end
end

function Color:rgba()
    return self.r, self.g, self.b, self.a
end

function Color.grayScaleLightness(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = (max(r,g,b) + min(r,g,b)) / 2
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end

function Color.grayScaleAverage(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = (r+g+b) / 3
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end

function Color.grayScaleLuminosity(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = 0.21*r + 0.72*g + 0.07*b
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return Color(c,c,c,clr.a)
    end
end
Color.grayScale = Color.grayScaleLuminosity

function Color.mix(clr1, clr2, dst)
    local src = 1-dst
    return Color(
        min(0, clr1.r * src + clr2.r * dst),
        min(0, clr1.g * src + clr2.g * dst),
        min(0, clr1.b * src + clr2.b * dst),
        min(0, clr1.a * src + clr2.a * dst))
end

function Color.alpha(clr, a)
    return Color(
        clr.r,
        clr.g,
        clr.b,
        a > 1 and a / 255 or a)
end

function Color.darken(clr, pct)
    pct = pct or -50
    return Color.lighten(clr, pct)
end

function Color.lighten(clr, pct)
    pct = pct or 50    
    local h, s, l, a = rgb2hsl(clr.r, clr.g, clr.b, clr.a)
    l = l + l * pct / 100
    return hsl(h,s,l,a)
end

function Color.opposite(clr)
    return Color.complementary(clr, white)
end

function Color.complementary(clr, neutral)
    neutral = neutral or white
    return Color(
        neutral.r - clr.r,
        neutral.g - clr.g,
        neutral.b - clr.b,
        clr.a)
end

function Color.visibleColor(clr)
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

function hsl(h, s, l, a)
    local r, g, b
    if s == 0 then
        r = l
        g = l
        b = l
    else
        local var_1, var_2
        if l < 0.5 then
            var_2 = l * (1 + s)
        else
            var_2 = (l + s) - (s * l)
        end            
        var_1 = 2 * l - var_2

        r = hue2rgb(var_1, var_2, h + (1 / 3)) 
        g = hue2rgb(var_1, var_2, h)
        b = hue2rgb(var_1, var_2, h - (1 / 3))
    end
    return Color(r, g, b, a or 1)
end

function hue2rgb(v1, v2, vH)
    if vH < 0 then
        vH = vH + 1
    end
    if vH > 1 then
        vH = vH - 1
    end
    if (6 * vH) < 1 then
        return v1 + (v2 - v1) * 6 * vH
    end
    if (2 * vH) < 1 then
        return v2
    end
    if (3 * vH) < 2 then
        return v1 + (v2 - v1) * ((2 / 3) - vH) * 6
    end
    return v1
end

function rgb2hsl(...)
    local clr = Color.from(...)
    local r, g, b, a = clr.r, clr.g, clr.b, clr.a

    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h = (max + min)*.5
    local s, l = h, h

    if max == min then
        h, s = 0, 0
    else
        local d = max - min
        s = (l > 0.5) and d / (2 - max - min) or d / (max + min)

        if max == r then
            h = (g - b) / d + (g < b and 6 or 0)
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end

        h = h / 6
    end

    return h, s, l, a
end

function hexa2color(s)
    s = s:lower():replace("#", "")

    local r = tonumber("0x"..string.sub(s, 1, 2)) / 255
    local g = tonumber("0x"..string.sub(s, 3, 4)) / 255
    local b = tonumber("0x"..string.sub(s, 5, 6)) / 255

    return Color(r, g, b)
end

function rgb(r, g, b, a)
    return Color(
        r and r / 255,
        g and g / 255,
        b and b / 255,
        a and a / 255)
end

assert(Color() == Color(0,0,0,1))
assert(Color(1) == Color(1,1,1,1))
assert(Color(1,2,3,4) == Color(1,2,3,4))
assert(Color(1) == Color(1,1,1,1))
assert(Color(1,0) == Color(1,1,1,0))
assert(rgb(255,0) == Color(1,1,1,0))
