class 'Log'

function Log.setup()
    save('res/data/log', '', 'w')
end

decorate('print', 
    function (f, str, ...)
        assert(str and str ~= 'none')
        
        str = tostring(str)
        f(str, ...)

        save('res/data/log', str..NL, 'a')
    end)

log = print

decorate('assert',
    function (exp, message, level)
        if not exp then
            error(message or 'error', level and (level+1) or 2)
        end
    end)

function warning(test, ...)
    if not test then
        warn(getFunctionLocation(...))
    end
end

function functionNotImplemented()
    print(getFunctionLocation('not implemented :'))
end
