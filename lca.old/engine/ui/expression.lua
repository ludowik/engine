class('Expression', Label)

function Expression:init(label, expression)
    Label.init(self, label)
    self.expression = expression or label

    if label and expression then
        self.withLabel = true
    else
        self.withLabel = false
    end
end

function Expression:getLabel()
    local value = tostring(evalExpression(self.expression) or self.expression or 'nil')
    if self.withLabel then
        return self.label..' = '..value
    else
        return value
    end
end
