class('Bonus', Item)

function Bonus:init(i, j)
    Item.init(self, i, j)
        
    self.size = vector(
        CELL_SIZE / 2,
        CELL_SIZE / 2)
    
    self.sensor = true
end

function Bonus:draw()
    noFill()
    
    stroke(yellow)
    strokeWidth(4)
    
    circleMode(CENTER)
    circle(self.position.x, self.position.y, self.size.x/2)
    
    strokeWidth(3)
    
    line(
        self.position.x-self.size.x/4, self.position.y, 
        self.position.x+self.size.x/4, self.position.y)

    line(
        self.position.x, self.position.y-self.size.y/4,
        self.position.x, self.position.y+self.size.x/4)
end
