class('Button', Label, Bind)

function Button:init(label, ...)
    Label.init(self, label)
    Bind.init(self)

    if #{...} > 0 then
        self.action = callback(...)
    end
end
