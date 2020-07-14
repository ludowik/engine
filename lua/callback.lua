function callback(object, f, ...)
    local args1 = Table{...}
    return function (...)
        local args2 = Table{...} + args1
        if f then
            f(object, unpack(args2))
        elseif object then
            object(unpack(args2))
        end
    end
end
