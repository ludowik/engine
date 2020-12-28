class('Material')

function Material:init()
    self.ambientStrength = 2.5
    self.diffuseStrength = 2
    self.specularStrength = 0.2
    
    self.shininess = 32
    
    self.alpha = 1
end

function Material.sea()
    local sea = Material()
    sea.alpha = 0.5
    return sea
end

defaultMaterial = Material()

currentMaterial = defaultMaterial
