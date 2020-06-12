class 'Star' : extends(GameObject)

Star.batchRendering = true

function Star:init()
    if Star.batchRendering then
        getmetatable(self).draw = nil
    end

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
    points(self.position)
end

function application(name)
    local k = class(name)
    k:extends(Application)
    
    _G.env.appClass = k
end

application 'Stars'

function Stars:init()
    Application.init(self)
    
    MAX_STARS = 10000
    MAX_DISTANCE = W / 2 -- vec2(W/2, H/2):len()

    self.scene.translate = vec2(W/2, H/2)

    self.stars = Node()
    self.scene:add(self.stars)

    self.points = Buffer('float')

    self:addStars()
end

function Stars:update(dt)
    local distance = engine.frame_time.fps - 60
    if distance ~= 60 then
        MAX_STARS = MAX_STARS + distance -- * 10
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

    if Star.batchRendering then
        self.points:reset()
        
        local ref = 1
        for i,v in self.stars.nodes:items() do
            self.points[ref  ] = v.position.x
            self.points[ref+1] = v.position.y
            ref = ref + 2
        end
        points(self.points)
    end

    text(self.stars:len(), 0, 200)
end
