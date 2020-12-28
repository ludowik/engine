class('Box', Item)

function Box:init(level, i, j, itemType)
    Item.init(self, i, j)

    self.itemType = itemType
    
    self.size = vector(
        CELL_SIZE - CELL_MARGE * 2,
        CELL_SIZE - CELL_MARGE * 2)

    self.collision = level
end

function Box:draw()
    noFill()

    local clr = color()
    local from, to = yellow, red

    clr.r = map(self.collision, 1, level, from.r, to.r)
    clr.g = map(self.collision, 1, level, from.g, to.g)
    clr.b = map(self.collision, 1, level, from.b, to.b)

    stroke(clr)
    strokeWidth(3)

    pushMatrix()
    do
        translate(self.position.x, self.position.y)
        rotate(self.body.angle)

        if self.body.shapeType == POLYGON then
            polygon(self.body.points)
        elseif self.body.shapeType == CIRCLE then
            circle(0, 0, self.size.x / 2)
        end
    end
    popMatrix()

    fill(white)

    textMode(CENTER)
    text(self.collision, self.position.x, self.position.y)
end
