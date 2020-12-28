class('color')

function color:init(...)
    self:set(...)
end

function color:set(r, g, b, a)
    if type(r) == 'table' then
        r, g, b, a = r.r, r.g, r.b, r.a
    end

    self.r = r or 0
    self.g = g or self.r
    self.b = b or self.r
    self.a = a or 1

    if self.r >= 2 or self.g >= 2 or self.b >= 2 then
        self.r = self.r / 255
        self.g = self.g / 255
        self.b = self.b / 255
    end
    
    if self.a >= 2 then
        self.a = self.a / 255
    end
end

function color:clone()
    return color(self)
end

function color:__tostring()
    return (
        "r="..self.r..", "..
        "g="..self.g..", "..
        "b="..self.b..", "..
        "a="..self.a)
end

function color:__add(clr)
    local new = color()
    new.r = min(1, self.r + clr.r)
    new.g = min(1, self.g + clr.g)
    new.b = min(1, self.b + clr.b)
    new.a = min(1, self.a + clr.a)

    return new
end

function color:mul(coef)
    self.r = self.r * coef
    self.g = self.g * coef
    self.b = self.b * coef
    self.a = self.a * coef
    return self
end

function color:__mul(coef)
    return Color(self):mul(coef)
end

function color:__sub(clr)
    return color(
        ( self.r - clr.r ),
        ( self.g - clr.g ),
        ( self.b - clr.b ),
        ( self.a - clr.a )
    )
end

function color.__div(p, coef)
    return color.__mul(p, 1/coef)
end

function color:__eq(v)
    if self.r ~= v.r or self.g ~= v.g or self.b ~= v.b or self.a ~= v.a then
        return false
    end
    return true
end

function color:rgba()
    return self.r, self.g, self.b, self.a
end

function color:unpack()
    return self.r, self.g, self.b, self.a
end

function color.grayScaleLightness(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = (max(r,g,b) + min(r,g,b)) / 2
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return color(c,c,c,clr.a)
    end
end

function color.grayScaleAverage(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = (r+g+b) / 3
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return color(c,c,c,clr.a)
    end
end

function color.grayScaleLuminosity(clr, to)
    local r,g,b = clr.r, clr.g, clr.b
    local c = 0.21*r + 0.72*g + 0.07*b
    if to then
        to.r, to.g, to.b, to.a = c, c, c, clr.a
        return to
    else
        return color(c,c,c,clr.a)
    end
end
color.grayScale = color.grayScaleLuminosity

function color.mix(clr1, clr2, dst)
    local src = dst-1
    return color(
        min(1, clr1.r * src + clr2.r * dst),
        min(1, clr1.g * src + clr2.g * dst),
        min(1, clr1.b * src + clr2.b * dst),
        min(1, clr1.a * src + clr2.a * dst))
end

function color.alpha(clr, a)
    return color(
        clr.r,
        clr.g,
        clr.b,
        a > 1 and a / 255 or a)
end

function color.darken(clr, pct)
    pct = pct or -50
    return color.lighten(clr, pct)
end

function color.lighten(clr, pct)
    pct = pct or 50    
    local h, s, l, a = rgb2hsl(clr.r, clr.g, clr.b, clr.a)
    l = l + l * pct / 100
    return hsl(h,s,l,a)
end

function color.opposite(clr)
    return complementary(clr, white)
end

function color.complementary(clr, neutral)
    neutral = neutral or white
    return color(
        neutral.r - clr.r,
        neutral.g - clr.g,
        neutral.b - clr.b,
        clr.a)
end

function color.visibleColor(clr)
    local cm = ( clr.r + clr.g + clr.b ) / 3

    local m

    if cm < 128 then
        m = 255
    else
        m = 0
    end

    return color(
        m,
        m,
        m,
        clr.a)
end

function color.random(clr, d)
    if clr and d then
        return color(
            random(clr.r-d, clr.r+d),
            random(clr.g-d, clr.g+d),
            random(clr.b-d, clr.b+d))
        
    else
        return color(
            random(),
            random(),
            random())
    end
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
    return color(r, g, b, a or 1)
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
    local clr = color(...)
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

    return color(r, g, b)
end

black = color(0)
white = color(1)

gray = color(0.5)
darkgray = color(0.35)

red   = color(1, 0, 0)
green = color(0, 1, 0)
blue  = color(0, 0, 1)

yellow = red + green
pink   = red + blue
cyan   = green + blue

brown   = color(176, 152, 119)
orange  = color(255, 165,   0)
fushia  = color(225,  48, 123)
purple  = color(128,   0, 128)
navy    = color(  9,  50, 104)
gold    = color(255, 215,   0)
magenta = color(255,   0, 255)
violet  = color(238, 130, 238)

pastelRed = color(255, 105, 97)