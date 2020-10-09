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
