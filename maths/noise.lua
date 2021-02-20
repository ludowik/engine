local __PI, __pow, __random = math.pi, math.pow, math.random

function noise(x, y)
    if x and y and z then
        return noise3(x, y, z)
    elseif x and y then
        return noise2(x, y)
    elseif x then
        return perlin(x)
    end
end

function lerp(a, b, t)
    return a + (b - a) * t
end

function remap_cos(t)
    return (1 - cos(t * __PI)) * 0.5
end

function remap_smoothstep(t)
    return t * t * (3 - 2 * t)
end

function remap_perlin(t)
    return 6 * __pow(t, 5) - 15 * __pow(t, 4) + 10 * __pow(t, 3)
end

function frand(x)
    seed(x)
    return __random()
end

function noise1(x)
    local xi = floor(x)
    local t = x - xi

    -- random
    local a = frand(xi)
    local b = frand(xi+1)

    -- remap
    t = remap_cos(t)

    -- interpolate
    return lerp(a, b, t)
end

function noise2(x, y)
    local xi = floor(x)
    local tx = x - xi

    local yi = floor(y)
    local ty = y - yi

    -- random
    local a0 = frand((yi)*(xi))
    local b0 = frand((yi)*(xi+1))

    local a1 = frand((yi+1)*(xi))
    local b1 = frand((yi+1)*(xi+1))

    -- remap
    tx = remap_smoothstep(tx)
    ty = remap_smoothstep(ty)

    local nx0 = lerp(a0, b0, tx)
    local nx1 = lerp(a1, b1, tx)

    -- interpolate
    return lerp(nx0, nx1, ty)
end

function perlin(x)
    local numLayers = 5

    local amplitude = 1
    local amplitudeSum = 1

    local frequency = 1

    local rateOfChange = 2

    local noiseSum = 0

    for i=0,numLayers-1 do
        -- change in frequency and amplitude
        noiseSum = noiseSum + noise1(x * frequency) * amplitude

        amplitude = amplitude * 0.5 -- 1, 0.5, 0.25, 0.0625, ...
        amplitudeSum = amplitudeSum + amplitude

        frequency = frequency * 2 -- 1, 2, 4, 8 ...
    end

    return noiseSum / amplitudeSum
end

function pink(x)
    local numLayers = 5

    local rateOfChange = 2

    local pinkNoise = 0

    for i=0,numLayers-1 do
        -- change in frequency and amplitude
        pinkNoise = pinkNoise + noise1(x * __pow(rateOfChange, i)) / __pow(rateOfChange, i)
    end

    return pinkNoise
end
