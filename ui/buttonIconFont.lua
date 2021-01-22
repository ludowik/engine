class('ButtonIconFont', Button)

function ButtonIconFont:init(label, action)
    Button.init(self, label, action)
end

function ButtonIconFont:computeSize()
    self.size.x, self.size.y = 32, 32
end

function ButtonIconFont:draw()
    local x, y = 0, 0 -- self.position.x, self.position.y

    pushStyle()
    do
        noStroke()

        fill(white)

        font('Foundation-Icons')
        fontSize(self.size.x)

        textMode(CENTER)
        text(utf8.char(iconsFont[self.label]),
            x + self.size.x/2,
            y + self.size.y/2)
    end
    popStyle()
end
