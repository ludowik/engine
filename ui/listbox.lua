local __sign = math.sign

class('ListBox', UI)

function ListBox:init(list, ...)
    UI.init(self)

    self.list = list or Array()
    self.areas = Array()
    
    self.action = callback(...)

    self.dy = 0
end

function ListBox:computeSize()
    local wMax, hTot = 0, 0
    for i,item in ipairs(self.list) do
        local w, h = textSize(item)
        wMax = max(wMax, w)
        hTot = hTot + h
    end
    self.size.x, self.size.y = wMax, 200
    self.hTot = hTot
end

function ListBox:draw()
    clip(self.absolutePosition.x, self.absolutePosition.y, self.size.x, self.size.y)

    self.needScrollBar = false

    self.areas = Array()

    local x, y = 0, 0
    y = y + self.size.y + self.dy

    textMode(CORNER)
    for i,item in ipairs(self.list) do
        local w, h = textSize(item)
        y = y - h

        local position = vec2(self.absolutePosition.x+x, self.absolutePosition.y+y)
        if self:contains(position) then
            text(item, x, y)
            self.areas:add({item=item, rect=Rect(position.x, position.y, w, h)})
        else
            self.needScrollBar = true
        end
    end

    noClip()
end

function ListBox:touched(touch)
    if touch.state == ENDED then
        if self:contains(touch) then
            for i,item in ipairs(self.areas) do
                if item.rect:contains(touch) then
                    self.action(item.item)
                end
            end
        end
    end
end

function ListBox:wheelmoved(mouse)
    local y = __sign(mouse.deltaY) * 10

    if self.needScrollBar then
        self.dy = self.dy - y

        self.dy = max(self.dy, 0)
        self.dy = min(self.dy, self.hTot - self.size.y)
    end
end
