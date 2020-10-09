class 'ApplicationManager'

function ApplicationManager:loadApp(appPath, reloadApp)
    self.appName, self.appDirectory = splitPath(appPath)
    self.appPath = appPath

    if not isApp(self.appPath) then
        print(self.appName, self.appDirectory, self.appPath)
        error(false)
    end

    saveGlobalData('appPath', self.appPath)

    if self.envs[self.appPath] == nil or reloadApp then
        print('load '..self.appPath)

        local env = {}
        self.envs[self.appPath] = env
        _G.env = env

        setfenv(0, setmetatable(env, {__index=_G}))

        ___requireReload = true
        require(self.appPath)
        ___requireReload = false

--        env.physics = box2dRef and box2dRef.Physics() or Physics()
        env.physics = Physics()
        env.parameter = Parameter()

        if env.appClass then
            env.appClass.setup()

            env.app = env.appClass()
        else
            env.app = Application()

            if _G.env.setup then
                _G.env.setup()
            end
        end

    else
        print('switch '..self.appPath)

        local env = self.envs[self.appPath]
        _G.env = env

        setfenv(0, env)
    end

    self.app = env.app

    sdl.SDL_SetWindowTitle(sdl.window, 'Engine : '..self.appPath)

    if self.renderFrame then
        for i=1,2 do
            setContext(self.renderFrame)
            background(black)
            self:postRender()
            sdl:swap()
        end
    end
end

function ApplicationManager:managerApp()
    self:loadApp('applications/appManager')
end

function ApplicationManager:lastApp()
    self:loadApp(readGlobalData('appPath', 'applications/appManager'))
end

function ApplicationManager:defaultApp()
    self:loadApp('applications/main')
end

function ApplicationManager:nextApp()
    local apps = self:dirApps(nil, true)

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
    local apps = self:dirApps(nil, true)

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

        self.loopAppRef = #self:dirApps(nil, true)
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
