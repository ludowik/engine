class('Grid2048', Grid)

MERGE = 'merge'
MOVE  = 'move'

function Grid2048:init()
    Grid.init(self, 4, 4)

    if not self:load() then
        self:new()
    end
end

function Grid2048:new()
    self:clear()

    self.score = 0

    self:add_random_cell()
    self:add_random_cell()
end

function Grid2048:newCell(i, j)
    return Cell2048()
end

function Grid2048:save()
    table.save(self, getProjectDataPath('grid'))
end

function Grid2048:load()
    local data = table.load(getProjectDataPath('grid'))
    if data then
        for i,v in ipairs(data) do
            self[i] = Cell2048(v.value)
        end

        self.score = data.score or 0
        self.high_score = data.high_score or 0
        self.challenge = data.challenge or 8

        return true
    end
end

function Grid2048:add_random_cell()
    while not self:random_cell() do
    end
    self:save()
end

function Grid2048:random_cell()
    local i = randomInt(1, self.m)
    local j = randomInt(1, self.n)

    local cell = self:cell(i, j)

    if cell and cell.value == nil then
        if math.random(1, 100) > 20 then
            cell = self:cell(i, j, Cell2048(2))
        else
            cell = self:cell(i, j, Cell2048(4))
        end

        cell.scaling = 0.1

        return true
    end
end

function Grid2048:is_game_over()
    if (self:move_and_merge(self.test_h, self.n,      1, -1, true) or
        self:move_and_merge(self.test_h,      1, self.n,  1, true) or
        self:move_and_merge(self.test_v, self.n,      1, -1, true) or
        self:move_and_merge(self.test_v,      1, self.n,  1, true))
    then
        return false
    end

    return true
end

function Grid2048:process_move_and_merge(f, k1, k2, inc, only_check)
    if self.co then return end 

    self.co = coroutine.create(function ()
            local merge_or_move = self:move_and_merge(f, k1, k2, inc, only_check)
            if merge_or_move and not self:is_game_over() then
                self:add_random_cell()
            end
        end)

    coroutine.resume(self.co)
end

function Grid2048:move_and_merge(f, k1, k2, inc, only_check)
    if not only_check then
        print(f, k1, k2, inc, only_check)
    end

    local move_or_merge = false

    for i = 1, self.n do
        for j = 1, self.n do
            local cell = self:cell(i, j)
            cell.new = nil
        end
    end

    while f(self, k1, k2, inc, MOVE, only_check) or f(self, k1, k2, inc, MERGE, only_check) do
        move_or_merge = true
        if only_check then
            break
        end
    end

    if not only_check and move_or_merge then
        for i = 1, self.n do
            for j = 1, self.n do
                local cell = self:cell(i, j)
                if cell.value and cell.value >= self.challenge then
                    self.challenge = self.challenge * 2
                end
            end
        end

        self:save()
    end

    return move_or_merge
end

function Grid2048:test_h(i1, i2, inc, action, only_check)
    local has_move = false

    for j = 1, self.n do
        for i = i1, i2-inc, inc do
            local cell = self:cell(i, j)
            local cell_adjacent = self:cell(i+inc, j)

            has_move = self:test(cell, cell_adjacent, action, only_check) or has_move
        end

        if self.co then
            coroutine.yield(self.co)
        end
    end

    return has_move
end

function Grid2048:test_v(j1, j2, inc, action, only_check)
    local has_move = false

    for i = 1, self.n do
        for j = j1, j2-inc, inc do
            local cell = self:cell(i, j)
            local cell_adjacent = self:cell(i, j+inc)

            has_move = self:test(cell, cell_adjacent, action, only_check) or has_move
        end

        if self.co then
            coroutine.yield(self.co)
        end
    end

    return has_move
end

function Grid2048:test(cell, cell_adjacent, action, only_check)
    if action == MERGE and cell.value ~= nil then
        if cell.value == cell_adjacent.value and not cell.new and not cell_adjacent.new then
            if not only_check then
                cell.value = cell.value + cell_adjacent.value
                cell.new = true

                cell_adjacent.value = nil
                cell_adjacent.new = nil

                self.score = self.score + cell.value
                self.high_score = max(self.high_score, self.score)

                sound(SOUND_HIT, 0)
            end
            return true
        end
    end

    if action == MOVE and cell.value == nil then
        if cell_adjacent.value ~= nil then
            if not only_check then
                cell.value = cell_adjacent.value
                cell.new = cell_adjacent.new

                cell_adjacent.value = nil
                cell_adjacent.new = nil
            end
            return true
        end
    end

    return false
end
