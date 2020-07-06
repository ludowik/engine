class 'Engine'

function Engine:init()
    assert(engine == nil)

    engine = self
    engine.envs = engine.envs or {}

    loadConfig()

    ut.run()
    performance.run()

    self.active = 'start'

    self.memory = Memory()
    self.frame_time = FrameTime()

    -- modules
    sdl = Sdl()
    gl = OpenGL()
    al = OpenAL()
    ft = FreeType()

    self.components = Node()
    do
        self.components:add(self.memory)
        self.components:add(Path())

        self.components:add(sdl)
        self.components:add(gl)
        self.components:add(al)
        self.components:add(ft)

        self.components:add(ShaderManager())
        self.components:add(Graphics())

        tween.setup()
    end

    W = 1600
    H = math.floor(W*9/16)

    WIDTH = W
    HEIGHT = H

    self:initEvents()
end

function Engine:initEvents()
    self.onEvents = {
        keydown = {
            ['r'] = Engine.restart,
            ['escape'] = Engine.quit,

            ['d'] = Engine.defaultApp,
            ['n'] = Engine.nextApp,
            ['b'] = Engine.previousApp,
            ['v'] = Engine.loopApp,

            ['f1'] = Engine.toggleHelp,

            ['f2'] = Engine.toggleRenderMode,
            ['f3'] = Engine.toggleRenderVersion,
        }
    }
end

function Engine:initialize()
    self.components:initialize()

    call('setup')

    self:toggleRenderMode()
    self:toggleHelp()

    self:loadApp(readGlobalData('appName', 'default'))
end

function Engine:release()
    saveConfig()
    self.components:release()
    gc()
end

function Engine:run(appName)
    self.appName = self.appName or appName

    repeat

        self:initialize()

        self.active = 'running'

        local deltaTime = 0
        self.fpsTarget = 120
        self.frame_time:init()

        while self.active == 'running' do
            self.frame_time:update()
            deltaTime = deltaTime + self.frame_time.delta_time

            local maxDeltaTime = 1/self.fpsTarget

            if deltaTime >= maxDeltaTime then
                deltaTime = deltaTime - maxDeltaTime

                if self.frame_time.delta_time >= maxDeltaTime then
                    self.fpsTarget = self.fpsTarget - 1
                else
                    self.fpsTarget = self.fpsTarget + 1
                end

                DeltaTime = deltaTime
                ElapsedTime = self.frame_time.elapsed_time

                self:update(deltaTime)
                self:draw()

                self.frame_time:draw()
            end
        end

        if type(self.active) == 'function' then
            self.active = self.active()
        end

        self:release()

    until engine.active ~= 'restart'
end

function Engine:drawHelp()
    if self.showHelp then
        fontSize(8)
        for k,v in pairs(self.onEvents.keydown) do
            info(k)
        end
    end
end

function Engine:quit()
    self.active = 'stop'
end

function Engine:restart()
    self.active = 'restart'
end

function Engine:toggleRenderVersion()
    self.active = function ()
        config.glMajorVersion = toggle(config.glMajorVersion, 2, 4)
        return 'restart'
    end
end

function Engine:toggleRenderMode()
    self.renderMode = toggle(self.renderMode, 'frame', 'direct')

    if self.renderMode == 'frame' then
        self.renderFrame = Image(W, H)
    else
        self.renderFrame = nil
    end
end

function Engine:toggleHelp()
    self.showHelp = toggle(self.showHelp, false, true)
end

function Engine:update(dt)
    self.components:update(self.frame_time.delta_time)

    if self.action then
        self:action()
    end

    engine.app:__update(dt)
end

function Engine:preRender()    
    resetMatrix()
    resetStyle()

    if self.renderFrame then
        setContext(self.renderFrame)
    else
        Context.noContext()
    end
end

function Engine:draw()
    self:preRender()

    engine.app:__draw()

    self:postRender()

    --    self:preRender()

    resetMatrix()
    resetStyle()
    
    fontSize(10)

    do
        function info(name, value)
            local info = name..' : '..tostring(value)
            text(info)
        end

        info('fps', self.frame_time.fps)
        info('fps target', self.fpsTarget)
        info('app', self.appName)
        info('ram', format_ram(self.memory.ram.current))
        info('mouse', mouse)
        info('os', jit.os)
        info('debugging', debugging)
        info('compile', jit.status())
        info('arch', jit.arch)
        info('jit version', jit.version)
        info('opengl version', config.glMajorVersion)
        info('render mode', self.renderMode)
    end

    --    self:postRender()

    sdl:swap()
end

function Engine:postRender()
    self:drawHelp()

    if self.renderFrame then
        Context.noContext()
        ortho(0, W + W_INFO, 0, H)

        background(Color(0, 0, 0, 1))

        blendMode(NORMAL)
        depthMode(false)

        resetMatrix()
        resetStyle()

        self.renderFrame:draw(W_INFO, 0, WIDTH, HEIGHT)
    end
end

function Engine:keydown(key)
    if self.onEvents.keydown[key] then
        self.onEvents.keydown[key](self)
    else
        print(string.format('no action for {key}', {key=key}))
    end
end

function Engine:touched(touch)
    engine.app:__touched(touch)
end

function Engine:dirApps()
    local apps = dir('./applications')
    apps:apply(function (app)
            return app:lower():gsub('%.lua', '')
        end)
    return apps
end

function Engine:defaultApp()
    self:loadApp('default')
end

function Engine:nextApp()
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

function Engine:previousApp()
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

function Engine:loopApp()
    if self.action then
        self.action = nil
    else
        self.loopApp = #self:dirApps()
        self.action = self.loopAppProc
    end
end

function Engine:loopAppProc()
    self:nextApp()
    self.loopApp = self.loopApp - 1
    if self.loopApp == 0 then
        self.action = nil
    end
end

function Engine:loadApp(appName, reloadApp)
    self.appName = appName or self.appName
    self.appPath = 'applications/'..self.appName

    if (not exists(Path.sourcePath..'/'..self.appPath..'.lua') and
        not exists(Path.sourcePath..'/'..self.appPath..'/#.lua') and
        not exists(Path.sourcePath..'/'..self.appPath..'/main.lua'))
    then
        error(self.appName)
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

        env.physics = Physics()

        if env.appClass then
            env.appClass.setup()

            self.app = env.appClass()
        else
            self.app = Application()

            if _G.env.setup then
                _G.env.setup()
            end
        end

        env.app = self.app

    else
        print('switch '..self.appPath)

        local env = self.envs[self.appPath]
        _G.env = env

        setfenv(0, env)        
    end
    
    
    sdl:swap()
end

function setup()
    assert()
    engine.app:__setup()
end

function collide(...)
    assert()
    engine.app:__collide(...)
end
