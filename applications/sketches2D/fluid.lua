function setup()
    N = 100
    S = 5

    grid = Grid(N)
    grid2 = Grid(N)
    for x=1,N do
        for y=1,N do
            grid:set(x, y, random())
        end
    end

    img = image(N)
end

function diffuse(grid, x, y)
    local value = grid:get(x, y)

    local newValue = 0
        + value * 0.8
        + (grid:get(x-1, y-1) or value) * 0.05
        + (grid:get(x+1, y-1) or value) * 0.05
        + (grid:get(x-1, y+1) or value) * 0.05
        + (grid:get(x+1, y+1) or value) * 0.05

    newValue = clamp(newValue, 0, 1)
    return newValue
end

function perte(grid, x, y)
    local value = grid:get(x, y)

    local newValue = value * 0.99999

    newValue = clamp(newValue, 0, 1)
    return newValue
end

function update(dt)
    for x=1,N do
        for y=1,N do
            grid2:set(x, y, diffuse(grid, x, y))
        end
    end
    grid, grid2 = grid2, grid

    for x=1,N do
        for y=1,N do
            grid2:set(x, y, perte(grid, x, y))
        end
    end
    grid, grid2 = grid2, grid
end

function draw()
    translate(WIDTH/2, HEIGHT/2)

    for x=1,N do
        for y=1,N do
            local value = grid:get(x, y)
            img:set(x, y, value, value, value)
        end
    end

    spriteMode(CENTER)
    sprite(img, 0, 0, N*S, N*S)
end
