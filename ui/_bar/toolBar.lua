class('ToolBar', LayoutBar)

function ToolBar:init(x, y, verticalDirection)
    LayoutBar.init(self, Layout.column, x, y, verticalDirection or 'up')

    self.toggleButton = ButtonColor(blue, function ()
            self:toggle()
        end)
    self:add(self.toggleButton)

    self.toggleButton.fixedSize = vec2(22, 22)

    self.borderWidth = 0
end

function ToolBar:toggle()
    if #self.nodes <= 1 then return end

    local visible = self.nodes[2].visible

    local delay = 0.3

    if config.orientation == 'portrait' then
        scaling = vec2(0, 1)
    else
        scaling = vec2(1, 0)
    end

    for i=2,#self.nodes do
        local node = self.nodes[i]
        if visible then
            node.scaling = vec2(1, 1)
            tween(delay, node.scaling, scaling, tween.easing.linear,
                function ()
                    node.visible = not visible
                end)
        else
            node.visible = not visible
            node.scaling = scaling
            tween(delay, node.scaling, vec2(1, 1), tween.easing.linear)
        end
    end
end
