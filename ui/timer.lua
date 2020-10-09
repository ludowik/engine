class('UITimer', UI)

function UITimer:init(label, time, callback)
    UI.init(self)

    self.time = time
    self.delay = time

    self.callback = callback

    self.active = false
end

function UITimer:getLabel()
    if self.active then
        return tostring(tointeger(self.time))
    else
        return ''
    end
end

function UITimer:update(dt)
    if self.active then
        if self.time > 0 then
            self.time = self.time - dt
            if self.time < 0 then
                self.time = self.delay
                self.active = false
                if self.callback then
                    self.callback()
                end
            end
        end
    end
end

function UITimer:reset()
    self.active = false
end

function UITimer:start()
    self.active = true
    self.time = self.time + 1
end
