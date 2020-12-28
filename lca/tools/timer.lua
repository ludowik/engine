class('Timer')

function Timer.setup()
    Timer.events = {}
end

function Timer.add(name, delay, f)
    Timer.events[name] = {
        name = name,
        delay = delay,
        f = f
    }
end

function Timer.find(name)
    return Timer.events[name]
end

function Timer.stop(name)
    local timer = Timer.find(name)
    if timer then
        timer.status = 'dead'
        Timer.events[name] = nil
    end
end

function Timer:update(dt)
    for i,event in pairs(Timer.events) do
        if event.status == nil then
            event.delay = event.delay - dt
            if event.delay < 0 then
                event.status = 'dead'
                event.f()
            end
        end
    end
end

class('Chrono')

function Chrono:start()
    self.startTime = system.getTime()
end

function Chrono:stop()
    self.stopTime = system.getTime()
end

function Chrono:delay()
    return self.stopTime - self.startTime
end
