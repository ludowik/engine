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

color = class 'Color'

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
