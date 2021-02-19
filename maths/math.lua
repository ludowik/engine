local __min, __max, __floor, __ceil = math.min, math.max, math.floor, math.ceil

math.PI = math.pi

math.tau = 2 * math.pi
math.TAU = math.tau

PI = math.pi
PI2 = math.pi / 2
PI4 = math.pi / 4

TAU = math.tau

cos = math.cos
sin = math.sin

rad = math.rad
deg = math.deg

min = math.min
max = math.max

sqrt = math.sqrt
pow = math.pow

tan = math.tan
atan = math.atan
atan2 = math.atan2

abs = math.abs

math.maxinteger =  2^52
math.mininteger = -2^52

math.MAX_INTEGER = math.maxinteger
math.MIN_INTEGER = math.mininteger

function math.avg(a, b)
    return (a + b) / 2
end

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

function ceil(num, idp)
    idp = idp or 0
    local mult = 10^idp
    return __ceil(num * mult) / mult
end

function floor(num, idp)
    idp = idp or 0
    local mult = 10^idp
    return __floor(num * mult) / mult
end

function math.round(num, idp)
    idp = idp or 0
    local mult = 10^idp
    return __floor(num * mult + 0.5) / mult
end
round = math.round

function math.clamp(value, _min, _max)
    return __min(__max(value, _min), _max)
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

    value = clamp(value, min_in, max_in)

    value = (value - min_in) * (max_out - min_out) / (max_in - min_in) + (min_out)

    return value
end
map = math.map

function math.quotient(dividend, divisor)
    return __ceil(dividend / divisor)
end
quotient = math.quotient

function math.fract(x)
    return x - floor(x)
end
fract = math.fract

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

    ut.assertEqual('clamp', clamp(5, 1, 9), 5)
    ut.assertEqual('clamp', clamp(0, 1, 9), 1)
    ut.assertEqual('clamp', clamp(10, 1, 9), 9)

    for i=1,10 do
        ut.assertEqual('map', math.map(i, 1, 10, 1, 10), i)
        ut.assertEqual('map', math.map(i, 1, 10, 11, 20), i+10)
    end

    ut.assertEqual('map', math.map(0, 1, 10, 2, 10), 2)
    ut.assertEqual('map', math.map(11, 1, 10, 2, 5), 5)
    
    ut.assertEqual('map', math.map(5.5, 0, 10, 0, 100), 55)
end
