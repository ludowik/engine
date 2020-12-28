App('SolarSystem')

function SolarSystem:init()
    Application.init(self)
    p = Planet(0, 0, 10)
end

function SolarSystem:draw()
    background(51)

    perspective()
    camera(0, 0, 100)

    p:update()
    p:draw()
end

class('Planet')

function Planet.setup()
    Planet.model = Model.sphere(1)
end

function Planet:init(x, y, r, level)
    level = (level or 0) + 1

    self.x = x
    self.y = y

    self.r = r

    if level > 1 then
        self.angle = random(0, 360)
        self.angularVelocity = random(-2, 2)
    else
        self.angle = 0
        self.angularVelocity = 0
    end

    self.planets = Table()
    if level < 3 then
        for i=1,random(2,5) do
            self.planets:add(Planet(random(2*r+r/3, 2*r+r/2), 0, r*0.63, level))
        end
    end
end

function Planet:update(dt)
    self.angle = self.angle + self.angularVelocity
    self.planets:update()
end

function Planet:sphere(r)
    pushMatrix()
    do
        scale(r)

        Planet.model:setColors(red)
        Planet.model:draw()
    end
    popMatrix()
end

function Planet:draw()
    light(true)

    pushMatrix()
    do
        stroke(white)
        fill(white)

        rotate(self.angle)
        translate(self.x, self.y)

        self:sphere(self.r)

        self.planets:draw()
    end
    popMatrix()
end
