math.maxinteger = 2^ 52
math.mininteger = 2^-52

pi = math.pi
tau = 2 * math.pi

deg = math.deg
rad = math.rad

cos = math.cos
sin = math.sin
tan = math.tan
atan = math.atan

function ceil(num, idp)
    idp = idp or 0
    local mult = 10^idp
    return math.ceil(num * mult) / mult
end

function floor(num, idp)
    idp = idp or 0
    local mult = 10^idp
    return math.floor(num * mult) / mult
end

function math.round(num, idp)
    idp = idp or 0
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
end
round = math.round

min = math.min
max = math.max

function math.clamp(value, _min, _max)
    return min(max(value, _min), _max)
end
clamp = math.clamp

function math.smoothstep(edge0, edge1, x)
    -- Scale, bias and saturate x to 0..1 range
    x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)

    -- Evaluate polynomial
    return x * x * (3 - 2 * x)
end
smoothstep = math.smoothstep

function math.smootherstep(edge0, edge1, x)
    -- Scale, and clamp x to 0..1 range
    x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)

    -- Evaluate polynomial
    return x * x * x * (x * (x * 6 - 15) + 10)
end
smootherstep = math.smootherstep

function math.map(value, min_in, max_in, min_out, max_out)
    if min_in == max_in then
        return max_out
    end
    value = (value - min_in) * (max_out - min_out) / (max_in - min_in) + (min_out)

    if min_in < max_out then
        return clamp(value, min_out, max_out)
    else
        return clamp(value, max_out, min_out)
    end
end
map = math.map

pow = math.pow
sqrt = math.sqrt

abs = math.abs

function math.sign(v)
    if v > 0 then
        return 1
    elseif v < 0 then
        return -1
    else
        return 0
    end    
end
sign = math.sign

function math.quotient(dividend, divisor)
    return ceil(dividend / divisor)
end
quotient = math.quotient

function math.dist(x1, y1, x2, y2)
    return vec2(x1,y1):dist(vec2(x2,y2))
end
dist = math.dist
