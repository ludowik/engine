require 'engine'

class 'Star' : extends(GameObject)

function Star:init()
    self.position = vec2()

    self.r = random.random(5)

    local angle = random.random(math.tau)
    self.velocity = vec2(
        math.cos(angle),
        math.sin(angle)):mul(random.random(40, 50))

    self.position:add(self.velocity:clone():normalize(random.random(MAX_DISTANCE)))
end

function Star:setup()
    self.position:set(0, 0)
end

function Star:update(dt)
    self.position:add(self.velocity, dt)
    if self.position:len() >= MAX_DISTANCE then
        self:setup()
    end
end

function Star:draw()
    strokeWidth(math.floor(self.r * self.position:len() / MAX_DISTANCE))
    point(self.position.x, self.position.y)
end

function Application:setup()
    MAX_STARS = 10000
    MAX_DISTANCE = vec2(W, H):len()

    self.scene.translate = vec2(W/2, H/2)
    self.stars = Node()
    self.scene:add(self.stars)

    self:addStars()
end

function Application:addStars(n)
    n = n or (MAX_STARS - self.stars:len())
    for i in range(n) do
        self.stars:add(Star())
    end
end

function Application:update(dt)
    self:addStars()
end

function Application:draw()
    background(black)

    stroke(white)

    self.points = self.points or {}
    for i,v in self.stars.nodes:items() do
        self.points[(i-1)*3 + 1] = v.position.x
        self.points[(i-1)*3 + 2] = v.position.y
        self.points[(i-1)*3 + 3] = 0
    end
    points(self.points)

    text(self.stars:len(), 0, 200)

    self:addStars()
end
