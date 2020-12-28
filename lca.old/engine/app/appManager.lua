RESTART = 'restart'
LOOP = 'loop'

DEFAULT_APP = 'app/appManager'

local apps
function loadApp(appName)
    config.appNameShort = appName:sub(appName:findLast('/')+1)

    apps = apps or {}

    if app then
        app:suspend()
        app.appContext.camera = engine.camera
    end

    if apps[appName] then        
        _G.currentEnv = apps[appName].env
        setfenv(0, setmetatable(apps[appName].env, {__index=_G}))

        parameter.infos = apps[appName].infos
        supportedOrientations(apps[appName].supportedOrientations)

        engine.camera = apps[appName].camera

        apps[appName].app:resume()

        gc()

        return apps[appName].app
    end

    if not isApp(appName) then
        appName = DEFAULT_APP
        config.appName = appName
    end
    assert(isApp(appName))

    print('load '..appName)

    parameter.clear()

    local env = {}
    _G.currentEnv = env

    setfenv(0, setmetatable(env, {__index=_G}))
    require(appName)

    if env.application then
        setupClasses()
    else
        resetClasses()
    end

    env.application = env.application or Codea
    env.physics = Physics()

    if env.application then
        engine.camera = nil

        local app

        local drawing = {
            id = 1,
            depth = true,
            resetBackground = false,
            add = false,
            x = screen.LEFT + screen.wBAR,
            y = screen.TOP + screen.hBAR + screen.HEIGHT,
            w = screen.WIDTH,
            h = screen.HEIGHT,
            ratio = screenScale,
            draw = function (w, h)
                app = env.application()
            end
        }
        lca.render(drawing)

        assert(engine.camera)

        app.appContext = {
            env = env,
            app = app,
            supportedOrientations = supportedOrientations(),
            infos = parameter.infos
        }

        apps[appName] = app.appContext
    end

    return apps[appName].app
end

function setApp(appName)
    config.appName = appName

    initWindow()
    initApplication()

    if engine.appMode == LOOP then
        if engine.appEndLoop == config.appName then
            engine.appMode = nil
        else
            engine.timers:add(Timer(0.5, function ()
                        nextApp()
                    end))
        end
    end
end

function appManager()
    setApp('app/appManager')
end

function listApp(path, recursive)
    local apps = dirApp(path or 'app')

    if recursive then
        local otherApps = apps
        for i,appPath in ipairs(apps) do
            local appName = appPath:sub(appPath:findLast('/')+1)

            if not isApp(appPath) then
                isApp(appPath)
                otherApps = otherApps + dirApp(appPath)
            end
        end
        apps = otherApps
    end

    apps:sort(function (a,b)
            if a == 'sandbox' then
                return true
            elseif b == 'sandbox' then
                return false
            end

            return a < b
        end)

    return apps
end

function pushApp(newApp)
    push('apps', app)
    app = newApp
end

function popApp()
    app = pop('apps')
end

function nextOrPreviousApp(order)
    local appsName = listApp(nil, true)    
    local appName = config.appName

    local i
    repeat
        i = appsName:findItem(appName)
        if i then
            i = i + order
            if order == 1 and i > #appsName then
                i = 1
            elseif order == -1 and i == 0 then
                i = #appsName
            end
        else
            break
        end
        appName = appsName[i]
    until isApp(appName)

    if i then
        setApp(appName)
    else
        assert(appName)
    end
end

function nextApp()
    nextOrPreviousApp(1)
end

function previousApp()
    nextOrPreviousApp(-1)
end

function loopApp()
    if engine.appMode == nil then
        engine.appMode = LOOP
        engine.appEndLoop = config.appName
        nextApp()
    else
        engine.appMode = nil
    end
end
