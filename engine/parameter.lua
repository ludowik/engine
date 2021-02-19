class 'Parameter'

function Parameter:init()
    self:release()
end

function Parameter:release()
    self.ui = MenuBar()
    self.ui.alignment = 'right'
end

function Parameter.add(param)
    for i,v in env.parameter.ui:iter() do
        if v.label == param.label then
            return
        end
    end

    env.parameter.ui:add(param)
end

function Parameter:update(dt)
    env.parameter.ui:update(dt)
end

function Parameter:draw()
    noLight()

    pushMatrix()
    pushStyle()
    
    resetMatrix(true)
    resetStyle(NORMAL, true, false)

    ortho()

    self.ui:layout()
    self.ui:draw()

    popStyle()
    popMatrix()
end

function Parameter:touched(touch)
    return env.parameter.ui:touched(touch)
end

function Parameter:mouseWheel(touch)
    return env.parameter.ui:mouseWheel(touch)
end

function Parameter.default(name, min, max, default, notify)
    local value = loadstring('return env.'..name)()

    if value == nil or value == _G[name] then
        default = default or min
        if default ~= nil then
            _G.__value__ = default
            loadstring('env.'..name..'=_G.__value__')()
            if notify then
                notify(default)
            end
        end
    end
end

function Parameter.watch(label, expression)
    env.parameter.add(Expression(label, expression))
end

function Parameter.text(var, default, notify)
    default = default or ""

    env.parameter.default(var, nil, nil, default, notify)
    env.parameter.add(Label(var))
end

function Parameter.boolean(var, default, notify)
    default = default or false

    env.parameter.default(var, nil, nil, default, notify)
    env.parameter.add(CheckBox(var, default, notify))
end

function Parameter.integer(var, min, max, default, notify)
    min = min or 0
    max = max or 10
    default = default or min or 0

    env.parameter.default(var, min, max, default, notify)
    env.parameter.add(Slider(var, min, max, default, true, notify))
end

function Parameter.number(var, min, max, default, notify)
    min = min or 0
    max = max or 1
    default = default or min or 0

    env.parameter.default(var, min, max, default, notify)
    env.parameter.add(Slider(var, min, max, default, false, notify))
end

function Parameter.color(var, default, notify)
    env.parameter.default(var, _, _, default, notify)
    env.parameter.add(ColorPicker(var, default, notify))
end

function Parameter.action(label, action)
    env.parameter.add(Button(label, action))
end

function Parameter.link(label, url)
    env.parameter.add(Button(label, 
            function ()
                openURL(url or label)
            end))
end
