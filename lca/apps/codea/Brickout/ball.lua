----------------
-- Ball Class --
----------------

Ball = class()

function Ball:init()
    self.pos = vec2(WIDTH / 2, 71)
    self.trailPos = vec2()
    self.radius = 10
    self.vel = vec2(0, 7)
end

function Ball:draw()
    local alpha = 255
    fill(253, 255, 0, alpha)
    noStroke()
    ellipse(self.pos.x, self.pos.y, 2 * self.radius)

    -- Draw a trail
    self.trailPos:set(self.pos):sub(self.vel)
    if ballIsMoving == true then
        for i = 1,5 do
            alpha = alpha / 2
            fill(253, 255, 0, alpha)
            ellipse(self.trailPos.x, self.trailPos.y, 2 * self.radius)
            self.trailPos:sub(self.vel)
        end
    end
end

function Ball:update()
    self.pos:add(self.vel)

    if (self.pos.x + self.radius) >= WIDTH then
        self.pos.x = WIDTH - self.radius
        self.vel.x = -self.vel.x
        sound(SOUND_JUMP)
        
    elseif (self.pos.x - self.radius) <= 0 then
        self.pos.x = self.radius
        self.vel.x = -self.vel.x
        sound(SOUND_JUMP)
        
    elseif (self.pos.y + self.radius) >= HEIGHT then
        self.pos.y = HEIGHT - self.radius
        self.vel.y = -self.vel.y
        sound(SOUND_JUMP)
        
    elseif (self.pos.y - self.radius) <= 0 then
        self.pos.y = self.radius
        self.vel.y = -self.vel.y
        sound(SOUND_EXPLODE)
        return false
    end
    return true
end

function Ball:left()
    return self.pos.x - self.radius
end

function Ball:right()
    return self.pos.x + self.radius
end

function Ball:top()
    return self.pos.y + self.radius
end

function Ball:bottom()
    return self.pos.y - self.radius
end