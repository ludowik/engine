log = print

function warning(test, ...)
    if not test then
        log(getFunctionLocation(...))
    end
end

function functionNotImplemented(functionName)
    print(getFunctionLocation('functionNotImplemented:'..functionName))
end
