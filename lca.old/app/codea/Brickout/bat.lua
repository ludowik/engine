---------------
-- Bat Class --
---------------

Bat = class()

function Bat:init()
    self.pos = vec2(350, 50)
    self.size = vec2(85, 20)
end

function Bat:draw()
    fill(255, 255, 255, 255)
    noStroke()
    rectMode(CENTER)
    ellipse(self.pos.x - self.size.x / 2, self.pos.y, 22)
    ellipse(self.pos.x + self.size.x / 2, self.pos.y, 22)
    rect(self.pos.x, self.pos.y, self.size.x, self.size.y)
end

function Bat:collide(ball)
    if ball:left() <= self:right() and
       ball:right() >= self:left() and
       ball:top() >= self:bottom() and
       ball:bottom() <= self:top() then
        sound(SOUND_JUMP)
        ball.vel.y = -ball.vel.y
        -- change the x velocity depending on where the ball hit the bat
        ball.pos.y = self:top() + ball.radius
        pos = ball.pos.x - self.pos.x
        ball.vel.x = pos / 10
        return true
    end
    return false
end

function Bat:left()
    return self.pos.x - self.size.x / 2
end

function Bat:right()
    return self.pos.x + self.size.x / 2
end

function Bat:top()
    return self.pos.y + self.size.y / 2
end

function Bat:bottom()
    return self.pos.y - self.size.y / 2
end