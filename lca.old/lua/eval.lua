local temp = '__temp__'
local tempEqual = '__temp__ ='

function evalExpression(expression)
    return evalVariable(temp, tempEqual..expression)    
end

function evalVariable(variable, source)
    return evalCode(source..NL.."return "..variable)
end

function evalCode(source)
    if source then
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
end

function value(value, default)
    if value == nil then
        return default
    end
    return value
end

ut:add('eval.value', function (lib)
        lib:assert(value(5) == 5)
        lib:assert(value(6, 5) == 6)
        lib:assert(value(nil, 5) == 5)
        lib:assert(value() == nil)
    end)
