class('UI_grid', UIScene)

function UI_grid:init(grid)
    UIScene.init(self)

    self.grid = grid

    self:setLayoutFlow(Layout.row)
    
    self.outerMarge = 0
    self.innerMarge = 0

    for j = 1, grid.n do
        local ui_line = UIScene()
        ui_line:setLayoutFlow(Layout.column)
        
        ui_line.outerMarge = 0
        ui_line.innerMarge = 0

        self:add(ui_line)

        for i = 1, grid.n do
            ui_line:add(UI_cell(grid, i, j))
        end
    end
end

function UI_grid:draw()
    Node.draw(self)

    translate(self.position.x, self.position.y)

    local ui_cell = self.nodes[1].nodes[1]
    style(s3, brown, transparent, LEFT)
    
    rectMode(CORNER)

    for i = 0, 2 do
        for j = 0, 2 do
            rect(
                ui_cell.size.x * 3 * i,
                ui_cell.size.y * 3 * j, 
                ui_cell.size.x * 3,
                ui_cell.size.y * 3)
        end
    end
end
