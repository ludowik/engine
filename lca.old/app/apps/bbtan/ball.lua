class('Ball', Item)

function Ball:init(size)
    Item.init(self, 4, 1)
    
    self.size = vector(
        size,
        size)
    
    self.bullet = true
    self.linearVelocity = vector()

    self:image()
end

function Ball:image()
    self.image = image(
        self.size.x * 2 + 2,
        self.size.y * 2 + 2)

    setContext(self.image)

    fill(white)
    noStroke(gray)
    
    circleMode(CENTER)
    circle(
        self.size.x+1,
        self.size.y+1,
        self.size.x)

    setContext()
end

function Ball:draw()
    local x, y = math.ceil(self.position.x), math.ceil(self.position.y)
    
    spriteMode(CENTER)
    sprite(self.image, x, y)
end
