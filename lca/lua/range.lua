function range(_start, _stop, _step)
    local step = _step or 1
    local stop = _stop or _start
    local start = _stop and _start or 1
    
    local i = start - step
    return function ()
        i = i + step
        if i <= stop then
            return i
        end
    end
end
