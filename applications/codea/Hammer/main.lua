--# Main
-- Hammer Jump

-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(FULLSCREEN)

    tile = HEIGHT/8

    player = Player()
    block = Block()

    makeTutorial()

    fontSize(30)
    textMode(CORNER)
    score = 0
    shards = {}
    parameter.watch("fps")
end

local fade

-- This function gets called once every frame
function draw()
    fps = 1/DeltaTime
    background(40, 40, 50)
    strokeWidth(5)

    text("Score: "..score,30,HEIGHT-50)

    noTint()
    -- sprite("Dropbox:Hammer",WIDTH/2,HEIGHT/2)

    if fade > 0 then
        tint(255, 255, 255, fade)
        sprite(tutorial,WIDTH/2,HEIGHT/2)
        fade = fade - 0.3
    end

    player:draw()
    block:draw()

    pushStyle()
    noFill()
    strokeWidth(5)
    stroke(180, 183, 221, 255)
    line(0,tile,WIDTH,tile)
    line(0,tile*3,WIDTH,tile*3)
    line(0,tile*5,WIDTH,tile*5)
    popStyle()

    for i, s in pairs(shards) do
        if s.body then s:draw() end
    end
end

function touched(touch)
    player:touched(touch)
end

function keyboard(key)
    player:keyboard(key)
end

function makeTutorial()
    tutorial = image(WIDTH,HEIGHT)
    setContext(tutorial)
    strokeWidth(10)
    noFill()
    stroke(179, 223, 170, 118)
    ellipse(WIDTH-100,tile*5.5,70)
    ellipse(WIDTH-100,tile*3.5,70)
    ellipse(WIDTH-100,tile*1.5,70)
    ellipse(150,tile*2,140)
    textMode(CENTER)
    font("Futura-Medium")
    fontSize(20)
    fill(216, 230, 213, 118)
    text("AVOID THE FALLING BLOCK",300,tile*7)
    text("TAP HERE",150,tile*2+15)
    text("TO ATTACK",150,tile*2-15)
    text("TAP HERE",WIDTH-100,tile*5.5+55)
    text("HERE",WIDTH-100,tile*3.5+55)
    text("AND HERE",WIDTH-100,tile*1.5+55)
    text("TO JUMP",WIDTH-100,tile*0.5+15)
    text("BETWEEN LEVELS",WIDTH-100,tile*0.5-15)
    setContext()
    fade = 255
end

--# Player
Player = class()

function Player:init()
    self.x = WIDTH/2
    self.y = tile*3.5
    self.direction = 1
    self.speed = 5
    self.state = "middle"
    self.angle = 45
    self.attack = false
    self.diam = tile
    self.radius = tile/2
    self.clr = {g=255,b=255}
end

function Player:draw()
    if self.hit == true then self:hurt() end
    pushMatrix()
    pushStyle()
    self.bounce = math.sin(ElapsedTime*10)*3
    translate(self.x+self.bounce,self.y+self.bounce)
    noFill()
    strokeWidth(7)
    stroke(255,self.clr.g,self.clr.b,255)
    ellipse(0,0,tile)
    scale(-self.direction,1)
    translate(-tile*0.2,-tile*0.1)
    rotate(self.angle-self.bounce)
    line(0,0,0,tile*0.65)
    translate(0,tile*0.9)
    rect(-tile/2,-tile/4,tile,tile/2)
    popStyle()
    popMatrix()
    if self.x < tile/2 then self.direction = 1 end
    if self.x > WIDTH-tile/2 then self.direction = -1 end
    -- self.speed = self.speed * 1.0001
    self.x = self.x + self.speed * self.direction
end

function Player:touched(touch)
    if touch.state == BEGAN and touch.x >= WIDTH/2 and self.state ~= "jumping" then
        if touch.y <= tile*2 and self.state ~= "bottom" then
            self:jumpDown(tile*1.5,"bottom")
        elseif touch.y <= tile*4 and touch.y > tile*2 and self.state ~= "middle" then
            if self.state == "top" then self:jumpDown(tile*3.5,"middle")
            else self:jumpUp(tile*3.5,"middle") end
        elseif touch.y > tile*4 and self.state ~= "top" then
            self:jumpUp(tile*5.5,"top")
        end
    end

    if touch.state == BEGAN and touch.x < WIDTH/2
    and self.attack == false then
        self:hammer()
    end
end

function Player:keyboard(key)
    if self.state ~= "jumping" then
        if key == 'down' and self.state == "middle" then
            self:jumpDown(tile*1.5,"bottom")
            
        elseif key == 'down' and self.state == "top" then
            self:jumpUp(tile*3.5,"middle")
            
        elseif key == 'up' and self.state == "middle" then
            self:jumpUp(tile*5.5,"top")
            
        elseif key == 'up' and self.state == "bottom" then
            self:jumpUp(tile*3.5,"middle")
        end
    end

    if key == 'space' and self.attack == false then
        self:hammer()
    end
end

function Player:jumpUp(height,level)
    self.state = "jumping"
    tween(0.3,self,{y = height}, tween.easing.backOut,function() self.state = level end)
end

function Player:jumpDown(height,level)
    self.state = "jumping"
    tween(0.3,self,{y = height},tween.easing.backIn,function() self.state = level end)
end

function Player:hammer()
    self.attack = true
    local t1 = tween(0.1,self,{angle = -45})
    local t2 = tween(0.05,self,{angle = 90})
    local t3 = tween(0.1,self,{angle = 45})
    local t4 = tween.delay(0.01,function() self.attack = false end)
    tween.sequence(t1,t2,t3,t4)
end

function Player:hurt()
    self.hit = false
    self.clr.g = 100
    self.clr.b = 100
    tween(1,self.clr,{g=255,b=255})
end

--# Block
Block = class()

function Block:init()
    -- you can accept and set parameters here
    self.active = true
    self.width = math.ceil(tile*0.6)
    self.height = math.ceil(tile*0.5)
    self.radius = (self.width+self.height)/2
    self.x = math.random(self.width,WIDTH-self.width)
    self.y = HEIGHT + 50
    local t1 = tween(0.7,self,{y = tile*5.5},tween.easing.quartIn)
    local t2 = tween(0.7,self,{y = tile*3.5},tween.easing.quartIn)
    local t3 = tween(0.7,self,{y = tile*1.5},tween.easing.quartIn)
    local t4 = tween(0.7,self,{y = -tile*0.5},tween.easing.quartIn)
    tween.sequence(t1,t2,t3,t4)
end

function Block:draw()
    -- Codea does not automatically call this method
    pushMatrix()
    pushStyle()
    noFill()
    strokeWidth(7)
    stroke(223, 197, 173, 255)
    translate(self.x,self.y)
    if self.active == true then rect(-self.width,-self.height,self.width*2,self.height*2) end
    popStyle()
    popMatrix()
    if self.y == -self.height then self:init() end

    self.playerPos = vec2(player.x,player.y)
    self.blockPos = vec2(self.x,self.y)
    self.distance = self.playerPos:dist(self.blockPos)
    self.maxDist = self.radius + player.radius

    if self.distance < self.maxDist + player.radius and player.attack and self.active then
        if player.direction == 1 and self.x > player.x + player.radius then
            self:destroy(1,1)
            self.active = false
        elseif player.direction == -1 and self.x < player.x - player.radius then
            self:destroy(1,-1)
            self.active = false
        elseif self.distance < self.maxDist and self.active then
            player.hit = true
            self:destroy(-1,0)
            self.active = false
        end
    elseif self.distance < self.maxDist and self.active then
        player.hit = true
        self:destroy(-1,0)
        self.active = false
    end
end

function Block:touched(touch)
    -- Codea does not automatically call this method
end

function Block:destroy(points,direction)
    score = score + points
    if score < 0 then score = 0 end 
    for i = 1, 4 do
        local s = Shard(i,self.x,self.y,self.width,self.height,direction)
        table.insert(shards,s)
    end
end

--# Shard
Shard = class()

function Shard:init(info,x,y,w,h,d)
    -- you can accept and set parameters here
    self.info = info
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.dir = d

    local rand = math.random

    self.body = physics.body(CIRCLE,10)
    self.body.position = vec2(self.x,self.y)
    self.body.gravityScale = 5
    if self.dir == 1 then
        self.body.linearVelocity = vec2(rand(300,500),rand(300,500))
    elseif self.dir == -1 then
        self.body.linearVelocity = vec2(rand(-500,-300),rand(300,500))
    else
        self.body.linearVelocity = vec2(rand(-500,500),rand(300,500))
    end
    self.body.angularVelocity = rand(-50,50)
end

function Shard:draw()
    -- Codea does not automatically call this method
    pushMatrix()
    pushStyle()
    noFill()
    strokeWidth(7)
    stroke(223, 197, 173, 255)
    translate(self.body.x,self.body.y)
    if self.info == 1 then
        translate(-self.w,0)
        rotate(self.body.angle)
        line(0,-self.h,0,self.h)
    end
    if self.info == 2 then
        translate(0,-self.h)
        rotate(self.body.angle)
        line(-self.w,0,self.h,0)
    end
    if self.info == 3 then
        translate(self.w,0)
        rotate(self.body.angle)
        line(0,-self.h,0,self.h)
    end
    if self.info == 4 then
        translate(0,self.h)
        rotate(self.body.angle)
        line(-self.w,0,self.w,0)
    end
    popStyle()
    popMatrix()

    if self.body.y < 0 then
        self.body:destroy()
        self.body = nil
    end
end

function Shard:touched(touch)
    -- Codea does not automatically call this method
end