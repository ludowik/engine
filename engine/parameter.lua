class 'parameter'

function parameter.setup()
    parameter.release()
end

function parameter.release()
    parameter.ui = MenuBar()
end

function parameter.add(...)
    parameter.ui:add(...)
end

function parameter:update(dt)
    parameter.ui:update(dt)
end

function parameter:draw()
    noLight()
    resetMatrix(true)
--    ortho()
    
    parameter.ui:layout()
    parameter.ui:draw()
end

function parameter:touched(touch)
    return parameter.ui:touched(touch)
end

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

function parameter.watch(label, expression)
    parameter.ui:add(Expression(expression or label))
end

function parameter.text(var, default, notify)
    default = default or ""

    parameter.default(var, nil, nil, default, notify)
    parameter.ui:add(Label(var))
end
    
function parameter.boolean(var, default, notify)
    default = default or false

    parameter.default(var, nil, nil, default, notify)
    parameter.ui:add(CheckBox(var, default, notify))
end

function parameter.integer(var, min, max, default, notify)
    min = min or 0
    max = max or 10
    default = default or min or 0

    parameter.default(var, min, max, default, notify)
    parameter.ui:add(Slider(var, min, max, default, true, notify))
end

function parameter.number(var, min, max, default, notify)
    min = min or 0
    max = max or 1
    default = default or min or 0

    parameter.default(var, min, max, default, notify)
    parameter.ui:add(Slider(var, min, max, default, false, notify))
end

function parameter.color(var, default, notify)
    parameter.default(var, _, _, default, notify)
    parameter.ui:add(ColorPicker(var, default, notify))
end

function parameter.action(label, action)
    parameter.ui:add(Button(label, action))
end
