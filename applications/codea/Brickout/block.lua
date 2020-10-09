-----------------
-- Block Class --
-----------------

Block = class()

function Block:init(x, y, col)
    self.mesh = mesh()
    self.pos = vec2(x, y)
    self.size = vec2(60,30)
    self.colour = col

    self.mesh:addRect( self.pos.x, self.pos.y,
        self.size.x, self.size.y )

    local dark = self.colour:mix( color(0,0,0), 0.8 )

    self.mesh:color( 1, self.colour )
    self.mesh:color( 2, dark )
    self.mesh:color( 3, dark )
    self.mesh:color( 4, self.colour )
    self.mesh:color( 5, dark )
    self.mesh:color( 6, self.colour )

    -- Highlight
    local idx = self.mesh:addRect( self.pos.x,
        self.pos.y + self.size.y * 0.5 - 1,
        self.size.x, 2 )

    self.mesh:setRectColor( idx, 255,255,255,90 )
end

function Block:draw()
    fill(self.colour)
    noStroke()
    rectMode(CENTER)
    --rect(self.pos.x, self.pos.y, self.size.x, self.size.y)
    self.mesh:draw()
end

function Block:collide(ball)
    if (ball:left() <= self:right() and
        ball:right() >= self:left() and
        ball:top() >= self:bottom() and
        ball:bottom() <= self:top())
    then
        sound(SOUND_BLIT)
        if ball.pos.y <= self:top() and ball.pos.y >= self:bottom() then
            ball.vel.x = -ball.vel.x
        else
            ball.vel.y = -ball.vel.y
        end
        return true
    end
    return false
end

function Block:left()
    return self.pos.x - self.size.x / 2
end

function Block:right()
    return self.pos.x + self.size.x / 2
end

function Block:top()
    return self.pos.y + self.size.y / 2
end

function Block:bottom()
    return self.pos.y - self.size.y / 2
end