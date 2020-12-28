function setup()
    createUI()

    local modelName = readProjectData('modelName', 'teapot')
    setModelName(modelName)

    app.scene.camera = camera(2, 2, 2)

    parameter.watch('#model.vertices')
end

function createUI()
    createUIObjects()
    createUILight()
end

function createUILight(reset)
    local menuLights = menuLights or MenuBar()
    menuLights:clear()

    menuLights:add(Button('light',
            function (btn)
                light(not light())
            end))

    menuLights:add(Button('reset',
            function (btn)
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

function setModelName(modelName)
    local model, keepColor = nil, false
    
    if modelName == 'plane' then
        model = Model.plane()

    elseif modelName == 'box' then
        model = Model.box() 

    elseif modelName == 'sphere' then
        model = Model.sphere()

    elseif modelName == 'planet' then
        model = Model.sphere() 
        model.shader = Shader.shaders['terrain']

    elseif modelName == 'pyramid' then
        model = Model.pyramid() 

    elseif modelName == 'tetrahedron' then
        model = Model.tetrahedron() 

    elseif modelName == "rubyk's cube" then
        model = Mesh()
        for x=1,3 do
            for y=1,3 do
                for z=1,3 do
                    Model.add(model, Model.box(x-2, y-2, z-2, 1, 1, 1):setColors(color.random()))
                end
            end
        end
        keepColor = true
        
    else
        model = Model.load(modelName, true) or Model.box()
            
    end
    
    setModel(model:normalize(), keepColor)
        
    saveProjectData('modelName', modelName)
end

function setModel(model, keepColor)
    app.model = model
    
    app.scene:clear()
    app.scene:add(MeshObject(model))

    if not keepColor then
        model:setColors(white)
    end

    return model
end

function createUIObjects()
    local menuObjects = menuObjects or MenuBar()
    menuObjects:clear()

    menuObjects:add(Expression('#app.model.vertices'))
    menuObjects:add(Expression('#app.model.texCoords'))
    menuObjects:add(Expression('#app.model.colors'))
    menuObjects:add(Expression('#app.model.normals'))
    menuObjects:add(Expression('app.model.shader.name'))
    
    local function changeModel(btn)
        setModelName(btn.label)
    end

    menuObjects:add(Button('plane'      , changeModel))
    menuObjects:add(Button('box'        , changeModel))
    menuObjects:add(Button('sphere'     , changeModel))
    menuObjects:add(Button('pyramid'    , changeModel))
    menuObjects:add(Button('tetrahedron', changeModel))

    menuObjects:add(Button('planet'     , changeModel))
    
    menuObjects:add(Button('teapot'     , changeModel))
    menuObjects:add(Button('trumpet'    , changeModel))
    menuObjects:add(Button('airboat'    , changeModel))
    menuObjects:add(Button('roi'        , changeModel))
    menuObjects:add(Button('shuttle'    , changeModel))
    menuObjects:add(Button('dragon'     , changeModel))
    menuObjects:add(Button('musclecar'  , changeModel))

    menuObjects:add(Button("rubyk's cube", changeModel))

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
