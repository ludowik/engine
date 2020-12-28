

function setup()
    cells = Grid(3, 3)

    cellSize = 100

    player = 'x'

    scores = {
        x = 0,
        o = 0
    }

    cells.state = 'play'

    parameter.watch('x', "scores['x']")
    parameter.watch('o', "scores['o']")
end

function draw()
    background(51)

    cells:draw(drawCell)
end

function update(dt)
    if cells.state == 'play' then
        if not gameWin(cells) then
            if not gameEnd(cells) then
--                if player == 'o' then
                local cell = gamePlay(cells)
                cell.value = player
                player = player == 'x' and 'o' or 'x'
--                end
            end
        end

    elseif cells.state == 'end' or cells.state == 'win' then
        cells:clear()
        cells.state = 'play'
    end
end

-- TODO : find the best move
-- TODO : minmax algo
function gameTest(grid, player)
    local moves = gameMoves(grid)
    for _,move in ipairs(moves) do
        local newGrid = grid:duplicate()
        newGrid:set(move.x, move.y, player)

        if gameWin(grid) == player then
            return move
        end
    end
end

function gamePlay(grid)
    local bestMove = gameTest(grid, player)
    if bestMove then
        return grid:get(bestMove.x, bestMove.y)
    else
        local moves = gameMoves(grid)
        return moves:random()
    end
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
            grid.state = 'win'
            scores[winner] = scores[winner] + 1
            return winner
        end
    end
end

function gameEnd(grid)
    if grid:countNotDefault() == grid.w * grid.h then
        grid.state = 'end'
        return true
    end
end

function drawCell(x, y, value)
    local w = cellSize

    pushMatrix()
    do
        translate(x*w, y*w)

        noFill()
        rect(0, 0, w, w)

        if value == 'x' then
            line(x, y, x+cellSize, y+cellSize)
            line(x, y+cellSize, x+cellSize, y)

        elseif value == 'o' then
            circleMode(CENTER)
            circle(x+w/2, y+w/2, w/2)
        end
    end
    popMatrix()
end

function touched(touch)
    if touch.state ~= ENDED then return end

    if cells.state == 'play' then
        local x, y = cellSize, cellSize
        local dx, dy = cellSize, cellSize

        local ix = math.floor((touch.x - x) / dx) + 1
        local iy = math.floor((touch.y - y) / dy) + 1

        local cell = cells:cell(ix, iy)

        if cell and not cell.value then
            cell.value = player
            player = player == 'x' and 'o' or 'x'
        end
    end
end
