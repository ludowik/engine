function lca.load()
    initConfig()
    initWindow()
    initEngine()
    initApplication()

    min_dt = 1. / config.framerate
    next_time = timer.getTime()
end

local defaultW, defaultH = 375, 812

function setMode(w, h)
    if w > h then config.orientation = 'landscape' else config.orientation = 'portrait' end
    initWindow(w, h)
end

function initWindow(w, h)    
    screen = {}

    if getOS() == 'ios' then

        screen.w, screen.h = window.getMode()
        if config.orientation == 'landscape' then
            screen.w, screen.h = max(screen.w, screen.h), min(screen.w, screen.h)
        else
            screen.w, screen.h = min(screen.w, screen.h), max(screen.w, screen.h)
        end

    else

        adjustScale()

        if config.orientation == 'landscape' then
            w = w or defaultH * config.screenScale
            h = h or defaultW * config.screenScale
        else
            w = w or defaultW * config.screenScale
            h = h or defaultH * config.screenScale
        end
        screen.w, screen.h = w, h

    end

    if config.orientation == 'portrait' then

        screen.TOP = 44 + 44
        screen.BOTTOM = 34 + 44

        screen.LEFT = 4
        screen.RIGHT = 4

        screen.hBAR = 44

        screen.WIDTH = (screen.w - (screen.LEFT + screen.RIGHT ))
        screen.HEIGHT = (screen.h - (screen.TOP  + screen.BOTTOM))

        screen.wBAR = screen.WIDTH

    else

        screen.TOP = 4
        screen.BOTTOM = 4

        screen.LEFT = 44 + 44
        screen.RIGHT = 34 + 44

        screen.wBAR = 44

        screen.WIDTH = (screen.w - (screen.LEFT + screen.RIGHT ))
        screen.HEIGHT = (screen.h - (screen.TOP  + screen.BOTTOM))        

        screen.hBAR = screen.HEIGHT

    end

    graphics.reset()

    window.setMode(
        screen.w,
        screen.h,
        {
            vsync = true,
            highdpi = true,
--            resizable = true,
            centered = false
        })


    WIDTH = screen.WIDTH
    HEIGHT = screen.HEIGHT        

--    if getOS() ~= 'ios' then
--        local x, y, display = window.getPosition(0, 0)
--        window.setPosition(x, y, display)
--    end
end

function orientationScale()
    local screenScale
    if config.orientation == 'landscape' then
        screenScale = 1.8
    else
        screenScale = 1.2
    end
    return screenScale
end

function adjustScale()
    config.screenScale = config.screenScale ~= 1 and orientationScale() or 1
end

function toggleScale()
    config.screenScale = config.screenScale == 1 and orientationScale() or 1
    restart()
end

function toggleOrientation()
    if config.orientation == 'portrait' then
        config.orientation = 'landscape'
    else
        config.orientation = 'portrait'
    end
    restart()
end

function toggleBar()
    local visible = toolbar.visible
    toolbar.visible = not visible
    parameter.infos.visible = not visible
end

function initEngine()    
    setupClasses()
    setupMouseMotion()

    ut:run()

    DeltaTime = 0
    ElapsedTime = 0

    engine = engine or {}

    engine.resources = Table()
    engine.timers = Table()

    engine.resources:add(engine.timers)
    engine.resources:add(parameter)

    resetStyle()    
    resetMatrix(true)

    titlebar = TitleBar()
    titlebar:add(Expression('config.appNameShort'):attribs{textColor=brown})

    topbar = ToolBar(0, 0, 'up')
    topbar.outerMarge = 0
    topbar.textSize = 14
    topbar:add(Fps())
    topbar:add(Label('RAM'))
    topbar:add(Expression('formatMemory()'))
    topbar:add(Label('Res'))
    topbar:add(Expression('resources.arrays:getnKeys()'))
    topbar:add(CheckBox('config.deferredDraw'))
    topbar:add(CheckBox('config.wireFrame'))
    topbar:add(CheckBox('config.logMode'))
    topbar:add(CheckBox('config.manageFramerate'))
    topbar:add(Button('Orientation', function () toggleOrientation() end))
    topbar:add(Button('Info', showInfo))

    toolbar = ToolBar(0, 0, 'down')
    toolbar.outerMarge = 0

    toolbar:add(ButtonIconFont('refresh', function () restart() end))
    toolbar:add(ButtonIconFont('list', function () appManager() end))
    toolbar:add(ButtonIconFont('previous', function () previousApp() end))
    toolbar:add(ButtonIconFont('next', function () nextApp() end))
    toolbar:add(ButtonIconFont('play', function () loopApp() end))
end

function initApplication()    
    engine.timers:clear()

    config.appName = config.appName or DEFAULT_APP

    if app then
        table.save(config, getDataPath()..'/'..'#config')
    end

    app = loadApp(config.appName)

    drawings = {}

    -- drawing app
    drawings[1] = {
        depth = true,
        resetBackground = false,
        add = false,
        x = screen.LEFT,
        y = screen.BOTTOM,
        w = screen.WIDTH,
        h = screen.HEIGHT,
        ratio = appScale,
        draw = function (w, h)
            initMode('back', true)

            meshManager = MeshManager()
            app:draw()
            meshManager:flush()

            resetStyle()
            resetMatrix(true)
            ortho()

            stroke(red)
            strokeWidth(2)
            noFill()
            rectMode(CORNER)
            rect(0, 0, w, h)
        end
    }

    -- drawing parameter
    drawings[2] = {
        depth = true,
        resetBackground = true,
        add = true,
        x = screen.LEFT,
        y = screen.BOTTOM,
        w = screen.WIDTH,
        h = screen.HEIGHT,
        draw = function (w, h)
            if config.logMode then
                engine.resources:draw()
            end

            titlebar:layout()
            titlebar:draw()
        end
    }

    -- drawing top bar
    topbar:layout()
    drawings[3] = {
        depth = false,
        resetBackground = true,
        add = true,
        landscape = function (self)
            self.x = screen.LEFT - screen.wBAR
            self.y = screen.BOTTOM
            self.w = screen.wBAR
            self.h = screen.HEIGHT
            topbar.verticalDirection = 'up'
            topbar.layoutProc = Layout.column
        end,
        portrait = function (self)
            self.x = screen.LEFT
            self.y = screen.BOTTOM + screen.HEIGHT
            self.w = screen.WIDTH
            self.h = screen.hBAR
            topbar.verticalDirection = 'up'
            topbar.layoutProc = Layout.row
        end,
        draw = function ()
            topbar:layout()
            topbar:draw()
        end
    }

    -- drawing tool bar
    drawings[4] = {
        depth = false,
        resetBackground = true,
        add = true,
        landscape = function (self)
            self.x = screen.LEFT + screen.WIDTH
            self.y = screen.BOTTOM
            self.w = screen.wBAR
            self.h = screen.HEIGHT
            toolbar.verticalDirection = 'up'
            toolbar.layoutProc = Layout.column
        end,
        portrait = function (self)
            self.x = screen.LEFT
            self.y = screen.BOTTOM - screen.hBAR
            self.w = screen.WIDTH
            self.h = screen.hBAR
            toolbar.verticalDirection = 'down'
            toolbar.layoutProc = Layout.row
        end,
        draw = function ()
            toolbar:layout()
            toolbar:draw()
        end
    }
end

function lca.update(dt)
    if config.manageFramerate  then
        next_time = next_time + min_dt
    end

    resetStyle()
    resetMatrix(true)

    DeltaTime = dt
    ElapsedTime = ElapsedTime + dt

    if config.profiling and Profiler then
        if Profiler.frame == nil then
            Profiler.init()
            Profiler.frame = system.fps.frame
        end
        if Profiler.frame + 150 == system.fps.frame then
            close()
            saveLocalData('profiling', false)
        end
    end

    tween.updateAll(dt)

    engine.resources:update(dt)
    resources.gc()

    currentEnv.RAM = formatMemory()

    currentEnv.physics:update(dt)

    checkEvent('keydown')

    topbar:update(dt)
    titlebar:update(dt)
    toolbar:update(dt)

    local ratio = drawings[1].ratio or 1
    WIDTH = drawings[1].w * ratio
    HEIGHT = drawings[1].h * ratio
    app:update(dt)
end

function initMode(cullingFace, depthBuffer)
    cullingFace = value(cullingFace, config.cullingFace)
    depthBuffer = value(depthBuffer, config.depthBuffer)

    -- Activation du Culling
    graphics.setFrontFaceWinding('cw') -- CCW but rendering to flip canvas
    graphics.setMeshCullMode('none') -- cullingFace)

    -- Activation du Depth Buffer
    if depthBuffer then
        graphics.setDepthMode('lequal', true)
    else
        graphics.setDepthMode()
    end
end

function lca.draw()
    for i,drawing in ipairs(drawings) do
        drawing.id = i
        lca.render(drawing)
    end

    if config.manageFramerate then
        local cur_time = timer.getTime()
        if next_time <= cur_time then
            next_time = cur_time
        else
            timer.sleep(next_time - cur_time)
        end
    end
end

local renderToCanvas = true

function currentDef(w, h)
    w, h = w or screen.w, h or screen.h
    if graphics.getCanvas() then
        w, h = graphics.getCanvas():getDimensions()
    end
    return w, h
end

function ref(...)
    return table.concat({...}, '.')
end

function lca.render(object)
    graphics.setBlendMode('alpha')

    if object[config.orientation] then
        object[config.orientation](object)
    end

    local ratio = object.ratio or 1
    WIDTH = object.w * ratio
    HEIGHT = object.h * ratio

    if renderToCanvas then
        object.ctx = resources.get('canvas', ref(object.id, object.w, object.h),
            function ()
                return graphics.newCanvas(
                    object.w * ratio,
                    object.h * ratio)
            end,
            function (canvas)
                canvas:release()
            end,
            false)

        graphics.setCanvas({
                object.ctx,
                depthstencil = object.depth,
                depth = object.depth
            })

        if object.resetBackground then
            background(0, 0, 0, 0)
        end
    end

    graphics.setWireframe(config.wireFrame or false)

    resetStyle()
    resetMatrix(true)

    ortho()

    initMode('none', false)

    object.draw(
        object.w * ratio,
        object.h * ratio)

    if renderToCanvas then
        graphics.reset()
        if object.add then
            graphics.setBlendMode('add', 'premultiplied')
        end
        graphics.draw(object.ctx,
            object.x,
            screen.h-object.y,
            0,
            1/ratio, -1/ratio)
    end
end

function lca.touched(touch)
    if (config.orientation == 'landscape' and touch.screenX > screen.LEFT + screen.wBAR + screen.WIDTH or
        config.orientation == 'portrait'  and touch.screenY > screen.TOP  + screen.hBAR + screen.HEIGHT)
    then
        if touch.state == BEGAN then
            toggleBar()
        end
    end

    if app then
        local function contains(drawingId, scene, touch)
            touch = touch:clone():translate(drawings[drawingId])

            local ratio = drawings[drawingId].ratio or 1
            WIDTH = drawings[drawingId].w * ratio
            HEIGHT = drawings[drawingId].h * ratio

            if scene.contains == nil or scene:contains(touch) then
                scene:touched(touch)
                return true
            end
        end

        return (
            contains(3, topbar, touch) or
            contains(2, titlebar, touch) or
            contains(2, parameter.infos, touch) or
            contains(4, toolbar, touch) or
            contains(1, app, touch))
    end
end

function lca.pressed(button)
    if app then
        app:pressed(button)
    end
end

function lca.release()
    if Profiler then
        Profiler.report()
    end
end

function lca.wheelmoved(x, y)
    CurrentTouch.x = mouse.getX()
    CurrentTouch.y = HEIGHT-mouse.getY()

    if app then
        app:wheelmoved(1, x, y)
    end
end

function quit(...)
    lca.release()
    event.quit(...)
    table.save(config, getDataPath()..'/'..'#config')
end

function restart()
    system.vibrate(0.5)
    quit(RESTART)
end
