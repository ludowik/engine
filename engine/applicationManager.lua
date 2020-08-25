class 'ApplicationManager'

function ApplicationManager:nextApp()
    local apps = self:dirApps()

    local nextAppIndex = 1
    for i,appName in ipairs(apps) do
        if appName == self.appName then
            if i < #apps then
                nextAppIndex = i + 1
                break
            end
        end
    end    

    local appName = apps[nextAppIndex]
    self:loadApp(appName)
end

function ApplicationManager:previousApp()
    local apps = self:dirApps()

    local previousAppIndex = #apps
    for i,appName in ipairs(apps) do
        if appName == self.appName then
            if i > 1 then
                previousAppIndex = i - 1
                break
            end
        end
    end    

    local appName = apps[previousAppIndex]
    self:loadApp(appName)
end

function ApplicationManager:loopApp(delay)
    if self.action then
        self.action = nil
    else
        self.loopAppRef = #self:dirApps()
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
        end
    else
        self.loopAppDelay = self.loopAppDelay - DeltaTime
    end
end

function ApplicationManager:loadApp(appName, reloadApp)
    self.appName = appName or self.appName
    self.appPath = 'applications/'..self.appName

    if (not exists(Path.sourcePath..'/'..self.appPath..'.lua') and
        not exists(Path.sourcePath..'/'..self.appPath..'/#.lua') and
        not exists(Path.sourcePath..'/'..self.appPath..'/main.lua'))
    then
        assert()
        
        self.appName = 'default'
        self.appPath = 'applications/'..self.appName
    end

    saveGlobalData('appName', self.appName)

    if self.envs[self.appPath] == nil or reloadApp then
        print('load '..self.appPath)

        local env = {}
        self.envs[self.appPath] = env
        _G.env = env

        setfenv(0, setmetatable(env, {__index=_G}))

        ___requireReload = true
        require(self.appPath)
        ___requireReload = false

        env.physics = box2dRef and box2dRef.Physics() or Physics()
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

    sdl.SDL_SetWindowTitle(sdl.window, 'Engine : '..self.appName)
    
    for i=1,2 do
        setContext(self.renderFrame)
        background(black)
        self:postRender()
        sdl:swap()
    end
end
