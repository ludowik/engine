class('Cell', UI)

function Cell:init(c, r, size, state)
    UI.init(self)
    
    self.c = c
    self.r = r
    
    self.state = state
     
    self.position = vec3((c - 1), (r - 1)) * size --+ vec3(size / 2, size/2)
    self.absolutePosition = self.position
    
    self.size = vec3(size, size)
end

function Cell:draw(grid)
    local x, y = self.position.x, self.position.y
    
    circleMode(CORNER)
    
    if self.state then
        strokeWidth(2)
        stroke(255)
        
        local color = hsl(self.state*30/360, .3, .6)
        fill(color)
        
        circle(x, y, self.size.x/2)
        
    elseif grid.selectable then
        strokeWidth(0.5)
        stroke(255)
        
        if self.select then
            fill(grid.selectColor)
        else
            noFill()
        end
        
        circle(x, y, self.size.x/2)
    end
end
