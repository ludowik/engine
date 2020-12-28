function evalExpression(expression)
    local src = 
    "__temp__ = "..expression..NL..
    "return __temp__"
    return evalCode(src)
end

function evalCode(source)
    assert(source)

    local f, err = loadstring(source)
    if f then
        local status, res = pcall(f)
        if status then
            return res
        end
    else
        print(err)
    end
end

function value(value, default)
    if value == nil then
        return default
    end
    return value
end

class('Eval').test = function ()
    assert(value(5) == 5)
    assert(value(6, 5) == 6)
    assert(value(nil, 5) == 5)
    assert(value() == nil)
end
