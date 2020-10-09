App('AppSudoku')

function AppSudoku:init()
    Application.init(self)

    supportedOrientations(PORTRAIT)

    self.scene = UIScene(Layout.row)
    self.scene.alignment = 'v-center,h-center'

    self.showPossibilities = readProjectData('showPossibilities', true)

    self.grid = GridSudoku('grid', 3)

    self.grid:load()
    self.grid:check_grid()

    self.ui.toolbar = UIScene()
    self.ui.toolbar.alignment = 'v-center'
    self.ui.toolbar:add(
        Button('help'    , self.grid, self.grid.help    ),
        Button('resolve' , self.grid, self.grid.resolve ),
        Button('clear'   , self.grid, self.grid.clear   ),
        Button('first'   , self.grid, self.grid.first   ),
        Button('next'    , self.grid, self.grid.next    ),
        Button('generate', self.grid, self.grid.generate),
        Button('save'    , self.grid, self.grid.save    ),
        Button('load'    , self.grid, self.grid.load    ),
        Button('options' , self, self.options))

    self.ui.grid = UI_grid(self.grid)

    self.ui.numbers = UIScene():setLayoutFlow(Layout.grid, 3)
    self.ui.numbers.alignment = 'v-center'

    self.scene:add(
        self.ui.toolbar,
        self.ui.grid,
        self.ui.numbers
    )

    local size = ws(0.8) - 5
    for i = 1, 9 do
        local number = Number(tostring(i), callback(self, self.enter_number))
        :attribs{fixedSize = vec2(size, size)}

        number.grid = self.grid

        self.ui.numbers:add(number)
    end
    self.ui.numbers:add(Button('0', callback(self, self.enter_number))
        :attribs{fixedSize = vec2(size, size)})
end

function AppSudoku:enter_number(ui_number)
    if self.ui.numbers.ui_cell and not self.ui.numbers.ui_cell.system then
        local cell = self.grid:cell(self.ui.numbers.ui_cell.i, self.ui.numbers.ui_cell.j)

        if cell ~= nil and not cell.system then
            local number = tonumber(ui_number.label)
            self.grid:set(self.ui.numbers.ui_cell.i, self.ui.numbers.ui_cell.j, number, false)
            self.grid:check_grid()

            self.grid:save()
        end
    end
end

function AppSudoku:update(dt)
    if self.grid:resolved() and not self.grid.resolvedNotified then
        self.grid.resolvedNotified = true
        self.pushScene(Dialog('Win'))
    end
end

function AppSudoku:options()
    local dialog = Dialog()
    dialog.scene:add(
        CheckBox("Show possibilities"):bind(self, 'showPossibilities'))

    self:pushScene(dialog)
end

function AppSudoku:toggleShowPossibilities()
    self.showPossibilities = not self.showPossibilities
    saveProjectData('showPossibilities', self.showPossibilities)
end
