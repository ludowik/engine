class('MenuBar', LayoutBar)

function MenuBar:init(x, y, verticalDirection)
    LayoutBar.init(self, Layout.column, x, y, verticalDirection or 'down')
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
