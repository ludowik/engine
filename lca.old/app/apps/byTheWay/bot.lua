    -- Bot

Bot = class('bot')

Bot.MAX_SPEED = 500

function Bot:init(x, y)
    self.position = vec3(x, y)
    
    local direction = vec2(math.random(-1,1), math.random(-1,1)):normalize()
    local speed = 200
    
    self.linearVelocity = direction * speed
    
    self.r = 10
end

function Bot:_tostring()
    return 
        "X ="..math.floor(self.position.x/1)..
        "Y ="..math.floor(self.position.y/1)
end

function Bot:draw()
    theme("bot")
    ellipse(self.position.x, self.position.y, self.r*2)
end

function Bot:update(dt)
    if self.linearVelocity:len() == 0 then return end
    
    self.position = self.position + self.linearVelocity * dt
    
    self.linearVelocity = self.linearVelocity - self.linearVelocity:normalize() * 0.1 * dt

    if self.linearVelocity:len() < 0 then
        self.linearVelocity = vec2()
    end
end

local distAttraction = 20
function Bot:applyWay(way)
    local lenMin = math.huge
    
    local nearSegment = nil
    for i,f in ipairs(way.points) do
        local len = (f - self.position):len()
        if len < lenMin then
            lenMin = len
            nearSegment = i
        end
    end
    
    if lenMin <= distAttraction and nearSegment ~= #way.points then
        local force = 1 - lenMin / distAttraction
        local f = way.points[nearSegment]
        local t = way.points[nearSegment+1]
        local ft = (t - f):normalize()
        local direction = (t - self.position):normalize()
        self:applyForce(ft * force)
        self:applyDirection(direction)
    end      
end

function Bot:limitSpeed(speedMax)
    speedMax = speedMax or Bot.MAX_SPEED
    
    local direction = self.linearVelocity:normalize()
    local speed = math.min(self.linearVelocity:len(), speedMax)
    self.linearVelocity = direction * speed
end

function Bot:applyForce(force)
    self.linearVelocity = self.linearVelocity + force
    self:limitSpeed()
end

function Bot:applyDirection(force)
    self.linearVelocity = (self.linearVelocity:normalize() + force):normalize() * self.linearVelocity:len()
end
