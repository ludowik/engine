lca = {}

function lca.setup()
    W_INFO = 200

    if osx then
        system.window(1480, 1000)
    else
        system.window(1480, 800)
    end

    classes:setup()
    classes:test()
    classes:version()

    function with(object, f)
        f(object)
        return object
    end

    lca.gameObjects = Node():add(
        classes,
        tween,
        resources,
        Timer,
        lights,
        --meshManager,
        AppWrapper(),
        parameter,
        Reporting())

    renderFrame = image(W, H)

    lca.apps = lca.getApps('apps')
    lca.loadApp(lca.apps:first(config.appPath))
end

function lua.getVersion()
    return 'v0.9'
end

function lca.quit(restartMode)
    Config.save()

    lca.stop = restartMode or 'stop'
    system.quit(restartMode)
end

function lca.init()
    system.restartMode = nil

    lca.frame = 0

    DeltaTime = 0
    ElapsedTime = 0

    system.reset()
end

function lca.getApps(path, recursive)
    path = path or 'apps'
    recursive = value(recursive, true)

    local apps = Table()

    local directoryItems = fs.getDirectoryItems(path)

    for i,v in ipairs(directoryItems) do
        if not v:startWith('__') then
            local itemPath = path..'/'..v
            local info = fs.getInfo(itemPath)

            if info.type == 'file' then
                if itemPath:lower():find('%.lua') then
                    apps:push(itemPath:replace('%.lua', ''))
                end

            elseif info.type == 'directory' then
                local mainPath = itemPath..'/main.lua'
                local info = fs.getInfo(mainPath)
                if isApp(itemPath) or not recursive then
                    apps:push(itemPath)
                else
                    apps = apps + lca.getApps(itemPath)
                end

            end
        end
    end

    apps:sort()

    return apps
end

local reloadApp = true

-- TODO : créer un fichier appManager?

function lca.loadApp(appPath)
    if reloadApp then
        lca.releaseApp()
--        setContext(renderFrame)
--        background()
    end

    config.appPath = appPath
    Config.save()

    print('load application : '..appPath)

    system.setTitle(appPath)
    lca.init()

    classes:reset()

    Profiler.reset()

    lca.envs = lca.envs or {}

    if lca.envs[appPath] == nil or reloadApp then
        lca.envs[appPath] = {}

        local env = lca.envs[appPath]
        _G.env = env
        _G.physics = newPhysics()

        setfenv(0, setmetatable(env, {__index=_G}))

        ___requireReload = true
        require(appPath)
        ___requireReload = false

        classes:setup()

        env.app = env.app and env.app() or Sketche()
    else
        local env = lca.envs[appPath]
        _G.env = env
        setfenv(0, env)
    end
end

function lca.releaseApp()    
    if env and env.app then
        if not looping then
            env.app:captureImage()
        end

        env.app:suspend()
        env.app:release()

        env.app = nil
        env = nil

        _G.env = nil
        _G.physics = nil

        parameter.release()
        tween.resetAll()
        output.clear()

        resources.gc()

        collectgarbage('collect')
    end
end

function lca.reset()
    graphics.reset()
end

function lca.update(dt) 
    if meshManager then meshManager:update(dt) end

    DeltaTime = dt
    ElapsedTime = ElapsedTime + dt

    lca.reset()
    lca.gameObjects:update(dt)

    if physics then
        physics.update(dt)
    else
        env.physics:update(dt)
    end
end

function lca.draw()
    lca.reset()
    lca.gameObjects:draw()

    lca.frame = lca.frame + 1

    if meshManager then meshManager:flush() end
end

function lca.drawInfo()
    depthMode(false)

    fill(white)

    font(DEFAULT_FONT_NAME)
    fontSize(14)

    local infos

    infos = Table()

    infos:addItems{
        system.getFPS()..'/'..config.framerate..(config.frameSync and ' Sync' or ''),
        config.appPath,        
        debugging() and 'debugging' or 'none'
    }

    if config.drawInfo then
        infos:addItems{
            'frame = '..lca.frame,
            'res = '..resources.nRes,
            'drawcalls = '..graphics.drawcalls,
            'texturememory = '..convertMemory(graphics.texturememory),
            'memory = '..convertMemory(collectgarbage('count'), 2)
        }

        if memMemory > 0 then
            infos:addItems{
                'memMemory = '..convertMemory(memMemory),
                'memAlloc = '..memAlloc,
                'memRealloc = '..memRealloc,
                'memFree = '..memFree
            }
        end

        infos:addItems{
            'size : '..W..'/'..H,

            'lights : '..config.lightMode,

            'mouse.x = '..mouse.x,
            'mouse.y = '..mouse.y,

            'pixel = '..tostring(renderFrame:get(mouse.x+1, mouse.y))
        }

        if env.app and env.app.ui and env.app.ui.focus then
            infos:addItems{
                table.tostring(env.app and env.app.ui and env.app.ui.focus)
            }
        end    
    end

    local H = HEIGHT

    textMode(CORNER)
    for i,info in ipairs(infos) do
        local w, h = textSize(info)
        text(info, 0, H-h)
        H = H - h
    end

    output.draw(0, H)
end

function lca.keypressed(key, scancode, isrepeat)
    Keyboard.keypressed(key, scancode, isrepeat)
    env.app:keyboard(key, scancode, isrepeat)
end

function lca.keyreleased(key, scancode)
    Keyboard.keyreleased(key, scancode)
end

function lca.collide(contact)
    env.app:collide(contact)
end

function updateCamera(dt)
    if lca.camera then
        local dist = 10
        if isDown('up') or isDown('a')  then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                lca.camera:processKeyboardMovement('up', dt)
            else
                lca.camera:processKeyboardMovement('forward', dt)
            end
        end

        if isDown('down') or isDown('q') then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                lca.camera:processKeyboardMovement('down', dt)
            else
                lca.camera:processKeyboardMovement('backward', dt)
            end
        end

        if isDown('left') then
            lca.camera:processKeyboardMovement('left', dt)
        end

        if isDown('right') then
            lca.camera:processKeyboardMovement('right', dt)
        end
    end
end

function processMovementOnCamera(touch)
    if lca.camera then
        lca.camera:processMouseMovement(touch)
    end
    --    app.scene.rotation = app.scene.rotation or vec3()
    --    app.scene.rotation = app.scene.rotation + vec3(touch.deltaX, touch.deltaY)
end

function processWheelMoveOnCamera(x, y)
    if lca.camera then
        if isDown(KEY_FOR_MOUSE_MOVING) then
            lca.camera:moveSideward(x, DeltaTime)
            lca.camera:moveUp(y, DeltaTime)
        else
            lca.camera:zoom(0, y, DeltaTime)
        end
    end
end

function lca.mouseEvent(state, touchId, x, y, dx, dy, istouch, clicks)
    x = x - W_INFO

    mouse:attribs{
        id = touchId,

        state = state,

        x = x,
        y = H-y,

        deltaX = dx,
        deltaY = dy,

        istouch = istouch,

        tapCount = clicks or 1
    }

    if state == BEGAN then
        mouse.totalX = 0
        mouse.totalY = 0
    else
        mouse.totalX = mouse.totalX + dx
        mouse.totalY = mouse.totalY + dy
    end

    if isDown(KEY_FOR_ACCELEROMETER) then
        Gravity.x = Gravity.x + dx * 0.1
        Gravity.y = Gravity.y - dy * 0.1
    end

    if isButtonDown(1) or state == ENDED then
        if not parameter:touched(mouse) then
            env.app:touched(mouse)
            processMovementOnCamera(mouse)
        end        
    end
end

function lca.wheelmoved(id, x, y)
    env.app:wheelmoved(id, x, y)
end
