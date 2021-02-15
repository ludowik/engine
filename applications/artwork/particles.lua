function setup()
    particles = Array()

    for i=1,100 do
        particles:add(Particle(vec3.random(W, H, 0)))
    end
end

function update(dt)
    particles:update(dt)
end

function draw()
    background()
    particles:draw()
end

class 'Particle'

function Particle:init(x, y, z)
    self.body = fizix:body(CIRCLE, 5)
    self.body.type = DYNAMIC
    self.body.mask = {}
    self.body.mass = 0.1
    self.body.position = vec3(x, y, z)
end

function Particle:draw()
    stroke(blue)
    strokeWidth(5)

    point(self.body.position)
end
