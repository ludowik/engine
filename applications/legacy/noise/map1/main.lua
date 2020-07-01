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

App('appMap')

function appMap:suspend()
    terrain = mesh()
end

function appMap:init()
    Application.init(self)

    supportedOrientations(LANDSCAPE_ANY)

    parameter.number('opacity', 0, 255, 100)

    parameter.number('playerX', -200, 200, 0)
    parameter.number('playerZ', -200, 200, 0)

    self.hmg = HeightsMapGenerator()

    camera(500, 100, 500, -100, 0, -500)

    skybox = Model.skybox(100000)
    skybox.texture = image('documents:skybox')

    self.s = 10
    local s = self.s

    terrain = mesh()

    sea = mesh()

    local a = vec3(0, 0, 0)
    local b = vec3(s, 0, 0)
    local c = vec3(s, 0, -s)
    local d = vec3(0, 0, -s)

    local w = debugging() and 32 or 256
    local h = debugging() and 32 or 256

    self.heightMap = {}

    local heightMap = self.heightMap
    for x=-w,w+1 do
        self.heightMap[x] = {}
        for z=-h,h+1 do
            local y = self.hmg:getHeight(x, z)
            heightMap[x][z] = y
        end
    end

    local hueGreen = rgb2hsl(green)
    local hueBrown = rgb2hsl(brown)

    terrain.vertices = {n=w*h*3}

    for x=-w/2,w/2 do
        for z=-h/2,h/2 do
            local translate = vec3(s*(x-1), 0, -s*(z-1))

            local y = self.hmg:getHeight(x+0.5, z+0.5)

            local color
            if y > 0 then
                color = hsl(map(y,
                        0, self.hmg.amplitudeMax/2,
                        hueGreen, hueBrown) , 0.5, 0.5)
            else
                color = brown
            end

            if x%2 == z%2 then
                meshAddTriangle(terrain.vertices,
                    vec3(0, heightMap[x  ][z  ], 0):add(a):add(translate),
                    vec3(0, heightMap[x+1][z  ], 0):add(b):add(translate),
                    vec3(0, heightMap[x+1][z+1], 0):add(c):add(translate))
                meshSetTriangleColors(terrain.colors, color)

                meshAddTriangle(terrain.vertices,
                    vec3(0, heightMap[x  ][z  ], 0):add(a):add(translate),
                    vec3(0, heightMap[x+1][z+1], 0):add(c):add(translate),
                    vec3(0, heightMap[x  ][z+1], 0):add(d):add(translate))
                meshSetTriangleColors(terrain.colors, color)
            else
                meshAddTriangle(terrain.vertices,
                    vec3(0, heightMap[x  ][z  ], 0):add(a):add(translate),
                    vec3(0, heightMap[x+1][z  ], 0):add(b):add(translate),
                    vec3(0, heightMap[x  ][z+1], 0):add(d):add(translate))
                meshSetTriangleColors(terrain.colors, color)

                meshAddTriangle(terrain.vertices,
                    vec3(0, heightMap[x+1][z  ], 0):add(b):add(translate),
                    vec3(0, heightMap[x+1][z+1], 0):add(c):add(translate),
                    vec3(0, heightMap[x  ][z+1], 0):add(d):add(translate))
                meshSetTriangleColors(terrain.colors, color)
            end

            meshAddTriangle(sea.vertices,
                a:translate(translate),
                b:translate(translate),
                c:translate(translate))

            meshAddTriangle(sea.vertices,
                a:translate(translate),
                c:translate(translate),
                d:translate(translate))
        end
    end

    terrain.normals = Model.computeNormals(terrain.vertices)
    sea.normals = Model.computeNormals(sea.vertices)

    self.player = vec3(0, 0, 0)
end

function appMap:draw()
    background(black)

    perspective()

    currentMaterial = defaultMaterial

    MeshAxes()
    MeshAxes(lca.camera:at())

    skybox:draw()

    light(true)

    terrain:draw()

    blendMode(NORMAL)

    noLight()

    currentMaterial = Material.sea()

    sea:setColors(blue:alpha(opacity))
    sea:draw()

    self.player.x = self.player.x + 0.1 --playerX
    self.player.z = playerZ

    local s = 10
    local w = 5
    fill(blue)

    local x, y, z = xyz(self.player)
    y = self.hmg:getHeight(x, z)

    translate(s*(x-1), y, -s*(z-1))
    box(w, w, w)
end
