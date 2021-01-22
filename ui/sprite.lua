class('Sprite', UI)

function Sprite:init(label, img)
    UI.init(self, label)
    
    self.image = image(img or label)
end

function Sprite:computeSize()
    self.size.x = self.image.width
    self.size.y = self.image.height
end

function Sprite:draw()
    spriteMode(CORNER)
    sprite(self.image, 0, 0)
end
