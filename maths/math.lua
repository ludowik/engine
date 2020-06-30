math.tau = 2 * math.pi
math.TAU = 2 * math.pi

math.PI = math.pi

PI = math.pi
TAU = math.tau

cos = math.cos
sin = math.sin

rad = math.rad
deg = math.deg

min = math.min
max = math.max

ceil = math.ceil
floor = math.floor

sqrt = math.sqrt
pow = math.pow

tan = math.tan
atan = math.atan
atan2 = math.atan2

abs = math.abs

math.maxinteger =  2^52
math.mininteger = -2^52

function math.sign(value)
    if value > 0 then
        return 1
    elseif value < 0 then
        return -1
    else
        return 0
    end
end
sign = math.sign

function math.round(value)
    return math.floor(value+0.5)
end
round = math.round

function math.clamp(value, _min, _max)
    return math.min(math.max(value, _min), _max)
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

function math.quotient(dividend, divisor)
    return math.ceil(dividend / divisor)
end
quotient = math.quotient

function math.fract(x)
    return x - floor(x)
end
fract = math.fract
