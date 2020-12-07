class 'ApplicationManager'

function ApplicationManager:init()
    self.envs = {}
end

function ApplicationManager:loadApp(appPath, reloadApp)
    if not isApp(appPath) then
        self:managerApp()
        return
    end

    if _G.env and _G.env.app then
        _G.env.app.renderFrame = RenderFrame.getRenderFrame()
        engine.renderFrame = nil
    end

    saveGlobalData('appPath', appPath)

    self.appPath = appPath
    self.appName, self.appDirectory = splitPath(appPath)

    sdl.SDL_SetWindowTitle(sdl.window, 'Engine : '..appPath)

    if self.envs[appPath] == nil or reloadApp then
        print('load '..appPath)

        local env = {}
        self.envs[appPath] = env
        _G.env = env        

        setmetatable(env, {__index=_G})
        setfenv(0, env)

        screen:pushSize()

        package.loaded[appPath] = nil
        require(appPath)

        env.physics = Physics()
        env.parameter = Parameter()
        
        call('setup', env)

        if env.appClass then
            engine:draw(env.appClass.setup)

            env.app = env.appClass()
            engine.app = env.app

        else
            env.app = Application()
            engine.app = env.app

            engine:draw(_G.env.setup)
        end

        if not env.__orientation then
            supportedOrientations(LANDSCAPE_ANY)
        end

    else
        print('switch '..appPath)

        local env = self.envs[appPath]
        _G.env = env

        setfenv(0, env)

        engine.app = env.app
        RenderFrame.renderFrame = env.app.renderFrame

        supportedOrientations(env.__orientation or LANDSCAPE_ANY)
    end
end

function ApplicationManager:managerApp()
    self.action = nil
    self:loadApp('applications/appManager')
end

function ApplicationManager:lastApp()
    self:loadApp(readGlobalData('appPath', 'applications/appManager'))
end

function ApplicationManager:defaultApp()
    self.action = nil
    self:loadApp('applications/main')
end

function ApplicationManager:nextApp()
    local apps = applicationManager:dirApps(nil, true)

    local nextAppIndex = 1
    for i,appPath in ipairs(apps) do
        if appPath == self.appPath then
            if i < #apps then
                nextAppIndex = i + 1
                break
            end
        end
    end

    local appPath = apps[nextAppIndex]
    self:loadApp(appPath)
end

function ApplicationManager:previousApp()
    local apps = applicationManager:dirApps(nil, true)

    local previousAppIndex = #apps
    for i,appPath in ipairs(apps) do
        if appPath == self.appPath then
            if i > 1 then
                previousAppIndex = i - 1
                break
            end
        end
    end

    local appPath = apps[previousAppIndex]
    self:loadApp(appPath)
end

function ApplicationManager:loopApp(delay)
    if self.action then
        self.action = nil
    else
        self:managerApp()

        self.loopAppRef = #applicationManager:dirApps(nil, true)
        self.loopAppDelay = delay or 0

        self.action = callback(self, ApplicationManager.loopAppProc, delay)
    end
end

function ApplicationManager:loopAppProc(delay)
    if self.loopAppDelay <= 0 then
        self:nextApp()

        self.loopAppRef = self.loopAppRef - 1
        self.loopAppDelay = delay or 0

        if self.loopAppRef == 0 then
            self.action = nil
            self:managerApp()
        end
    else
        self.loopAppDelay = self.loopAppDelay - DeltaTime
    end
end

function ApplicationManager:package()
    os.execute('cd /Users/Ludo/Projets/Lua/engine && zip -9 -r -u /Users/Ludo/Projets/Libraries2/love-11.3-ios-source/platform/xcode/applications.love .')
end

function ApplicationManager:dir(path, method, recursivly)
    local apps = method(path or '', recursivly)
    apps:apply(function (app)
            return app:gsub('%.lua', '')
        end)
    apps:sort()
    return apps
end

function ApplicationManager:dirApps(path, recursivly)
    return self:dir(path or 'applications', dirApps, recursivly)
end

function ApplicationManager:dirFiles(path, recursivly)
    return self:dir(path, dirFiles, recursivly)
end

function ApplicationManager:dirDirectories(path, recursivly)
    return self:dir(path, dirDirectories, recursivly)
end
