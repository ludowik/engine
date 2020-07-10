class('Button', Label, Bind)

function Button:init(label, ...)
    Label.init(self, label)
    Bind.init(self)
    
    self.action = callback(...)
end

require 'ui.iconsFont'

class('ButtonIconFont', Button)

function ButtonIconFont:init(label, action)
    Button.init(self, label, action)
end

function ButtonIconFont:draw()
    local x, y = 0, 0 -- self.position.x, self.position.y
    
    pushStyle()
    do
        noStroke()

        fill(white)

        font('foundation-icons')
        fontSize(self.width)

        textMode(CENTER)
        text(utf8.char(iconsFont[self.label]),
            x + self.size.x/2, 
            y + self.size.y/2)
    end
    popStyle()
end

class('ButtonColor', Button)

function ButtonColor:init(label, action)
    Button.init(self, label, action)
    
    self.color = label
end

function ButtonColor:computeSize()
    self.size.x, self.size.y = 32, 32
end

function ButtonColor:draw()
    stroke(white)
    fill(self.color)

    rectMode(CORNER)
    rect(0, 0, self.size.x, self.size.y)
end

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
