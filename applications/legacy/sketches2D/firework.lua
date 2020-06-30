App('Firework')

function Firework:init()
    Application.init(self)

    self.particles = Table()
    parameter.watch('#app.particles')

    gravity = vec2(0, -1)
end

function Firework:update(dt)
    if random(10) < 1 then
        local particle = ParticleFirework(vec2(random(WIDTH), 0), 'parent')
        particle:applyForce(vec2(0, 200))

        self.particles:add(particle)
    end

    self.particles:update(dt)
    
    for i=#self.particles,1,-1 do
       local particle = self.particles[i]
       if particle.state == 'dead' then
           self.particles:remove(i)
        end
    end
end

function Firework:draw()
    background(51)

    stroke(white)
    fill(white)

    strokeWidth(5)

    self.particles:draw()
end

ParticleFirework = class('ParticleFirework')

function ParticleFirework:init(position, state, clr)
    self.position = position

    self.acc = vec2()
    self.vel = vec2()

    self.state = state
    
    self.life = 2
    
    self.clr = clr or Color.random()
end

function ParticleFirework:applyForce(f)
    self.acc:add(f)
end

function ParticleFirework:update(dt)
    self:applyForce(gravity)

    self.vel:add(self.acc, dt)
    
    self.position:add(self.vel)

    self.acc:set(0, 0)
    
    if self.state == 'parent' and self.vel.y < 0 then
        self.state = 'dead'
        for i=1,10 do
            local particle = ParticleFirework(self.position, 'child', self.clr)
            
            local force = vec2.random(-100, 100)
            particle:applyForce(force)

            app.particles:add(particle)
        end
        
    elseif self.state == 'child' then
        self.life = self.life - dt
        if self.life < 0 then
            self.state = 'dead'
        end
    end
end

function ParticleFirework:draw()
    fill(self.clr)
    noStroke()
    circle(self.position.x, self.position.y, self.life*3)
end
