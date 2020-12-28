function typeOf(t)
    local type = type(t)
    if type == 'table' then 
        return t.className or 'table'
    end
    return type
end
