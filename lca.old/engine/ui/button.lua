class('Button', Label)

local defaultWidth  = 22
local defaultHeight = 44

function Button:init(label, ...)
    Label.init(self, label)
    self.callback = callback(...)
    self.bgColor = blue
    self.drawMode = CENTER
end

function Button:touched(touch)
    self.callback:call(self)
end

class('ButtonColor', Button)

function ButtonColor:init(color, ...)
    Button.init(self, 'color', ...)
    self.color = color
    self.fixedSize = vec2(defaultWidth, defaultHeight)
end


function ButtonColor:draw()
    local x, y = 0, 0 -- self.position.x, self.position.y

    stroke(white)
    
    fill(self.color)

    rectMode(CORNER)
    rect(x, y, self.size.x, self.size.y)
end

class('ButtonImage', Button)

function ButtonImage:init(label, ...)
    Button.init(self, label, ...)
    self.image = image(label)
    self.width = defaultHeight 
end

function ButtonImage:computeSize()
    self.size.x, self.size.y = self.width, self.width
end

function ButtonImage:draw()
    local x, y = 0, 0 -- self.position.x, self.position.y
    
    stroke(white)

    noFill()

    rectMode(CORNER)
    rect(x, y, self.size.x, self.size.y)

    spriteMode(CORNER)
    sprite(self.image,
        x, y,
        self.size.x, self.size.y)
end

require 'engine/ui/iconsFont'

class('ButtonIconFont', Button)

function ButtonIconFont:init(label, ...)
    Button.init(self, label, ...)
    self.width = defaultHeight 
end

function ButtonIconFont:computeSize()
    self.size.x, self.size.y = self.width, self.width
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
