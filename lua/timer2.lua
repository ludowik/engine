local __round = math.round

Timer = class('timer')

function Timer:init()
    self.ellapsedTime = 0
    
    self.t1 = self:getTime()
    self.t2 = self.t1
    
    self.frames = 0    
end

function Timer:getTime()
    return system.getTicks() / 1000
end

function Timer:step()
    local delay = self:deltaTime()
    self.t1 = self.t2
    
    self.frames = self.frames + 1    
    
    self.ellapsedTime = self.ellapsedTime + delay
    
    return delay
end

function Timer:deltaTime()
    self.t2 = self:getTime()
    return self.t2 - self.t1
end

function Timer:fps()
    local fps = __round(1 / (self.ellapsedTime / self.frames))
    return fps
end

function Timer:sleep(...)
    system.sleep(...)
end
