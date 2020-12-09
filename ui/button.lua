class('Button', Label)

function Button:init(label, ...)
    Label.init(self, label)

    if #{...} > 0 then
        self.action = callback(...)
    end
end
