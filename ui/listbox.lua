class('ListBox', UI)

function ListBox:init(list)
    UI.init(self)
    self.list = list or {}
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
    self.needScrollBar = false

    local x, y = 0, 0 -- self.position.x, self.position.y
    y = y + self.size.y + self.dy

    for i,item in ipairs(self.list) do
        local w, h = textSize(item)
        y = y - h

        if self:contains(x, y) then
            text(item, x, y)
        else
            self.needScrollBar = true
        end
    end
end

function ListBox:touched(touch)
end

function ListBox:wheelmoved(mouse)
    local y = math.sign(mouse.deltaY) * 10

    if self.needScrollBar then
        self.dy = self.dy - y

        self.dy = max(self.dy, 0)
        self.dy = min(self.dy, self.hTot - self.size.y)
    end
end
