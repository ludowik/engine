class('Separator', UI)

function Separator:init()
    UI.init(self, 'line')
end

function Separator:computeSize()
    UI.computeSize(self)
    self.size.y = 3
end

function Separator:draw()
    strokeWidth(1)
    stroke(white)
    
    line(0, 1, self.size.x, 1)
end
