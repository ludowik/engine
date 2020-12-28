-- random

function perlin(x, y, z)
    x = x or 0
    y = y or 0
    z = z or 0

    local res = noise(x, y, z)
    for n = 1,2 do
        res = res + noise(n*x, n*y, n*z) / n
    end
    
    return res
end

perlin = noise --glm and glm.perlin2d or perlin

function noise1(x, y)
    return perlin(x, y)
end

function noise2(x, y)
    local noise = 0
    for p = 1,4 do
        noise = noise + perlin(p*x, p*y) / p
    end
    return noise
end

function noise3(x, y)
    local noise = 0
    for p = 1,4 do
        noise = noise + abs(perlin(p*x, p*y)) / p
    end
    return noise
end

function noise4(x, y)
    local noise = x
    for p = 1,4 do
        noise = noise + abs(perlin(p*x, p*y)) / p
    end
    return math.sin(noise)
end
