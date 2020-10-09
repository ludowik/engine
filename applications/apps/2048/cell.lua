class('Cell2048')

function Cell2048:init(value)
    self.value = value

    self.scaling = 1
    self.angle = 0
end

function Cell2048:draw()
    if self.value then
        fill(black)
        text(self.value, 0, 0)
    end
end
