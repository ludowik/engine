App('Tetris')

Tetris.itemSize = floor(WIDTH/30)
Tetris.gridSize = vec2(10, 12)

class('myScene', Scene)

function myScene:init()
    Scene.init(self)
end

function myScene:computeSize()
    self.nodes[1]:computeSize()
    self.size = self.nodes[1].size
end

function Tetris:init()
    Application.init(self)

    supportedOrientations(PORTRAIT)

    self.scene = UIScene(Layout.row)
    self.scene.alignment = 'v-center,h-center'

    self.ui.state = UITimer('pause', 3, function ()
            self.active = true
        end)

    self.scene:add(UIScene(Layout.column):add(
            Label('level'),
            Expression('app.level'),
            Label('score'),
            Expression('app.score'),
            Label('line'),
            Expression('app.lines'),
            ButtonIconFont('burst_new', callback(self, app.newGame)),
            ButtonIconFont('pause', function ()
                    if self.active then
                        self:pause()
                    else
                        self:resume()
                    end
                end),
            self.ui.state))

    self.grid = TetrisGrid(self.gridSize.x, self.gridSize.y, self.itemSize)
    self.tetrimino = Scene()

    self.scene:add(UIScene():add(self.grid, self.tetrimino))

    self.tetriminos = {
        Tetrimino('I', {0,0,2,3,4,5,0,0}, blue:lighten()),
        Tetrimino('O', {1,2,0,1,2}, yellow:darken()),
        Tetrimino('T', {0,1,2,3,0,2}, purple),
        Tetrimino('L', {0,1,2,3,0,3}, orange),
        Tetrimino('J', {0,1,2,3,0,1}, blue:lighten()),
        Tetrimino('Z', {0,2,3,0,1,2}, red:lighten()),
        Tetrimino('S', {0,1,2,0,2,3}, green)
    }

    self:nextTetrimino()

    self:loadGame()

    self.active = false
end

function Tetris:newGame()
    self.score = 0
    self.lines = 0
    self.level = 0

    self.grid:clear()
    self.grid:save()

    self.mino = nil
    self:nextTetrimino()

    self:pause()
end

function Tetris:saveGame()
    saveProjectData('score', self.score)
    saveProjectData('lines', self.lines)
    saveProjectData('level', self.level)

    self.grid:save()
end

function Tetris:loadGame()
    self.score = readProjectData('score', 0)
    self.lines = readProjectData('lines', 0)
    self.level = readProjectData('level', 0)

    self.grid:load()
end

function Tetris:pause()
    Application.pause(self)
    self.active = false
    self.ui.state:reset()
end

function Tetris:resume()
    Application.resume(self)
    self.ui.state:start()
end

function Tetris:update(dt)
    Application.update(self, dt)

    if self.active then
        self.mino.time = self.mino.time - dt
        if self.mino.time <= 0 then
            self.mino:gravity()
            self.mino.time = 1 - 0.8 * (self.level/30)

            self:saveGame()
        end
    end
end

function Tetris:keyboard(key, isrepeat)
    if not self.active then return end
    if key == 'left' then
        self.mino:left()
    elseif key == 'right' then
        self.mino:right()
    elseif key == 'up' then
        self.mino:rotate()
    elseif key == 'down' then
        self.mino:down()
    elseif key == 'space' then
        self.mino:bottom()
    end

    self:saveGame()
end

function Tetris:nextTetrimino()
    if self.mino then
        self.grid:copy(self.mino,
            self.mino.gridPosition.x,
            self.mino.gridPosition.y)
        self.mino:reset()

        self:hasLines()
    end

    local i = randomInt(1,#app.tetriminos)
    self.mino = app.tetriminos[i]
    self.mino:reset()

    app.tetrimino:clear()
    app.tetrimino:add(self.mino)
end

function Tetris:hasLines()
    local countLines = 0
    while self:hasLine() do
        countLines = countLines + 1
        if self.lines % 10 == 0 then
            self.level = self.level + 1
        end
    end

    if countLines == 1 then
        self.score = self.score + 100 * self.level
    elseif countLines == 2 then
        self.score = self.score + 300 * self.level
    elseif countLines == 3 then
        self.score = self.score + 500 * self.level
    elseif countLines == 4 then
        self.score = self.score + 1200 * self.level
    end

    -- T-Spin
    if app.lastMove == 'rotation' then
        self.score = self.score + 400 * self.level
    end
end

function Tetris:hasLine()
    for y=1,self.grid.h do
        local countMinos = 0
        for x=1,self.grid.w do
            if self.grid:get(x, y) then
                countMinos = countMinos + 1
            end
        end

        if countMinos == self.grid.w then
            for y1=y+1,self.grid.h do
                for x1=1,self.grid.w do
                    self.grid:set(x1, y1-1, self.grid:get(x1, y1))
                end
            end
            for x1=1,self.grid.w do
                self.grid:set(x1, self.grid.h, nil)
            end

            self.lines = self.lines + 1

            return true
        end
    end
end

class('TetrisGrid', Grid, UI)

function TetrisGrid:init(w, h, itemSize)
    UI.init(self)
    Grid.init(self, w, h)

    self.itemSize = itemSize
    self.alignMode = CORNER
end

function TetrisGrid:saveValue(cell)
    if cell and cell.value then
        return cell.value
    end
end

function TetrisGrid:loadValue(value)
    if value then
        if typeof(value) == 'color' then
            return value
        end
    end
end

function TetrisGrid:computeSize()
    self.size.x = self.itemSize * self.w
    self.size.y = self.itemSize * self.h
end

function TetrisGrid:computePosition()
    self.position = vec2(
        self.itemSize * (self.gridPosition.x - 1),
        self.itemSize * (self.gridPosition.y - 1))

    self.position = self.position -- + app.grid.absolutePosition
end

function TetrisGrid:touched(touch)
    local x, y =
    touch.x - app.grid.parent.absolutePosition.x,
    touch.y - app.grid.parent.absolutePosition.y

    if y > app.grid.size.y * 2 / 3 then
        app.mino:rotate()

    elseif y > 0 and y < app.grid.size.y / 3 then
        app.mino:down()

    else
        if x > 0 and x < app.grid.size.x / 2 then
            app.mino:left()
        else
            app.mino:right()
        end
    end
end

function TetrisGrid:draw()
    local size = self.itemSize

    translate(-size, -size)

    stroke(110)
    strokeWidth(1)

    noFill()

    for y=1,self.h do
        for x=1,self.w do
            rectMode(CORNER)
            rect(x*size, y*size, size, size)
        end
    end

    noStroke()

    for y=1,self.h do
        for x=1,self.w do
            local fillColor = self:get(x, y)

            if fillColor then
                fill(fillColor)

                if self:get(x-1, y) == fillColor then
                    rect(x*size, y*size, 1, size)
                end
                if self:get(x+1, y) == fillColor then
                    rect(x*size+size, y*size, 1, size)
                end
                if self:get(x, y-1) == fillColor then
                    rect(x*size, y*size, size, 1)
                end
                if self:get(x, y+1) == fillColor then
                    rect(x*size, y*size+size, size, 1)
                end

                rect(x*size+1, y*size+1, size-1, size-1)
            end
        end
    end

    for y=1,self.h do
        for x=1,self.w do
            local fillColor = self:get(x, y)

            if fillColor then
                stroke(227, 222, 219)
                strokeWidth(4)

                lineCapMode(ROUND)

                if self:get(x-1, y) == nil then
                    line(x*size, y*size, x*size, y*size+size)
                end
                if self:get(x+1, y) == nil then
                    line(x*size+size, y*size, x*size+size, y*size+size)
                end
                if self:get(x, y-1) == nil then
                    line(x*size, y*size, x*size+size, y*size)
                end
                if self:get(x, y+1) == nil then
                    line(x*size, y*size+size, x*size+size, y*size+size)
                end
            end
        end
    end
end

class('Tetrimino', TetrisGrid)

function Tetrimino:init(label, init, clr)
    self.label = label

    local n = table.getnKeys(init)

    local x, y, w, h = 0, 0, 0, 1
    for i=1,n do
        if init[i] == 0 then
            h = h + 1
        else
            x = init[i]
            w = max(x, w)
        end
    end

    TetrisGrid.init(self, w, h, app.itemSize)

    x, y = 0, 1
    for i=1,n do
        if init[i] == 0 then
            y = y + 1
        else
            x = init[i]
            self:set(x, y, clr)
        end
    end

    self:computeSize()
    self:reset()
end

function Tetrimino:reset()
    self.time = 1
    self.gridPosition = vec2(
        floor(app.gridSize.x/2) - floor(self.w/2),
        app.gridSize.y)

    self:computePosition()
end

function Tetrimino:moveIsAllowed(move, array)
    local grid = app.grid
    local gridPosition = self.gridPosition:clone() + move
    array = array or self

    for x=1,array.w do
        for y=1,array.h do
            if array:get(x, y) then
                if x + gridPosition.x - 1 < 1 then
                    return false
                end
                if x + gridPosition.x - 1 > app.gridSize.x then
                    return false
                end
                if y + gridPosition.y - 1 < 1 then
                    return false
                end
                if grid:get(x + gridPosition.x - 1, y + gridPosition.y - 1) then
                    return false
                end
            end
        end
    end
    return true
end

function Tetrimino:gravity(n)
    n = n or -1
    if self:move(0, n) then
        return true
    else
        app:nextTetrimino()
    end
end

function Tetrimino:down(n)
    n = n or -1
    if self:gravity(n) then
        app.lastMove = 'down'
        return true
    end
end

function Tetrimino:bottom()
    while self:down() do
    end
end

function Tetrimino:move(x, y)
    if self:moveIsAllowed(vec2(x, y)) then
        self.gridPosition.x = self.gridPosition.x + x
        self.gridPosition.y = self.gridPosition.y + y
        self:computePosition()
        return true
    end
end

function Tetrimino:left(n)
    n = n or -1
    if self:move(n, 0) then
        app.lastMove = 'left'
        return true
    end
end

function Tetrimino:right(n)
    n = n or 1
    if self:move(n, 0) then
        app.lastMove = 'right'
        return true
    end
end

function Tetrimino:rotate()
    local array = Grid.rotate(self)
    if self:moveIsAllowed(vec2(0, 0), array) then
        for i=1,#array.cells do
            self.cells[i] = array.cells[i]
        end
        app.lastMove = 'rotate'
        return true
    end
end
