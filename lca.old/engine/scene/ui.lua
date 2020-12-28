class('UI', Rect, Attribs)

function UI:init(x, y, w, h)
    Rect.init(self, x, y, w, h)
    Attribs.init(self)

    self.verticalDirection = 'up'
    self.alignment = 'none'
    self.fixedSize = nil
    
    self.drawMode = CORNER
    self.textColor = white
    self.textSize = ls(0.3)

    self.angle = 0
    
    self.visible = true
end

function UI:update(dt)
end

function UI:computeSize()
    self.size.x, self.size.y = 44, 44
end

function UI:getFocus()
    return self.focus and self or nil
end
