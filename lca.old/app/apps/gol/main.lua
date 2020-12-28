CELLS_COUNT = vector(50, 80)

CELLS_SIZE = 6

function cell2screen(i, j)
    return WIDTH / 10 * i, HEIGHT / 10 * j
end

function setup()
    supportedOrientations(PORTRAIT)
    
    delay = 0

    grid = Grid(CELLS_COUNT.x, CELLS_COUNT.y)
    gridTemp = Grid(CELLS_COUNT.x, CELLS_COUNT.y)

    grid:reset()

    sizeCell = vector(CELLS_SIZE, CELLS_SIZE)

    menu = ToolBar(cell2screen(0, 1))

    menu:add(Button('clear', function (btn) grid:clear() end))    
    menu:add(Button('reset', function (btn) grid:reset() end))
end

function update(dt)
    grid:update(dt)
end

function draw()
    background(51)

    grid:draw()
    
    resetMatrix()
    
    menu:layout()
    menu:draw()
end

function touched(touch)
    local cell = grid:cellFromPosition(touch.x, touch.y)
    if cell then
        grid:addLife(cell.i, cell.j)
    else
        menu:touched(touch)
    end
end

function Grid:reset()
    self:clear()
    for i=1,CELLS_COUNT.x do
        self:addLife()
    end
end

function Grid:addLife(x, y)
    x = x or randomInt(CELLS_COUNT.x)
    y = y or randomInt(CELLS_COUNT.y)

    for i=1,6 do
        local dx = randomInt(-2, 2)
        local dy = randomInt(-2, 2)

        self:set(x+dx, y+dy, true)
    end
end

function Grid:update(dt)
    delay = delay + dt

    if delay >= 0.08 then
        delay = 0
        for i,j,cell in self:ipairs() do
            local adjacent = (
                (self:get(i-1, j-1) == true and 1 or 0) +
                (self:get(i  , j-1) == true and 1 or 0) +
                (self:get(i+1, j-1) == true and 1 or 0) +

                (self:get(i-1, j  ) == true and 1 or 0) +
                (self:get(i+1, j  ) == true and 1 or 0) +

                (self:get(i-1, j+1) == true and 1 or 0) +
                (self:get(i  , j+1) == true and 1 or 0) +
                (self:get(i+1, j+1) == true and 1 or 0))

            local value = cell.value
            if value then
                if adjacent ~= 2 and adjacent ~= 3 then
                    value = false
                end
            else
                if adjacent == 3 then
                    value = true
                end
            end

            gridTemp:set(i, j, value)
        end

        grid, gridTemp = gridTemp, grid
    end
end

function Grid:draw()
    local w, h = sizeCell.x, sizeCell.y

    self.scale = 1

    self.size = vector(
        grid.m * w * self.scale,
        grid.n * h * self.scale)

    self.position = vector(
        (WIDTH  - self.size.x) / 2,
        (HEIGHT - self.size.y) / 2)

    local x = self.position.x
    local y = self.position.y

    translate(x, y)

    scale(self.scale, self.scale)

    stroke(red)
    strokeWidth(1)
    
    fill(red)

    for i=0,grid.m do
        line(w*i, 0, w*i, h*grid.n)
    end

    for j=0,grid.n do
        line(0, h*j, w*grid.m, h*j)
    end

    rectMode(CORNER)
    
    for i,j,cell in self:ipairs() do
        if cell.value then
            rect(w*(i-1), h*(j-1), w, h)
        end
    end
end

function Grid:cellFromPosition(x, y)
    x = x - self.position.x
    y = y - self.position.y

    if x >= 0 and y >= 0 and x < self.size.x and y < self.size.y then
        local i = math.ceil(x / (sizeCell.x * self.scale))
        local j = math.ceil(y / (sizeCell.y * self.scale))
        return self:cell(i, j)
    end
end
