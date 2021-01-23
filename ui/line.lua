class('UILine', UI)

function UILine:init()
    UI.init(self)
end

function UILine:computeSize()
    UI.computeSize(self)
    
    self.size.x = self.parent.size.x - self.size.x
    self.size.y = 3
end

function UILine:draw()
    strokeWidth(1)
    stroke(white)

    line(0, 1, self.size.x, 1)
end
