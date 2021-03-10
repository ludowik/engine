function hsl(h, s, l, a)
    return Color(hsl2rgb(h, s, l, a))
end

function hsl2rgb(h, s, l, a)
    h = h or 0.5
    s = s or 0.5
    l = l or 0.5
    
    local r, g, b
    if s == 0 then
        r = l
        g = l
        b = l
    else
        if h > 1 or s > 1 or l > 1 then
            h = h / 255
            s = s / 100
            l = l / 100
        end
        
        local var_1, var_2
        if l < 0.5 then
            var_2 = l * (1 + s)
        else
            var_2 = (l + s) - (s * l)
        end
        var_1 = 2 * l - var_2

        r = __hue2rgb(var_1, var_2, h + (1 / 3))
        g = __hue2rgb(var_1, var_2, h)
        b = __hue2rgb(var_1, var_2, h - (1 / 3))
    end
    return r, g, b, a or 1
end

function __hue2rgb(v1, v2, vH)
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
    local clr = Color(...)
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
