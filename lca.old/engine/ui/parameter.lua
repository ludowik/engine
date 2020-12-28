parameter = {
    --infos = Node()
}

function parameter.clear()
    parameter.infos = MenuBar()
    parameter.infos.textSize = 12

    params = parameter.infos
end

function UIParameter()
    local group = UIScene()
    group.outerMarge = 0
    group.borderWidth = 0
    return group
end

function parameter.text(label, txt)
    local group = UIParameter()
    parameter.infos:add(group)
    group:add(
        Label(label),
        Editor(txt))
end

function parameter.watch(label, expression)
    local group = UIParameter()
    parameter.infos:add(group)
    group:add(
        Label(label),
        Expression(expression or label))
end

function parameter.boolean(var, default)
    local group = UIParameter()
    parameter.infos:add(group)
    group:add(
        Label(var),
        CheckBox(var, default))
end

function parameter.color(txt, clr, callback)
    local bind = Bind():bind(txt, clr)
    local tempVar = 'temp' .. id('temp')
    parameter.infos:add(Slider(tempVar, 0, 255, 128, true, function (value)
                bind:setValue(hsl(value/255, 0.5, 0.5))
                callback(bind:getValue())
            end))
end

function parameter.number(var, min, max, default, callback)
    parameter.infos:number(var, min, max, default, callback)
end

function parameter.integer(var, min, max, default, callback)
    parameter.infos:add(Slider(var, min, max, default, true, callback))
end

function parameter.action(label, callback)
    return parameter.infos:action(label, callback)
end

function parameter.update(dt)
    parameter.infos:update(txt)
end

function parameter.draw(self, x, y)
    fontSize(12)

    parameter.infos:layout(x, y or (HEIGHT-34))
    parameter.infos:draw()
end

function parameter.touched(touch)
    parameter.infos:touched(touch)
end
