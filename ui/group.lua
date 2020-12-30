class('Group', UI)

function Group.setup()
    Group.headerColor = brown
    Group.backgroundColor = Group.headerColor
    Group.fontSize = defaultFontSize
    Group.minSize = size(2, 0)
end

function Group:init(label)
    UI.init(self, label)

    self.reduced = readLocalData('Group.'..self.label..'.reduce', true)

    self:add(Header(self.label):attribs{
            backgroundColor = self.backgroundColor,
            click = function (_, ...) self.click(self, ...) end,
            fontSize = self.fontSize
        })
end

function Group:getLabel()
    local label = self.label
    if self.reduced then
        label = label..' ...'
    else
        label = label..' =>'
    end
    return label
end

function Group:add(...)
    UI.add(self, ...)
    self:setBackgroundColor(red)
    return self
end

function Group:action(...)
    self:add(Button(...))
    return self
end

function Group:number(...)
    self:add(UIExpression(...))
    return self
end

function Group:update(...)
    UI.update(self, ...)

    for i=2,#self.nodes do
        local node = self.nodes[i]
        node.visible = not self.reduced
    end
end

function Group:toggleReduce(reduced)
    if reduced == nil then
        reduced = not self.reduced
    end

    self.reduced = reduced
    saveLocalData('Group.'..self.label..'.reduce', self.reduced)
end

function Group:click()
    self:toggleReduce()

    if self.reduced == false then
        local root = self:root()
        if root ~= self then
            root:scan(function (ui, i, t)
                    if ui ~= self and ui.reduced == false then
                        ui:toggleReduce(true)
                    end
                end)
        end
    end
end

function Group:setBackgroundColor(backgroundColor)
    for i=2,#self.nodes do
        local node = self.nodes[i]
        node.backgroundColor = backgroundColor
    end
    return self
end

function Group:setFontSize(fontSize)
    for i=2,#self.nodes do
        local node = self.nodes[i]
        node.fontSize = fontSize
    end
    return self
end

class('Header', UI)

Header.headerColor = Group.headerColor
Header.backgroundColor = Group.headerColor

function Header:UIHeader(label)
    Widget.init(self, label)
end

function Header:getLabel()
    return self.parent:getLabel()
end

class('Params', Group)

Params.headerColor = brown * 0.8
Params.backgroundColor = Params.headerColor

function Params:UIParams(...)
    self:UIGroup(...)
    self.translation = vec3()
end
