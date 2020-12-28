App('Firework')

function Firework:init()
    Application.init(self)

    self.particles = Table()

    gravity = vector(0, -1)

    local force = vec3.random()
    force = force - force / 2
end

function Firework:draw()
    background(51)

    stroke(white)
    fill(white)

    strokeWidth(5)

    if random(10) < 1 then
        local particle = ParticleFirework(vector(random(WIDTH), 0), true)
        particle:applyForce(vector(0, 200))

        self.particles:add(particle)
    end

    self.particles:update(DeltaTime)
    self.particles:draw()
end

ParticleFirework = class('ParticleFirework')

function ParticleFirework:init(position, typ)
    self.position = position

    self.acc = vector()
    self.vel = vector()

    self.typ = typ
end

function ParticleFirework:applyForce(f)
    self.acc = self.acc + f
end

function ParticleFirework:update(dt)
    self:applyForce(gravity)

    self.vel = self.vel + self.acc * dt
    self.position = self.position + self.vel

    self.acc = vector()

    if self.typ == true and self.vel.y < 0 then
        self.typ = false
        for i=1,10 do
            local particle = ParticleFirework(self.position, false)
            local force = vec3.random(200)
            force = force - force / 2

            particle:applyForce(force)

            app.particles:add(particle)
        end
    end
end

function ParticleFirework:draw()
    point(self.position.x, self.position.y)
end
