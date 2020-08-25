class('Button', Label, Bind)

function Button:init(label, ...)
    Label.init(self, label)
    Bind.init(self)
    
    self.action = callback(...)
end
