class('Item')

function Item:init(i, j)
    self.cell = vec2(i, j)

    local x = (i-1) * CELL_SIZE + CELL_SIZE / 2
    local y = (j-1) * CELL_SIZE + CELL_SIZE / 2

    self.position = vec2(x, y)
end

function Item:nextLine()
    self.cell.y = self.cell.y - 1
    self.position.y = self.position.y - CELL_SIZE
end
