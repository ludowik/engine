class('ButtonImage', Button)

function ButtonImage:init(label, action)
    Button.init(self, label, action)

    self.image = image(label)
end

function ButtonImage:computeSize()
    self.size.x, self.size.y = 48, 32
end

function ButtonImage:draw()
    stroke(white)

    noFill()

    rectMode(CORNER)
    rect(x, y, self.size.x, self.size.y)

    spriteMode(CORNER)
    sprite(self.image,
        0, 0,
        self.size.x, self.size.y)
end
