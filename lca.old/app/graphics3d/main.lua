function setup()
    createUI()

    parameter.watch('config.light')

    setModel(Model.load('smoothMonkey0'):normalize())

    app.scene.camera = camera(2, 2, 2)
end

function createUI()
    createUIObjects()
    createUILight()
end

function createUILight(reset)
    local menuLights = menuLights or ToolBar()
    menuLights:clear()

    menuLights:add(Button('light', function (btn)
                config.light = not config.light
            end))

    menuLights:add(Button('reset', function (btn)
                Light.reset()
                createUILight(false)
            end))

    for i,light in pairs(lights) do
        menuLights:add(CheckBox(i):bind(lights[i], 'on'))
    end

    if reset == nil then
        app.ui:add(menuLights)
    end
end

function setModel(model)
    app.scene:clear()

    app.scene:add(MeshObject(model:normalize()))
    model:setColors(white)
end

function createUIObjects()
    local menuObjects = menuObjects or ToolBar()
    menuObjects:clear()

    menuObjects:add(Button('plane'      , function (btn) setModel(Model.plane()) end))
    menuObjects:add(Button('box'        , function (btn) setModel(Model.box()) end))
    menuObjects:add(Button('sphere'     , function (btn) setModel(Model.sphere()) end))
    menuObjects:add(Button('pyramid'    , function (btn) setModel(Model.pyramid()) end))
    menuObjects:add(Button('tetrahedron', function (btn) setModel(Model.tetrahedron()) end))

    menuObjects:add(Button('teapot'   , function (btn) setModel(Model.load(btn.id)) end))
    menuObjects:add(Button('trumpet'  , function (btn) setModel(Model.load(btn.id)) end))
    menuObjects:add(Button('airboat'  , function (btn) setModel(Model.load(btn.id)) end))
    menuObjects:add(Button('roi'      , function (btn) setModel(Model.load(btn.id)) end))
    menuObjects:add(Button('shuttle'  , function (btn) setModel(Model.load(btn.id)) end))
    menuObjects:add(Button('dragon'   , function (btn) setModel(Model.load(btn.id)) end))
    menuObjects:add(Button('musclecar', function (btn) setModel(Model.load(btn.id)) end))

    menuObjects:add(Button("rubyk's cube", function (btn)
                local object = Node()
                for x=1,3 do
                    for y=1,3 do
                        for z=1,3 do
                            object:add(MeshObject(
                                    Model.box(),
                                    color.random()
                                )
                                :attribs{position=vector(x-1.5, y-1.5, z-1.5)})
                        end
                    end
                end
                setModel(object)
            end))

    app.ui:add(menuObjects)
end

function update(dt)
    app.scene:update(dt)
    app.ui:update(dt)
end

function keypressed(key)
    if key == 'up' then
        camera():zoom(0, 10)
    elseif key == 'down' then
        camera():zoom(0, -10)
    end
end
