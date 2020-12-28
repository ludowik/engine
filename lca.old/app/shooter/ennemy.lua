class('Ennemy', RectObject)

function Ennemy:init()
    RectObject.init(self, random(WIDTH), HEIGHT, 25, 25)
    self:addToPhysics()
    
    self.body.linearVelocity = vector(0, -100)
end

