class('Label', UI, Bind)

function Label:init(label)
    UI.init(self, label)
end

function Label:getLabel()
    local label = tostring(self.label)
    if self:getValue() ~= nil then
        label = label..' : '..tostring(self:getValue())
    end
    return label
end
