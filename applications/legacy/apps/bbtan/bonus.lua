class('Bonus', Item)

function Bonus:init(i, j)
    Item.init(self, i, j)
            
    self.size = vec2(
        CELL_SIZE / 2,
        CELL_SIZE / 2)
    
    physics:add(self, DYNAMIC, CIRCLE, self.size.x / 2)
    
    self.body.sensor = true
    self.body.restitution = 1
    self.body.friction = 0
    
    self.body.categories = {0}
    self.body.mask = {1}
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
