class('TitleBar', LayoutBar)

function TitleBar:init(x, y, verticalDirection)
    LayoutBar.init(self, Layout.row, x, y, verticalDirection or 'down')

    self.alignment = 'right'
    self.borderWidth = 0
end

function TitleBar:touchedBegan(touch)
end
