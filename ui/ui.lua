class 'UI' : extends(Object, Bind)

function UI.setup()    
    UI.bgColor = blue
    UI.textColor = white

    UI.fontName = DEFAULT_FONT_NAME
    UI.fontSize = DEFAULT_FONT_SIZE

    UI.marge = 5
end

function UI:init(label)
    Object.init(self, label)
end

function UI:getLabel()
    return tostring(self.label)
end

function UI:getBgColor()
    return self.bgColor or UI.bgColor
end

function UI:getTextColor()
    return self.textColor or UI.textColor
end

function UI:getFontName()
    return self.fontName or UI.fontName
end

function UI:getFontSize()
    return self.fontSize or UI.fontSize
end

function UI:contains(x, y)
    if y == nil then
        x, y = x.x, x.y
    end

    x = x - self.absolutePosition.x
    y = y - self.absolutePosition.y

    if (x >= 0 and x <= self.size.x and
        y >= 0 and y <= self.size.y) then
        return true
    end
end

function UI:computeSize()
    font(self:getFontName())
    fontSize(self:getFontSize())

    self.size.x, self.size.y = textSize(self:getLabel())

    self.size.x = self.size.x + UI.marge * 2
end

function UI:draw()
    self:drawBackground()
    self:drawLabel()
end

function UI:drawBackground()
    noStroke()

    fill(self:getBgColor())

    rectMode(CORNER)
    rect(0, 0, self.size.x, self.size.y)
end

function UI:drawLabel()
    if self.hasFocus then
        fill(red)
    else
        fill(self:getTextColor())
    end

    font(self:getFontName())
    fontSize(self:getFontSize())

    textMode(CENTER)
    text(self:getLabel(), self.size.x / 2, self.size.y / 2)
end

function UI:touched(touch)
    if touch.state == BEGAN then
        self.bgColor = red

    elseif touch.state == ENDED then
        self.bgColor = nil
        if self.action then
            self.action(self)
        end
    end
    return true
end

function UI:mouseWheel(touch)
end
