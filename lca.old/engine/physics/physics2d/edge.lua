class('Edge')

function Edge:init(name)
    self.position = vector()
    self.size = vector()
    
    self.name = name
    
    self.restitution = 0.0
    self.friction = 1
end