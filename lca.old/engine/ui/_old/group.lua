Class('UIGroup', UIScene)

UIGroup.headerColor = brown
UIGroup.backgroundColor = UIGroup.headerColor
UIGroup.fontSize = defaultFontSize
UIGroup.minSize = Size(200, 0)

function UIGroup:UIGroup(label)
    UIScene.init(self)
    
    self:setLabel(label)

    self.reduced = readLocalData('UIGroup.'..self.label..'.reduce', true)

    self:add(UIHeader(self.label):attribs{
            backgroundColor = self.backgroundColor,
            click = function (_, ...) self.click(self, ...) end,
            fontSize = self.fontSize
        })
end

function UIGroup:getLabel()
    local label = self.label
    if self.reduced then
        label = label..' ...'
    else
        label = label..' =>'
    end
    return label
end

function UIGroup:add(...)
    UIScene.add(self, ...)
    self:setBackgroundColor(red)
    return self
end

function UIGroup:action(...)
    self:add(Button(...))
    return self
end

function UIGroup:number(...)
    self:add(UIExpression(...))
    return self
end

function UIGroup:update(...)
    UIScene.update(self, ...)
    
    for i=2,#self.nodes do
        local node = self.nodes[i]
        node.visible = not self.reduced
    end
end

function UIGroup:toggleReduce(reduced)
    if reduced == nil then
        reduced = not self.reduced    
    end

    self.reduced = reduced    
    saveLocalData('UIGroup.'..self.label..'.reduce', self.reduced)
end

function UIGroup:click()
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

function UIGroup:setBackgroundColor(backgroundColor)
    for i=2,#self.nodes do
        local node = self.nodes[i]
        node.backgroundColor = backgroundColor
    end
    return self
end

function UIGroup:setFontSize(fontSize)
    for i=2,#self.nodes do
        local node = self.nodes[i]
        node.fontSize = fontSize
    end
    return self
end

Class('UIHeader', Widget)

UIHeader.headerColor = UIGroup.headerColor
UIHeader.backgroundColor = UIGroup.headerColor

function UIHeader:UIHeader(label)
    Widget.init(self, label)
end

function UIHeader:getLabel()
    return self.parent:getLabel()
end

Class('UIParams', UIGroup)

UIParams.headerColor = brown * 0.8
UIParams.backgroundColor = UIParams.headerColor

function UIParams:UIParams(...)
    self:UIGroup(...)
    self.translation = vec3()
end
