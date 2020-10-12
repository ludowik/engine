class('ButtonIconFont', Button)

function ButtonIconFont:init(label, action)
    Button.init(self, label, action)
end

function ButtonIconFont:draw()
    local x, y = 0, 0 -- self.position.x, self.position.y

    pushStyle()
    do
        noStroke()

        fill(white)

        font('Foundation-icons')
        fontSize(self.width)

        textMode(CENTER)
        text(utf8.char(iconsFont[self.label]),
            x + self.size.x/2,
            y + self.size.y/2)
    end
    popStyle()
end
