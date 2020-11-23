class 'Action'

function Action:init(description, f)
    self.description = description
    self.f = f
end

function Action:__call(...)
    return self.f(...)
end

function Action:__tostring(...)
    return self.description
end

function callback(...) -- description, object, f, ...)
    --if not description and not object and not f then return end

    local args = args(...)
    
    local description, object, f = args:get(
        {'string', '???'},
        {'table', niltable},
        {'function', nilf})
    
    if object == niltable then
        object = nil
    end

--    if typeof(description) == 'action' then
--        return description
--    end
    
--    if type(description) == 'function' then
--        args = Table{object, f, ...}
--        f = description
--        object = nil
--        description = '???'

--    elseif type(description) == 'table' and type(object) == 'function' then
--        args = Table{f, ...}
--        f = object
--        object = description
--        description = '???'

--    elseif type(description) == 'string'  and type(object) == 'table' and type(f) == 'function' then
--        args = Table{...}

--    else
    if not f then
        error('bad parameters')
    end

    return Action(description, function (...)
            local args2 = Table{...} + args
            if object then
                f(object, unpack(args2))
            else
                f(unpack(args2))
            end
        end)
end
