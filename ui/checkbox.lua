class('CheckBox', Label)

function CheckBox:init(var, default, notify)
    Label.init(self, var)
    self:bind(var, value(default, false), notify)
end

function CheckBox:update(dt)
    self.bgColor = self:getValue() and green or red
end

function CheckBox:getLabel()
    return tostring(self:getValue()) or 'nil'
end

function CheckBox:touched(touch)
    if touch.state == BEGAN then
        self:setValue(not self:getValue())
    end
    return true
end
