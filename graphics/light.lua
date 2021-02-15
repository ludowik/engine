class('Light')

function Light.setup()
    lights = Table()
    Light.reset()
    
    LIGHT_AMBIENT = 0
    LIGHT_DIRECTIONNAL = 1
end

function Light.reset()
    lights:clear()

    lights:add(Light.ambient(0.5, red))
    lights:add(Light.sun())

--    lights:add(Light.random())
--    lights:add(Light.random())

--    lights:add(Light.spot())
end

function Light:init()
    self.type = 0
    
    self.state = 1

    self.position = vec3()
    self.direction = vec3()

    self.color = color(white)

    self.ambientStrength = 0
    self.diffuseStrength = 0
    self.specularStrength = 0

    self.constant = 1
    self.linear = 0
    self.quadratic = 0

    self.innerCutOff = 0
    self.outerCutOff = 0
end

function Light:update(dt)
    local time = ElapsedTime

    self.color.r = (sin( time * 2.0 ) + 1) / 2
    self.color.g = (sin( time * 0.7 ) + 1) / 2
    self.color.b = (sin( time * 1.3 ) + 1) / 2
end

function Light:draw()
    pushMatrix()
    translate(self.position.x, self.position.y, self.position.z)
--    sphere(1)
    popMatrix()
end

function Light.ambient(ambientStrength, clr)
    local light = Light()
    light.type = 0
    
    light.color = color(clr or white)

    light.ambientStrength = ambientStrength or 0.3

    return light
end

function Light.sun(diffuseStrength, specularStrength)
    local light = Light()
    light.type = 1

    light.position = vec3(500000., 1000000., 1000.)
    light.color = color(clr or yellow)

    light.ambientStrength = ambientStrength or 0.4
    light.diffuseStrength = diffuseStrength or 0.8
    light.specularStrength = specularStrength or 0.8
    
    light.constant = 0
    light.linear = 0
    light.quadratic = 0

    return light
end

function Light.point()
    local light = Light()
    light.position = vec3(0, 2, 0)
    light.color = color(red)

    light.diffuseStrength = 0.5
    light.specularStrength = 0.5

    light.constant = 0
    light.linear = 0
    light.quadratic = 0.2

    return light
end

function Light.spot()
    local light = Light()
    light.position = vec3(0, 10, 0)
    light.direction = vec3(0, 1, 0)

    light.color = color(red)

    light.diffuseStrength = 0.5
    light.specularStrength = 0.5

    light.innerCutOff = rad(10)
    light.outerCutOff = rad(12)

    light.constant = 0
    light.linear = 0
    light.quadratic = 0.5

    return light
end

function Light.random(clr)
    local light = Light()
    light.position = vec3.random():normalizeInPlace(10)
    light.color = color(clr or color.random())
    light.diffuseStrength = random(0.2, 0.8)
    return light
end
