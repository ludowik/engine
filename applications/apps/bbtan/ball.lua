class('Ball', Item)

function Ball:init(size)
    Item.init(self, 4, 1)
    
    self.id = id('ball')
    
    physics:add(self, DYNAMIC, CIRCLE, size)
    
    self.size = vec2(
        size,
        size)
    
    self.body.bullet = true
    self.body.linearVelocity = vec2()
    self.body.linearDamping = 0

    self.body.restitution = 1
    self.body.friction = 0
    
    self.body.categories = {1}
    self.body.mask = {0}
    
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
    
    fill(red)
    
    textMode(CENTER)
    text(self.id, x, y)
end
