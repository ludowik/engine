class('Callback')

function Callback:init(...)
    local args = {...}
    
    local i =1    
    if type(args[i]) == 'table' then
        self.object = args[i]
        i = i + 1
    else
        self.object = nil
    end
    
    if type(args[i]) == 'function' then
        self.f = args[i]
        i = i + 1
    else
        self.f = nilf
    end
end

function Callback:call(...)
    if self.object then
        self.f(self.object, ...)
    else
        self.f(...)
    end
end

function callback(f, ...)
    if type(f) == 'table' and f.className == 'callback' then
        return f
    end
    return Callback(f, ...)
end
