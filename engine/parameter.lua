class 'parameter'


function parameter.default(name, min, max, default, notify)
    local value = loadstring('return '..name)()

    if value == nil then
        default = default or min
        if default ~= nil then
            _G.__value__ = default
            loadstring(name..'=_G.__value__')()
            if notify then
                notify(default)
            end
        end
    end
end

function parameter.watch()  
end

function parameter.boolean(name, default, notify)
    parameter.default(name, false, true, default, notify)
end

function parameter.integer(name, min, max, default, notify)
    parameter.default(name, min, max, default, notify)
end

function parameter.number(name, min, max, default, notify)
    parameter.default(name, min, max, default, notify)
end

function parameter.text(name, default, notify)
    parameter.default(name, '', '', default, notify)
end

function parameter.color(name, default, notify)
    parameter.default(name, black, white, default, notify)
end

function parameter.action()
end

function parameter.add()
end
