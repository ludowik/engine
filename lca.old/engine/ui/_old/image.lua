Class('UIImage', Widget)

function UIImage:UIImage(label, img)
    self:Widget(label)
    
    self.image = img or image(20, 20)
end

function UIImage:computeSize()
    self.size.x = self.image.width
    self.size.y = self.image.height
end

function UIImage:draw()
    spriteMode(CORNER)
    sprite(self.image, 0, 0)
end
