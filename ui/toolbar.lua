class('ToolBar', UIScene)

function ToolBar:init(x, y)
    UIScene.init(self, Layout.row)
    self.position:set(x, y)
end

class('MenuBar', UIScene)

function MenuBar:init()
    UIScene.init(self, Layout.column)
end

function MenuBar:boolean(var, default, callback)
    self:add(CheckBox(var, default, callback))
    return self
end

function MenuBar:number(var, min, max, default, callback)
    self:add(Slider(var, min, max, default, false, callback))
    return self
end

function MenuBar:action(label, callback)
    self:add(Button(label, callback))
    return self
end
