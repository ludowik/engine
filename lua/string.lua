NL = '\n'

string.__format = string.format

function string.format(str, args, ...)
    if type(args) == 'table' then
        for k,v in pairs(args) do
            str = str:gsub('{'..k..'}', v)
        end
        return str
    end
    
    return string.__format(str, args, ...)
end
