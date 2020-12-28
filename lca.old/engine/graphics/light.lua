class('Light')

function Light.setup()
    lights = Table()
    Light.reset()
end

function Light.reset()
    lights:clear()
    
    lights:add(Light.ambient())
    lights:add(Light.sun())
end

function Light:init()
    self.on = true
    
    self.position = vector()
    self.direction = vector()
    
    self.color = white

    self.ambientStrength = 0
    self.diffuseStrength = 0
    self.specularStrength = 0
    
    self.constant = 1
    self.linear = 0
    self.quadratic = 0
    
    self.innerCutOff = 0
    self.outerCutOff = 0
end

function Light:update()
    local time = system.getTicks() / 1000
    
    self.color.r = (sin( time * 2.0 ) + 1) / 2
    self.color.g = (sin( time * 0.7 ) + 1) / 2
    self.color.b = (sin( time * 1.3 ) + 1) / 2
end

function Light.ambient(ambientStrength, clr)
    local light = Light()
    light.color = clr or white
    
    light.ambientStrength = ambientStrength or 0.2
    
    return light
end
function Light.sun(diffuseStrength, specularStrength)
    local light = Light()
    light.position = vector(10^5, 10^10, 0)
    light.color = clr or white
    
    light.diffuseStrength = diffuseStrength or 0.6
    light.specularStrength = specularStrength or 0.8
    
    return light
end

function Light.point()
    local light = Light()
    light.position = vector(0, 2, 0)
    light.color = red
    
    light.diffuseStrength = 0.5
    light.specularStrength = 0.5
    
    light.constant = 0
    light.linear = 0
    light.quadratic = 0.2
    
    return light
end

function Light.spot()
    local light = Light()
    light.position = vector(0, 3, 0)
    light.direction = vector(0, -1, 0) 
    
    light.color = red
    
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
    light.position = vector.random():normalize()*3
    light.color = clr or color.random()
    light.diffuseStrength = random(0.2, 0.8)
    return light
end
