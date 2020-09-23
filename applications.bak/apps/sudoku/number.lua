class('Number', Button)

function Number:init(label, f)
    Button.init(self, label, f)
end

function Number:draw()
    Button.draw(self)

    local ref = tonumber(self.title) or 0

    if self.grid.numbersCount and ref > 0 then
        text(self.grid.numbersCount[ref], self.size.y / 2 , s8, s12, yellow, CENTER)
    end
end
