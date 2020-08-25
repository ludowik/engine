function callback(object, f, ...)
    if not object and not f then return end
    
    local args

    if type(object) == 'function' then
        args = Table{f, ...}
        f = object
        object = nil
        
    elseif type(object) == 'table' and type(f) == 'function' then
        args = Table{...}
        
    else
        error('bad parameters')
    end

    return function (...)
        local args2 = Table{...} + args
        if object then
            f(object, unpack(args2))
        else
            f(unpack(args2))
        end
    end
end
