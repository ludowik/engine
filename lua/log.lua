class 'Log'

function Log.setup()
    save(getDataPath()..'/.log', '', 'w')

    if debugging() then
        log = Log.log
        Log.logs = {}
    else
        log = nilf
    end
end

function Log.log(...)
    local str = ""
    
    local args = {...}    
    for _,v in ipairs(args) do
        str = str..tostring(v)
    end
    
    Log.logs[str] = (Log.logs[str] or 0) + 1
    
    if Log.logs[str] == 1 then
        print(str)
    end
end

output = class 'Output'

function Output:clear()
end

decorate('print',
    function (f, str, ...)
        str = tostring(str)
        assert(str ~= '96')

        f(str, ...)

        save(getDataPath()..'/.log', str..NL, 'a')
    end)

decorate('error',
    function (f, ...)
        __error__(...)
        if ios then
            ffi.C.exit(0)
        end
    end)

decorate('assert',
    function (f, exp, message, level)
        if not exp then
            error(message or 'error', level and (level+1) or 2)
        end
    end)

function warning(test, ...)
    if not test then
        print(getFunctionLocation(...))
    end
end

function functionNotImplemented()
    print(getFunctionLocation('not implemented :'))
end
