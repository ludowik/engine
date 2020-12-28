class('LayoutBar', UIScene)

function LayoutBar:init(layout, x, y, verticalDirection)
    UIScene.init(self)

    self.layoutProc = layout
    self.layoutPosition = vector(x or 0, y or 0)

    self.verticalDirection = verticalDirection or 'up'
end
