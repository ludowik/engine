function setup()
    cells = Grid(3)

    cells.state = 'play'
    cells.cellSize = 100

    player = 'x'

    players = {
        x = {type='player'},
        o = {type='ia'}
    }

    scores = {
        x = 0,
        o = 0,
        n = 0
    }

    parameter.watch('x', "scores['x']")
    parameter.watch('o', "scores['o']")

    parameter.watch('nul', "scores['n']")

    parameter.action(players['x'].type, function (btn)
            players['x'].type = players['x'].type == 'player' and 'ia' or 'player'
            btn.label = players['x'].type
        end)

    minimax = Minimax(cells)
end

function draw()
    background(51)

    cells:draw(drawCell)
end

function update(dt)
    if cells.state == 'play' then
        local winner = minimax:gameWin(cells)
        if winner then
            cells.state = 'win'
            scores[winner] = scores[winner] + 1

        else
            if minimax:gameEnd(cells) then
                cells.state = 'end'
                scores['n'] = scores['n'] + 1

            elseif players[player].type == 'ia' then
                local cell = minimax:gamePlay(cells, player)
                cell.value = player
                player = minimax:nextPlayer(player)
            end
        end

    elseif cells.state == 'end' or cells.state == 'win' then
        cells:clear()
        cells.state = 'play'
    end
end

class 'Minimax'

function Minimax:init(grid)
    self.WIN_VALUE = 100
    
    self.lines = Array()
    
    for i=1,grid.w do
        self.lines:add({i, 1, 0, 1})
    end
    
    for i=1,grid.h do
        self.lines:add({1, i, 1, 0})
    end
    
    self.lines:add({1, 1, 1, 1})
    self.lines:add({1, grid.h, 1, -1})
end

function Minimax:nextPlayer(player)
    return player == 'x' and 'o' or 'x'
end

local MIN, MAX = math.mininteger, math.maxinteger

function Minimax:minimax(grid, depth, maximizingPlayer, currentPlayer, alpha, beta)
    local winner = self:gameWin(grid)
    if winner then
        return self.WIN_VALUE * (maximizingPlayer and -1 or 1)
    end

    local moves = self:gameMoves(grid)
    local n = #moves

    if depth == 0 or n == 0 then
        return random(self.WIN_VALUE/10) * (maximizingPlayer and -1 or 1)
    end

    local move, op, bestValue
    if maximizingPlayer then
        bestValue = MIN
        op = math.max
    else
        bestValue = MAX
        op = math.min
    end

    for i=1,n do
        move = moves[i]

        grid:set(move.x, move.y, currentPlayer)

        local value = self:minimax(grid, depth-1, not maximizingPlayer, self:nextPlayer(currentPlayer), alpha, beta)

        if op(value, bestValue) == value then
            bestValue = value
        end
        
        if maximizingPlayer then
            alpha = op(alpha, bestValue)
        else
            beta = op(beta, bestValue)
        end

        grid:set(move.x, move.y)

        if beta <= alpha then
            break
        end
    end

    return bestValue
end

function Minimax:gamePlay(grid, player)
    local moves = self:gameMoves(grid)
    local n = #moves

    local bestMove

    local bestValue = math.mininteger
    for i=1,n do
        move = moves[i]

        grid:set(move.x, move.y, player)

        local value = self:minimax(grid, 6, false, self:nextPlayer(player), MIN, MAX)
        if value > bestValue then
            bestValue = value
            bestMove = move
        end

        grid:set(move.x, move.y)
    end

    return grid:cell(bestMove.x, bestMove.y)
end

function Minimax:gameMoves(grid)
    local moves = Array()
    for x,y,cell in grid:ipairs() do
        if not cell.value then 
            moves:add(cell)
        end
    end
    return moves
end

local function testLine(grid, line)
    local x, y, dx, dy = unpack(line)

    local cell = grid:cell(x, y)

    local value = cell.value
    if not value then
        return false
    end

    while cell do
        x = x + dx
        y = y + dy

        cell = grid:cell(x, y)

        if cell and (
            cell.value == nil or
            cell.value ~= value
        )
        then
            return false
        end
    end

    return value
end

function Minimax:gameWin(grid)    
    for _,line in ipairs(self.lines) do
        local winner = testLine(grid, line)
        if winner then
            return winner
        end
    end
end

function Minimax:gameEnd(grid)
    if grid:countNotDefault() == grid.w * grid.h then
        return true
    end
end

function drawCell(x, y, value)
    local w = cells.cellSize / 3

    pushMatrix()
    do
        translate(
            x*cells.cellSize + cells.cellSize/2,
            y*cells.cellSize + cells.cellSize/2)

        stroke(white)
        noFill()

        rectMode(CENTER)
        rect(0, 0, cells.cellSize, cells.cellSize)

        if value == 'x' then
            stroke(red)
            line(x-w, y-w, x+w, y+w)
            line(x-w, y+w, x+w, y-w)

        elseif value == 'o' then
            stroke(green)
            circleMode(CENTER)
            circle(x, y, w)
        end
    end
    popMatrix()
end

function touched(touch)
    if touch.state ~= ENDED then return end

    if players[player].type == 'player' then
        if cells.state == 'play' then
            local x, y = cells.cellSize, cells.cellSize
            local dx, dy = cells.cellSize, cells.cellSize

            local ix = math.floor((touch.x - x) / dx) + 1
            local iy = math.floor((touch.y - y) / dy) + 1

            local cell = cells:cell(ix, iy)

            if cell and not cell.value then
                cell.value = player
                player = minimax:nextPlayer(player)
            end
        end
    end
end
