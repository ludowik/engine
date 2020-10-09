function decorate(functionName, decorator, object)
    object = object or _G

    local decoratedFunction = object[functionName]
    object['__'..functionName..'__'] = decoratedFunction

    object[functionName] = function (...)
        return decorator(decoratedFunction, ...)
    end
end
