class('TrioGrid', UI)

TrioGrid.selectable = true
TrioGrid.selectColor = color(230, 224, 224, 133)

function TrioGrid:init(m, n, state)
    UI.init(self)
    
    self.cellSize = min(ws(), hs())
    
    -- x, y == m, n == c, r
    self.m = m or 10
    self.n = n or self.m
    
    self.fixedSize = vec3(self.m, self.n) * self.cellSize
	
    self.bgColor = red
    
    self.drawMode = CENTER
    
	self:reset()
end

function TrioGrid:reset()
    self.cells = {}  
    for r = 1, self.n do
        for c = 1, self.m do
            self:cell(c, r, self:newCell(c, r, self.cellSize, state))
        end
    end
end

function TrioGrid:newCell(...)
    return Cell(...)
end

function TrioGrid:cell(x, y, cell)
    if cell then
        self.cells[(y-1)*self.m+x] = cell
    end
    return self.cells[(y-1)*self.m+x]
end

function TrioGrid:rotate(clockwise)
    local m, n = self.m, self.n
    
    local grid = TrioGrid(n, m)
    
    for c, r, _ in self:ipairs() do
        local cell = grid:cell(r, c, grid:newCell(r, c, self.cellSize))
        if clockwise then
            cell.state = self:cell(c, n-r+1).state
        else
            cell.state = self:cell(m-c+1, r).state
        end
    end
    
    grid.position = self.position
    grid.selectable = self.selectable
    
    grid.scaling = defaultScale()
    
    grid.fixedSize = self.fixedSize
        
    return grid
end

function TrioGrid:inGrid(grid)
    local x1 = grid:x1() + grid.cellSize
    local y1 = grid:y1() + grid.cellSize
    
    return self:inCell(x1, y1)
end

function TrioGrid:inCell(x1, y1)
    x1 = x1 - self:x1()
    y1 = y1 - self:y1()
    
    for x, y, cell in self:ipairs() do
        if cell:contains(x1, y1) then
            return vec3(x, y)
        end
    end
end

function TrioGrid:findSelectable(grid)
    for x, y, cell in self:ipairs() do
        local pos = vec3(x,y)
        if self:isSelectable(pos, grid) then
            return pos
        end
    end
end

function TrioGrid:isSelectable(pos, grid)
    local x = pos.x - 1
    local y = pos.y - 1
    
    if x + grid.m > self.m or y + grid.n > self.n then
        return false
    end
    
    for c, r, cell in grid:ipairs() do
        if cell.state and self:cell(x+c, y+r).state then
            return false
        end
    end
    
    return true
end

function TrioGrid:select(pos, grid)
    for x, y, cell in grid:ipairs() do
        if cell.state then
            self:cell(pos.x+x-1, pos.y+y-1).select = true
        end
    end
end

function TrioGrid:unselect()
    for _, _, cell in self:ipairs() do
        cell.select = nil
    end
end

function TrioGrid:add(pos, grid)
    for x, y, cell in grid:ipairs() do
        if cell.state then
            self:cell(pos.x+x-1, pos.y+y-1).state = cell.state
        end
    end
end

function TrioGrid:computeSize()
    self.size = vec3(
        min(4, self.m) * self.cellSize,
        min(4, self.n) * self.cellSize)
end

function TrioGrid:draw()
    for _, _, cell in self:ipairs() do
        cell:draw(self)
    end
end

function TrioGrid:check()
    local score = 0
    
    local columns = Table(self.m, 0)
    local rows = Table(self.n, 0)
    
    for x, y, cell in self:ipairs() do
        if cell.state then
            columns[x] = columns[x] + 1
            rows[y] = rows[y] + 1
        end
    end
    
    for x, y, cell in self:ipairs() do
        if cell.state then
            if columns[x] == self.n then
                cell.state = nil
                score = score + 1
            end
            if rows[y] == self.m then
                cell.state = nil
                score = score + 1
            end
        end
    end
    return score
end

function TrioGrid:save()
    for x, y, cell in self:ipairs() do
        saveLocalData(x..","..y, cell.state)
    end
end

function TrioGrid:load()
    for x, y, cell in self:ipairs() do
        cell.state = readLocalData(x..","..y)
    end
end

function TrioGrid:ipairs()
    local c = 0
    local r = 1
    
    return function ()
        c = c + 1
        if c > self.m then
            c = 1
            r = r + 1
        end
        if r > self.n then
            return nil
        end
        return c, r, self:cell(c, r)
    end
end
