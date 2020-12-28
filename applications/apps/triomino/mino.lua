function Mino(state, ...)
    arg = {...}
    local n = #arg / 2

    local m = 0
    for i = 0, #arg-1, 2 do
        m = math.max(m, arg[i+1] + arg[i+2] - 1)
    end

    local r = 1
    local grid = TrioGrid(m, n)
    grid.selectable = false
    
    grid.translation = vec3()    
    grid.scaling = defaultScale()
    grid.angle = 0

    grid.fixedSize = vec3(2, 2):mul(grid.cellSize)

    for i = 0, #arg-1, 2 do
        local c = arg[i+1]
        local len = arg[i+2]
        for i = 1, len do
            grid:cell(c+i-1, r).state = state
        end
        r = r + 1
    end
    return grid
end

function defaultScale()
    return vec3(0.4, 0.4)
end

local minos = {
    "1, 1",
    "1, 2",
    "1, 3",
    "1, 4",
    "1, 5",
    "1, 2, 1, 2",
    "1, 2, 1, 1",
    "1, 3, 1, 1",
    "1, 3, 2, 1",
    "1, 4, 2, 1",
    "1, 3, 1, 2",
    "1, 2, 2, 3",
    "1, 2, 1, 1, 1, 2",
    "2, 1, 1, 3, 2, 1",
    "1, 2, 2, 2, 3, 1",
    "2, 1, 1, 3, 1, 1",
    "1, 3, 2, 1, 2, 1"
}

function createMino(i)
    i = i or math.random(#minos)
    return Mino(i, unpack(string.split(minos[i], ',')))
end
