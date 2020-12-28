App('appCubeWave')

function appCubeWave:init()
    Application.init(self)
    self.angle = 0

    parameter.integer('app.n', 1, 20, 5)
    parameter.integer('app.size', 1, 20, 4)
    parameter.integer('app.zoom', 1, 20, 8)
    parameter.integer('app.speed', 1, 10, 2)
end

function appCubeWave:update(dt)
    self.angle = self.angle + dt * app.speed
end

function appCubeWave:draw()
    background(51)

    line(WIDTH/2, 0, WIDTH/2, HEIGHT)

    light(true)

    isometric(app.zoom)

    local n = app.n * 2 + 1

    local w = app.size

    local mind = 0
    local maxd = dist(1, 1, n/2, n/2)

    translate(-(n+1)/2*w, 0, -(n+1)/2*w)

    for x=1,n do
        translate(w, 0, 0)

        pushMatrix()
        for z=1,n do
            local d = dist(x, z, (n+1)/2, (n+1)/2)
            local offset = map(d, mind, maxd, -pi, pi)
            local s = sin(self.angle + offset)

            local h = map(s, -1, 1, w*2, w*8)
            local r = map(s, -1, 1, 0, 1)

            translate(0, 0, w)

            fill(color(r))

            box(w, h, w)
        end
        popMatrix()
    end    
end
