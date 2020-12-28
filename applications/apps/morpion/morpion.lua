function setup()
    cells = Grid(3, 3)

    cellSize = 100

    player = 'x'

    players = {
        x = {type='ia'},
        o = {type='ia'}
    }

    scores = {
        x = 0,
        o = 0,
        n = 0
    }

    cells.state = 'play'

    parameter.watch('x', "scores['x']")
    parameter.watch('o', "scores['o']")

    parameter.watch('nul', "scores['n']")
end

function draw()
    background(51)

    cells:draw(drawCell)
end

function update(dt)
    if cells.state == 'play' then
        local winner = gameWin(cells)
        if winner then
            cells.state = 'win'
            scores[winner] = scores[winner] + 1
        else
            if not gameEnd(cells) then
                if players[player].type == 'ia' then
                    local cell = gamePlay(cells, player)
                    cell.value = player
                    player = nextPlayer(player)
                end
            end
        end

    elseif cells.state == 'end' or cells.state == 'win' then
        cells:clear()
        cells.state = 'play'
    end
end

function nextPlayer(player)
    return player == 'x' and 'o' or 'x'
end

function minimax(grid, depth, maximizingPlayer, currentPlayer)
    local moves = gameMoves(grid)

    local bestMove = {
        move = nil,
        value = 0
    }

    if depth == 0 or #moves == 0 then
        if maximizingPlayer then
            if gameWin(grid) == currentPlayer then
                bestMove.value = 100
            end
        else
            if gameWin(grid) == currentPlayer then
                bestMove.value = 100
            end
        end
        return bestMove
    end

    grid = grid:duplicate()

    if maximizingPlayer then
        bestMove.value = math.mininteger
        for _,move in ipairs(moves) do
            grid:set(move.x, move.y, currentPlayer)
            local res = minimax(grid, depth-1, false, nextPlayer(currentPlayer))
            if res.value > bestMove.value then
                bestMove.move = move
                bestMove.value = res.value
            end
            grid:set(move.x, move.y)
        end

    else
        bestMove.value = math.maxinteger
        for _,move in ipairs(moves) do
            grid:set(move.x, move.y, currentPlayer)
            local res = minimax(grid, depth-1, true, nextPlayer(currentPlayer))
            if res.value < bestMove.value then
                bestMove.move = move
                bestMove.value = res.value
            end
            grid:set(move.x, move.y)
        end
    end
    return bestMove
end

-- TODO : minmax algo
function gamePlay(grid, player)
    local bestMove = minimax(grid, 6, true, player)
    return grid:cell(bestMove.move.x, bestMove.move.y)
    --return gameBestMove(grid, player, player, 1)
end

function gameBestMove(grid, player, currentPlayer, level)
    local moves = gameMoves(grid)

    --    print('level='..level..' n='..#moves)

    if #moves == 0 then
        return
    end

    grid = grid:duplicate()

    local bestMove, winningPlayer
    for _,move in ipairs(moves) do
        grid:set(move.x, move.y, currentPlayer)

        do
            local winner = gameWin(grid)        
            if winner == currentPlayer then
                bestMove = move
                winningPlayer = currentPlayer
                grid:set(move.x, move.y)
                break

            else

                -- next player
                local bestMoveForNextPlayer, winningPlayer = gameBestMove(grid, player, nextPlayer(currentPlayer), level+1)
                if winningPlayer == currentPlayer then
                    bestMove = move
                end

            end
        end
        grid:set(move.x, move.y)
    end

    if not bestMove then
        bestMove = moves:random()
    end

    return bestMove, winningPlayer
end

function gameMoves(grid)
    local moves = Array()
    for x,y,cell in grid:ipairs() do
        if not cell.value then 
            moves:add(cell)
        end
    end
    return moves
end

function gameWin(grid)
    local len = 3
    function testLine(x, y, dx, dy)
        local value = grid:get(x, y)
        if not value then
            return false
        end
        if grid:get(x+dx, y+dy) ~= value then
            return false
        end
        if grid:get(x+dx+dx, y+dy+dy) ~= value then
            return false
        end
        return value
    end

    local lines = {
        {1, 1, 1, 0},
        {1, 2, 1, 0},
        {1, 3, 1, 0},
        {1, 1, 0, 1},
        {2, 1, 0, 1},
        {3, 1, 0, 1},
        {1, 1, 1, 1},
        {1, 3, 1, -1},
    }

    for _,line in ipairs(lines) do
        local winner = testLine(unpack(line))
        if winner then
            return winner
        end
    end
end

function gameEnd(grid)
    if grid:countNotDefault() == grid.w * grid.h then
        grid.state = 'end'
        scores['n'] = scores['n'] + 1
        return true
    end
end

function drawCell(x, y, value)
    local w = cellSize / 3

    pushMatrix()
    do
        translate(
            x*cellSize + cellSize/2,
            y*cellSize + cellSize/2)

        stroke(white)
        noFill()

        rectMode(CENTER)
        rect(0, 0, cellSize, cellSize)

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
            local x, y = cellSize, cellSize
            local dx, dy = cellSize, cellSize

            local ix = math.floor((touch.x - x) / dx) + 1
            local iy = math.floor((touch.y - y) / dy) + 1

            local cell = cells:cell(ix, iy)

            if cell and not cell.value then
                cell.value = player
                player = nextPlayer(player)
            end
        end
    end
end
