function callback(object, f)
    return function (...)
        if f then
            f(object, ...)
        elseif object then
            object(...)
        end
    end
end
