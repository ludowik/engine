class('Timer')

function Timer:init(delay, action, mode)
    self.active = true

    self.delay = delay
    self.action = action
end

function Timer:update(dt)
    if self.active then
        self.delay = self.delay - dt

        if self.delay <= 0 then
            self.active = false
            self.action()        
        end
    end
end
