class('UI', Object)

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

function UI:contains(v)
    local x = v.x - self.absolutePosition.x
    local y = v.y - self.absolutePosition.y

    if (x >= 0 and x <= self.size.x and 
        y >= 0 and y <= self.size.y) then
        return true
    end
end

function UI:computeSize()
    font(UI.fontName)
    fontSize(UI.fontSize)

    self.size.x, self.size.y = textSize(self:getLabel())
    
    self.size.x = self.size.x + UI.marge * 2
end

function UI:draw()
    noStroke()
    
    fill(self:getBgColor())

    rectMode(CORNER)
    rect(0, 0, self.size.x, self.size.y)
    
    self:drawLabel()
end

function UI:drawLabel()
    if self.hasFocus then
        fill(red)
    else
        fill(self:getTextColor())
    end

    font(UI.fontName)
    fontSize(UI.fontSize)

    textMode(CENTER)
    text(self:getLabel(), self.size.x / 2, self.size.y / 2)
end

function UI:touched(touch)
    if touch.state == BEGAN then
        if self.action then
            self.action(self)
        end
    end
    return true
end

function UI:mouseWheel(touch)
end
