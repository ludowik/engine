class('Grid', Table)

function Grid:init(m, n)
    n = n or m
    
    self.m, self.n = m, n
    self.w, self.h = m, n

    self.already_scan = true

    self:clear()
end

function Grid:clear(value)
    Table.clear(self)

    if self.newCell then
        for j=1,self.n do
            for i=1,self.m do
                self:cell(i, j, self:newCell(i, j, value))
            end        
        end
    end
end

function Grid:newCell(i, j, value)
    return {
        i = i,
        j = j,
        value = value -- default is nil
    }
end

local function inRange(v, min, max)
    if v >= min and v <= max then
        return true
    end
end

function Grid:offset(i, j)
    if inRange(i, 1, self.m) and inRange(j, 1, self.n) then
        return i + (j - 1) * self.m
    end
    return -1
end

function Grid:get(i, j)
    local cell = self:cell(i, j)
    return cell and cell.value or nil
end

function Grid:set(i, j, value)
    local cell = self:cell(i, j)
    if cell then
        cell.value = value
    end
end

function Grid:cell(i, j, cell)
    local offset = self:offset(i, j)        
    if offset > 0 then
        if cell then
            self[offset] = cell
        end
        return self[offset]
    end
end

function Grid:remove(i, j)
    local cell = self:cell(i, j)        
    if cell then
        self:set(i, j, nil)
        return cell
    end
end

function Grid:save()
    for i, j, _ in self:ipairs() do
        saveProjectData(i..','..j, self:saveValue(self:get(i, j)))
    end
end

function Grid:saveValue(value)
    return value
end

function Grid:load()
    for i, j, _ in self:ipairs() do
        self:set(i, j, self:loadValue(readProjectData(i..','..j)))
    end
end

function Grid:loadValue(value)
    return value
end

function Grid:ipairs()
    local i = 0
    local j = 1

    return function ()
        i = i + 1
        if i > self.m then
            i = 1
            j = j + 1
        end
        if j > self.n then
            return nil
        end
        return i, j, self:cell(i, j)
    end
end

function Grid:rotate()
    local array = Grid(self.n, self.m)
    for i=1,self.m do
        for j=1,self.n do
            array:set(i, j, self:get(j, self.h-i+1))
        end
    end
    return array
end

function Grid:copy(array, xt, yt)
    for i=1,array.m do
        for j=1,array.n do
            local value = array:get(i, j)
            if value then
                self:set(xt+i-1, yt+j-1, value)
            end
        end
    end
end

function Grid:draw(f, ...)
    if f and type(f) == 'function' then
        for _, _, cell in self:ipairs() do
            f(cell.i, cell.j, cell.value)
        end
    else
        Table.draw(self, f, ...)
    end
end
