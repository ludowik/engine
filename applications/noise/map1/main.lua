App('appMap')

function appMap:init()
    Application.init(self)

    supportedOrientations(LANDSCAPE_ANY)

    parameter.number('opacity', 0, 255, 100)

    parameter.number('playerX', -200, 200, 0)
    parameter.number('playerZ', -200, 200, 0)

    self.hmg = HeightsMapGenerator()

    camera(500, 100, 500, -100, 0, -500)

    skybox = Model.skybox(100000)
    skybox.shader = Shader('default')
    skybox.texture = image('documents:skybox')

    self.s = 10
    local s = self.s

    terrain = Mesh()
    terrain.shader = Shader('default')

    sea = Mesh()
    sea.shader = Shader('default')

    local a = vec3(0, 0, 0)
    local b = vec3(s, 0, 0)
    local c = vec3(s, 0, -s)
    local d = vec3(0, 0, -s)

    local w = (debugging() and 32) or 256
    local h = (debugging() and 32) or 256

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

    terrain.vertices = Buffer('vec3')
    terrain.vertices:resize(w*h*3)

    local translate = vec3()

    for x=-w/2,w/2 do
        for z=-h/2,h/2 do
            translate:set(s*(x-1), 0, -s*(z-1))

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
                a + translate,
                b + translate,
                c + translate)

            meshAddTriangle(sea.vertices,
                a + translate,
                c + translate,
                d + translate)
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
    MeshAxes(self.scene.camera:at())

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
