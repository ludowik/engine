class('CheckBox', Button)

function CheckBox:init(var, default, callback)
    Button.init(self, var, callback)  
    
    self:bind(var, not not default, callback)
end

function CheckBox:update(dt)
    self.bgColor = self:getValue() and green or red
end

function CheckBox:getLabel()
    return tostring(self:getValue()) or 'nil'
end

function CheckBox:touched(touch)
    self:setValue(not self:getValue())
end
