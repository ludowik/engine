Class('UILine', 'Widget')

function UILine:UILine()
    self:Widget('line')
end

function UILine:computeSize()
    Widget.computeSize(self)
    self.size.y = 3
end

function UILine:draw()
    strokeWidth(1)
    stroke(white)

    line(0, 1, self.size.x, 1)
end
