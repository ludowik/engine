class('Slider', Button, Bind)

function Slider:init(var, min, max, default, integer, callback)
    Button.init(self, var, callback)

    self:bind(var, default or min or 0, callback)

    self.min = min or 0
    self.max = max or 100

    self.default = default or self.min

    self.integer = integer or false
end

function Slider:computeSize()
    font(self:getFontName())
    fontSize(self:getFontSize())

    self.size.x, self.size.y = textSize(self:getLabel())
    self.size.x = 200
end

function Slider:update(dt)
    if self.value and self.value ~= self:getValue() then
        if self.integer then
            self:setValue(floor(self.value))
        else
            self:setValue(self.value)
        end
    end
end

function Slider:draw()
    local ratio = (self:getValue() - self.min) / (self.max - self.min)
    local x = self.size.x * ratio

    fill(brown)
    noStroke()
    rectMode(CORNER)
    rect(0, 0, self.size.x, self.size.y)

    stroke(red)
    strokeWidth(3)
    line(x, 0, x, self.size.y)

    font(self:getFontName())
    fontSize(self:getFontSize())

    fill(white)

    textMode(CORNER)
    text(self:getLabel(), 0, 0)
end

function Slider:mouseButtonRight()
    self:setValue(self.min)
    tween(5, self, {value = self.max})
end

function Slider:touched(touch)
    if touch.tapCount > 1 then
        self:mouseButtonRight()
    else
        local dx = touch.x - self.position.x
        local ratio = dx / self.size.x

        local newValue
        if self.integer then
            newValue = self.min + round((self.max - self.min) * ratio)
        else
            newValue = self.min + (self.max - self.min) * ratio
        end

        if newValue ~= self:getValue() then
            self:setValue(newValue)
        end
    end
end
