function decorate(functionName, decorator, object)
    object = object or _G

    local decoratedFunction = object[functionName]
    object[functionName] = function (...)
        return decorator(decoratedFunction, ...)
    end
end

decorate('ipairs', function (f, t)
        return f(t or {})
    end)
