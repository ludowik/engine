supportedOrientations(PORTRAIT_ANY)

App('App2048')

function App2048.setup()
    supportedOrientations(PORTRAIT_UPSIDE_DOWN)
end

function App2048:init()
    Application.init(self)

    self.scene = UIScene(Layout.column):attribs{
        alignment = 'h-center,v-center'
    }
    self.sceneGame = self.scene

    self.grid = Grid2048()
    self.uigrid = UIGrid2048(self.grid)

    self.scene:add(UIScene(Layout.column):add(
            Button('Nouvelle partie', function ()
                    app.grid:new()
                end),
            Label('Score'):bind(self.grid, 'score'),
            Label('High Score'):bind(self.grid, 'high_score')))

    self.scene:add(self.uigrid)
end

function App2048:update(dt)
    Application.update(self, dt)

    if self.grid.co then
        coroutine.resume(self.grid.co)
        if coroutine.status(self.grid.co) == 'dead' then
            self.grid.co = nil
        end
    else
        if self.scene == self.sceneGame and self.grid:is_game_over() then
            self:pushScene(GameOver())
        end
    end
end

function App2048:keypressed(key)
    self:action(key)
end

function App2048:touched(touch)
    Application.touched(self, touch)

    if touch.state == ENDED then
        self:action(touchDirection(touch))
    end
end

function App2048:action(action)
    if action == DIR_RIGHT or action == 'right' then
        self.grid:process_move_and_merge(self.grid.test_h, self.grid.n, 1, -1)

    elseif action == DIR_LEFT or action == 'left' then
        self.grid:process_move_and_merge(self.grid.test_h, 1, self.grid.n, 1)

    elseif action == DIR_TOP or action == 'down' then
        self.grid:process_move_and_merge(self.grid.test_v, 1, self.grid.n, 1)

    elseif action == DIR_BOTTOM or action == 'up' then
        self.grid:process_move_and_merge(self.grid.test_v, self.grid.n, 1, -1)

    end
end
