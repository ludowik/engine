class 'parameter'

function parameter.watch()  
end

function parameter.integer(name, min, max, default, callback)
    _G.env[name] = default
end

function parameter.number(name, min, max, default, callback)
    _G.env[name] = default
end

function parameter.action()
end
