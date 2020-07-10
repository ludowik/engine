class 'Bar' : extends(UI)

function Bar:init(...)
    UI.init(self, ...)
end

function Bar:action()
    return self
end

function Bar:number()
    return self
end

class 'ToolBar' : extends(Bar)

function ToolBar:init(...)
    Bar.init(self, ...)
end

class 'MenuBar' : extends(Bar)

function MenuBar:init(...)
    Bar.init(self, ...)
end
