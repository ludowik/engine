App('appCubeWave')

function appCubeWave:init()
    Application.init(self)
    self.angle = 0

    parameter.integer('app.n', 1, 20, 5)
    parameter.integer('app.size', 1, 20, 4)

    parameter.number('app.zoom', 1, 20, 8)
    parameter.number('app.speed', 1, 10, 2)
end

function appCubeWave:update(dt)
    self.angle = self.angle + dt * self.speed
end

function appCubeWave:draw()
    background(51)

    line(WIDTH/2, 0, WIDTH/2, HEIGHT)

    light(true)

    isometric(self.zoom)

    depthMode(true)
    cullingMode(true)

    local n = self.n * 2 + 1

    local w = self.size

    local mind = 0
    local maxd = vec2(1, 1):dist(vec2(n/2, n/2))

    translate(-(n+1)/2*w, 0, -(n+1)/2*w)

    for x=1,n do
        translate(w, 0, 0)

        pushMatrix()
        for z=1,n do
            local d = vec2(x, z):dist(vec2((n+1)/2, (n+1)/2))
            local offset = map(d, mind, maxd, -PI, PI)
            local s = sin(self.angle + offset)

            local h = map(s, -1, 1, w*2, w*8)
            local r = map(s, -1, 1, 0, 1)

            translate(0, 0, w)

            strokeWidth(2)
            stroke(gray)

            fill(color(r))

            box(w, h, w)
        end
        popMatrix()
    end
end
