class('HeightsMapGenerator')

local pow, sin, cos = pow, sin, cos

function HeightsMapGenerator:init()
    self.amplitudeMax = 200
    self.amplitudeMin = 50

    self.octaves = 4
    self.roughness = 0.3

    self.seed = 10 --random(100000000)
end

function HeightsMapGenerator:getHeight(x, z)
    return noise(x*0.01234, z*0.01234) * self.amplitudeMax - self.amplitudeMin
--    local total = 0
--    local d = pow(2, self.octaves-1)
--    for i=0,self.octaves-1 do
--        local freq = pow(2, i) / d

--        local amplitudeMin = pow(self.roughness, i) * self.amplitudeMin
--        local amplitudeMax = pow(self.roughness, i) * self.amplitudeMax

--        local y = self:getInterpolateNoise(x*freq, z*freq)
--        if y >= 0 then
--            total = total + y * amplitudeMax
--        else
--            total = total + y * amplitudeMin
--        end
--    end
--    return total
end

--function HeightsMapGenerator:getHeight(x, z)
--    return glm.getHeight(x, z)
--end

--function HeightsMapGenerator:getHeight(x, z)
--    return (
--        self:applyAmplitude(x, z, 4, 1) +
--        self:applyAmplitude(x, z, 2, 3) +
--        self:applyAmplitude(x, z, 1, 9))
--end

function HeightsMapGenerator:applyAmplitude(x, z, octave, factor)
    local y = self:getInterpolateNoise(x/octave, z/octave)
    if y >= 0 then
        return y * self.amplitudeMax / factor
    else
        return y * self.amplitudeMin / factor
    end
end

function HeightsMapGenerator:getInterpolateNoise(x, z)
    local function interpolate(a, b, blend)
        local theta = blend * PI
        local f = (1 - cos(theta)) * 0.5
        return a * (1 - f) + b * f
    end

    local xInt = floor(x)
    local zInt = floor(z)

    local xFrac = x-xInt
    local zFrac = z-zInt

    local v1 = self:getSmoothNoise(xInt, zInt)
    local v2 = self:getSmoothNoise(xInt+1, zInt)
    local v3 = self:getSmoothNoise(xInt, zInt+1)
    local v4 = self:getSmoothNoise(xInt+1 , zInt+1)

    local i1 = interpolate(v1, v2, xFrac)
    local i2 = interpolate(v3, v4, xFrac)

    local i3 = interpolate(i1, i2, zFrac)

    return i3
end

function HeightsMapGenerator:getSmoothNoise(x, z)
    local corner = (self:getNoise(x-1, z-1) +
        self:getNoise(x-1, z+1) +
        self:getNoise(x+1, z-1) +
        self:getNoise(x+1, z+1)) / 16

    local sides = (self:getNoise(x+1, z) +
        self:getNoise(x-1, z) +
        self:getNoise(x, z+1) +
        self:getNoise(x, z-1)) / 8

    local center = self:getNoise(x, z) / 4

    return corner + sides + center
end

function HeightsMapGenerator:getNoise(x, z)
    return noise(x, z)
--    math.randomseed(x * 49632 + z * 325176 + self.seed)
--    return random() * 2 - 1
end
