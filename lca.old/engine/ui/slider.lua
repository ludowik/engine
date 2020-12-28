class('Slider', Button)

function Slider:init(var, min, max, default, integer, callback)
    Button.init(self, var, callback)

    self:bind(var, default or min or 0, callback)

    self.min = min or 0
    self.max = max or 100

    self.default = default or self.min

    self.integer = integer or false
end

function Slider:computeSize()
    self.size.x, self.size.y = textSize(self:getLabel())    
    self.size.x = 200
end

function Slider:touchedMoving(touch)
    self:touchedEnded(touch)
end

function Slider:touchedEnded(touch)
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
--        Button.touched(self, touch)
    end
end
