-- This is our basic tweenable object, it has the following properties:
--
-- x, y - the x and y position
-- size - the diameter
-- originalState - the original values, so we can reset the object

Circle = class()

function Circle:init(x, y, size)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.size = size or 100
    
    self.originalState = { x = self.x, 
                           y = self.y, 
                           size = self.size }
end

function Circle:reset()
    self.x = self.originalState.x
    self.y = self.originalState.y
    self.size = self.originalState.size
end

function Circle:draw()
    pushStyle()
    
    fill(180,10,30)
    
    ellipse(self.x, self.y, self.size)
    
    popStyle()
end

