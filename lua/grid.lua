class('Grid')

function Grid:init(w, h)
    self.w = w or 1
    self.h = h or self.w

    self.defaultValue = nil

    self:clear()
end

function Grid:newCell(x, y, value)
    return {
        x = x,
        y = y,
        value = value
    }
end

function Grid:clear(value)
    self.cells = {}

    if self.newCell then
        for j=1,self.h do
            for i=1,self.w do
                self:cell(i, j, self:newCell(i, j, value))
            end
        end
    end
    return self
end

function Grid:ref(x, y)
    if (1 <= x and x <= self.w and
        1 <= y and y <= self.h)
    then
        return x + (y-1) * self.w
    end
end

function Grid:add(x, y, value)
    self:cell(x, y).value = self:cell(x, y).value + value
end

function Grid:remove(x, y)
    local cell = self:cell(x, y)
    if cell then
        self:set(x, y, nil)
        return cell
    end
end

function Grid:set(x, y, value)
    local cell = self:cell(x, y)
    if cell then
        cell.value = value or self.defaultValue
    end
end

function Grid:get(x, y)
    local cell = self:cell(x, y)
    if cell then
        return cell.value or self.defaultValue
    end
end

function Grid:cell(x, y, cell)
    local ref = self:ref(x, y)
    if ref then
        self.cells[ref] = (
            cell or
            self.cells[ref] or
            self:newCell(x, y)
        )

        return self.cells[ref]
    end
end

function Grid:ipairs()
    local x = 0
    local y = 1

    return function ()
        x = x + 1
        if x > self.w then
            x = 1
            y = y + 1
        end
        if y > self.h then
            return nil
        end
        return x, y, self:cell(x, y)
    end
end

function Grid:rotate()
    local array = Grid(self.h, self.w)
    for i=1,self.w do
        for j=1,self.h do
            array:set(i, j, self:get(j, self.h-i+1))
        end
    end
    return array
end

function Grid:copy(array, xt, yt)
    for i=1,array.w do
        for j=1,array.h do
            local value = array:get(i, j)
            if value then
                self:set(xt+i-1, yt+j-1, value)
            end
        end
    end
end

function Grid:save()
    for x, y, cell in self:ipairs() do
        saveProjectData(x..','..y, self:saveValue(cell))
    end
end

function Grid:saveValue(cell)
    return cell.value
end

function Grid:load()
    for x, y, _ in self:ipairs() do
        self:set(x, y, self:loadValue(readProjectData(x..','..y)))
    end
end

function Grid:loadValue(value)
    return value
end

function Grid:draw(draw)
    for x=1,self.w do
        for y=1,self.h do
            draw(x, y, self:get(x, y))
        end
    end
end

function Grid.test()
    local grid = Grid()
    grid:set(1, 1, 12)
    assert(grid:get(1, 1) == 12)
end
