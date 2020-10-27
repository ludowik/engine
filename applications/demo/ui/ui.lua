function setup()
    parameter.watch('parameter')
    parameter.watch('yesno')

    parameter.watch('isButtonDown(BUTTON_LEFT)')
    parameter.watch('isButtonDown(BUTTON_RIGHT)')

    parameter.watch('Couleur')

    parameter.boolean('MyBoolean', true)

    app.uiScene = MenuBar(0, HEIGHT)
    app.uiScene.alignment = 'v-center,h-center'

    app.uiScene:add(Label('Label'))
    app.uiScene:add(Button('Button'))
    app.uiScene:add(ButtonImage('documents:joconde'))
    app.uiScene:add(ButtonColor(red))
    app.uiScene:add(ColorPicker('Couleur', red, function (clr) print('new color : '..tostring(clr)) end))
    app.uiScene:add(CheckBox('yesno'))
    app.uiScene:add(Editor('Editor'))

    parameter.integer('nbGroups' , 1, 10, 2, reset)
    parameter.integer('nbButtons', 1, 10, 2, reset)

    parameter.integer('gridSize' , 2, 6, 2, reset)

    parameter.integer('env.app.uiScene.innerMarge' , 0, 20, 5, reset)
    parameter.integer('env.app.uiScene.outerMarge' , 0, 20, 5, reset)
end

function reset()
    nbGroups = nbGroups or 1
    nbButtons = nbButtons or 1

    gridSize = gridSize or 2

    local gridScene = UIScene(Layout.grid, gridSize)
    app.scene = UIScene(Layout.column):add(
        app.uiScene,
        gridScene)

    app.scene.alignment = 'v-center,h-center'

    for i=1,nbGroups do
        local node = UIScene(Layout.grid, gridSize)
        gridScene:add(node)

        bgColor = color(i/4, 0, 0)

        for j=1,nbButtons do
            node:add(Button(i..'.'..j):attribs{
                    bgColor = bgColor
                })
        end
    end
end
