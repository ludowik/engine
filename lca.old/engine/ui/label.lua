class('Label', UI, Bind)

function Label:init(label)
    Bind.init(self)
    UI.init(self)

    self.label = label
    self.id = label
end

function Label:getLabel()
    local label = tostring(self.label or '???')
    local value = self:getValue()
    if value == nil then
        return label
    end

    return label..' : '..tostring(value)
end

function Label:computeSize()
    font('Arial')
    fontSize(self.textSize)

    self.size.x, self.size.y = textSize(self:getLabel())    
end

function Label:draw()
    local x, y = 0, 0 -- self.position.x, self.position.y
    local w, h = self.size.x, self.size.y

    noStroke()

    if self.bgColor then
        fill(self.bgColor)

        rectMode(CORNER)
        rect(x, y, self.size.x, self.size.y)
    end

    fill(white)

    font('Arial')
    fontSize(self.textSize)

    fill(self.textColor)

    textMode(self.drawMode)
    if self.drawMode == CORNER then
        text(self:getLabel(), x, y)
    else
        text(self:getLabel(), x+w/2, y+h/2)
    end
end
