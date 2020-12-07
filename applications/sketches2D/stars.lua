class 'Star' : extends(Object)

Star.batchRendering = true

function Star:init()
    Object.init(self)

    if Star.batchRendering then
        getmetatable(self).draw = nil
    end

    self.position = vec3()

    self.r = random(5)

    local angle = random(math.tau)
    self.velocity = vec3(
        math.cos(angle),
        math.sin(angle)):mul(random(40, 50))

    self.position:add(self.velocity:clone():normalize(random(MAX_DISTANCE)))
end

function Star:reset()
    self.position:set(0, 0)
end

function Star:update(dt)
    self.position:add(self.velocity, dt)
    if self.position:len() >= MAX_DISTANCE then
        self:reset()
    end
end

function Star:draw()
    stroke(white)
    strokeWidth(math.floor(self.r * self.position:len() / MAX_DISTANCE))
    point(self.position)
end

application 'Stars'

function Stars:init()
    Application.init(self)

    MAX_STARS = 10000
    MAX_DISTANCE = W / 2 -- vec2(W/2, H/2):len()

    self.scene.translate = vec2(W/2, H/2)

    self.stars = Node()
    self.scene:add(self.stars)

    self.points = Buffer('vec3')

    self:addStars()
end

function Stars:update(dt)
    local distance = engine.frameTime.fps - 60
    if distance ~= 60 then
        MAX_STARS = MAX_STARS + distance -- * 10n
    end

    self:addStars()
end

function Stars:addStars(n)
    n = n or (MAX_STARS - self.stars:len())
    if n > 0 then
        for i in range(n) do
            self.stars:add(Star())
        end
    else
        for i in range(-n) do
            self.stars:remove(self.stars:len())
        end
    end
end

function Stars:draw()
    background(black)

    blendMode(NORMAL)

    translate(W/2, H/2)

    stroke(white)
    strokeWidth(5)

    if Star.batchRendering then
        self.points:reset()

        local ref = 1
        for i,v in self.stars.nodes:items() do
            self.points[ref] = v.position
            ref = ref + 1
        end

        points(self.points)
    end

    text(self.stars:len(), 0, 200)
end
