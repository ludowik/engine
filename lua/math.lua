function math.sign(value)
    if value > 0 then
        return 1
    elseif value < 0 then
        return -1
    else
        return 0
    end
end
abs = math.abs

function math.round(value)
    return math.floor(value+0.5)
end

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

sqrt = math.sqrt
pow = math.pow

sin = math.sin
cos = math.cos

rad = math.rad
deg = math.deg

round = math.round
ceil = math.ceil
floor = math.floor

fract = math.fract

min = math.min
max = math.max

tan = math.tan
atan = math.atan
atan2 = math.atan2

PI = math.pi
TAU = math.pi * 2

math.tau = TAU

math.MAX_INTEGER = 2^ 52
math.MIN_INTEGER = 2^-52

class('__math')

function __math.test()
    ut.assertEqual('min', min(1,9), 1)
    ut.assertEqual('max', max(1,9), 9)

    ut.assertEqual('tointeger', tointeger(1.9), 1)

    ut.assertEqual('round.down', round(1), 1)
    ut.assertEqual('round.down', round(1.4), 1)

    ut.assertEqual('round.up', round(1.5), 2)
    ut.assertEqual('round.up', round(1.9), 2)
    ut.assertEqual('round.up', round(2), 2)

    ut.assertEqual('tau', TAU, math.pi * 2)

    ut.assertBetween('random', random(), 0, 1)
end
