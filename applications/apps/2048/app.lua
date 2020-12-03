App('App2048')

function App2048:init()
    Application.init(self)

    self.scene = UIScene(Layout.row):attribs{
        alignment = 'h-center,v-center'
    }
    self.scene.bgColor = color(beige)

    self.sceneGame = self.scene

    self.grid = Grid2048()
    self.board = Board2048(self.grid)

    self.scene:add(UIScene(Layout.column):add(
            Button('Nouvelle partie', function ()
                    app.grid:reset()
                end),
            Button('Chargement', function ()
                    app.grid:load()
                end),
            Button('Sauvegarde', function ()
                    app.grid:save()
                end),
            Label('Score'):bind(self.grid, 'score'),
            Label('High Score'):bind(self.grid, 'high_score'),
            Label('Challenge'):bind(self.grid, 'challenge')))

    self.scene:add(self.board)
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

function App2048:keyboard(key, isrepeat)
    self:gesture(key)
end

function App2048:touched(touch)
    Application.touched(self, touch)

    if touch.state == ENDED then
        self:gesture(gestureDirection(touch))
    end
end

function App2048:gesture(action)
    if action == DIR_RIGHT or action == 'right' then
        self.grid:process_move_and_merge(self.grid.test_h, self.grid.w, 1, -1)

    elseif action == DIR_LEFT or action == 'left' then
        self.grid:process_move_and_merge(self.grid.test_h, 1, self.grid.w, 1)

    elseif action == DIR_TOP or action == 'down' then
        self.grid:process_move_and_merge(self.grid.test_v, 1, self.grid.w, 1)

    elseif action == DIR_BOTTOM or action == 'up' then
        self.grid:process_move_and_merge(self.grid.test_v, self.grid.w, 1, -1)

    end
end
