parameter = class('Parameter')

function Parameter.setup()
    parameter.release()
end

function Parameter.release()
    parameter.ui = MenuBar()
end

function Parameter.add(...)
    parameter.ui:add(...)
end

function Parameter:update(dt)
    parameter.ui:update(dt)
end

function Parameter:draw()
    noLight()
    resetMatrix(true)
--    ortho()
    
    parameter.ui:layout()
    parameter.ui:draw()
end

function Parameter:touched(touch)
    return parameter.ui:touched(touch)
end

function Parameter.default(var, min, max, default, notify)
    local value = loadstring('return '..var)()

    if value == nil and default then
        loadstring(var..'='..convert(default))()

        if notify then
            notify(default)
        end
    end
end

function Parameter.watch(label, expression)
    parameter.ui:add(Expression(expression or label))
end

function Parameter.text(var, default, notify)
    default = default or ""

    Parameter.default(var, nil, nil, default, notify)
    parameter.ui:add(Label(var))
end
    
function Parameter.boolean(var, default, notify)
    default = default or false

    Parameter.default(var, nil, nil, default, notify)
    parameter.ui:add(CheckBox(var, default, notify))
end

function Parameter.integer(var, min, max, default, notify)
    min = min or 0
    max = max or 10
    default = default or min or 0

    Parameter.default(var, min, max, default, notify)
    parameter.ui:add(Slider(var, min, max, default, true, notify))
end

function Parameter.number(var, min, max, default, notify)
    min = min or 0
    max = max or 1
    default = default or min or 0

    Parameter.default(var, min, max, default, notify)
    parameter.ui:add(Slider(var, min, max, default, false, notify))
end

function Parameter.color(var, default, notify)
    Parameter.default(var, _, _, default, notify)
    parameter.ui:add(ColorPicker(var, default, notify))
end

function Parameter.action(label, action)
    parameter.ui:add(Button(label, action))
end
