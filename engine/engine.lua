class 'Engine' : extends(ApplicationManager)

function Engine:init()
    assert(engine == nil)

    engine = self
    engine.envs = engine.envs or {}

    loadConfig()

    do
        ut.run()
        performance.run()
    end

    self.active = 'start'

    self.memory = Memory()
    self.frame_time = FrameTime()

    -- create components
    sdl = Sdl()
    gl = OpenGL()
    al = OpenAL()
    ft = FreeType()

    resourceManager = ResourceManager()

    shaderManager = ShaderManager()

    graphics = Graphics()

    -- add components
    self.components = Node()
    do
        self.components:add(self.memory)
        self.components:add(Path())

        self.components:add(sdl)
        self.components:add(gl)
        self.components:add(al)
        self.components:add(ft)

        self.components:add(resourceManager)
        self.components:add(shaderManager)
        self.components:add(graphics)

        self.components:add(Profiler)

        self.components:add(tween)

        tween.setup()
    end

    W_INFO = 200

    if os.name == 'osx' then
        W = 1480
        H = 1000
    else
        W = 1024
        H = math.floor(W*9/16)
    end

    WIDTH = W
    HEIGHT = H

    self:initEvents()
end

function Engine:initEvents()
    self.onEvents = {
        keydown = {
            ['r'] = callback(engine, Engine.restart),
            ['escape'] = callback(engine, Engine.quit),

            ['d'] = callback(engine, Engine.defaultApp),
            ['a'] = callback(engine, Engine.managerApp),

            ['n'] = callback(engine, Engine.nextApp),
            ['b'] = callback(engine, Engine.previousApp),

            ['v'] = callback(engine, Engine.loopApp, 0),
            ['c'] = callback(engine, Engine.loopApp, 2),

            ['f1'] = callback(engine, Engine.toggleHelp),
            ['f2'] = callback(engine, Engine.toggleRenderVersion),

            ['tab'] = function ()
                if self.app then
                    self.app.ui:nextFocus()
                end
            end,

            [','] = function()
                Profiler.resetClasses()

                if not Profiler.running then
                    Profiler.init()
                    Profiler.start()

                    reporting = Reporting()
                else
                    Profiler.stop()
                end
            end,

            [KEY_FOR_ACCELEROMETER] = function (_, _, isrepeat)
                if not isrepeat then
                    Gravity = vec3(0, -9.8, 0)
                end
            end,
        },

        keyup = {
            [KEY_FOR_ACCELEROMETER] = function ()
                Gravity = vec3(0, -9.8, 0)
            end,
        }
    }
end

function Engine:initialize()
    self.components:initialize()

    call('setup')

    self.renderFrame = Image(W, H)

    self:toggleHelp()

    self:loadApp(readGlobalData('appName', 'default'))
end

function Engine:release()
    saveConfig()

    self.renderFrame:release()
    self.components:release()

    gc()
end

function Engine:run(appName)
    self.appName = self.appName or appName

    repeat

        self:initialize()

        self.active = 'running'

        local deltaTime = 0
        self.fpsTarget = 60

        self.frame_time:init()

        while self.active == 'running' do
            self.frame_time:update()

            deltaTime = deltaTime + self.frame_time.delta_time

            local maxDeltaTime = 1 / self.fpsTarget

            if deltaTime >= maxDeltaTime then
                --                if self.frame_time.delta_time >= maxDeltaTime then
                --                    self.fpsTarget = self.fpsTarget - 1
                --                else
                --                    self.fpsTarget = self.fpsTarget + 1
                --                end

                DeltaTime = deltaTime
                deltaTime = 0 -- deltaTime - maxDeltaTime

                ElapsedTime = self.frame_time.elapsed_time

                self:update(DeltaTime)
                self:draw()

                self.frame_time:draw()
            end
        end

        if type(self.active) == 'function' then
            self.active = self.active()
        end

        self:release()

    until self.active ~= 'restart'
end

function Engine:restart()
    self.active = 'restart'
end

function Engine:quit()
    self.active = 'stop'
end

function Engine:toggleRenderVersion()
    self.active = function ()
        config.glMajorVersion = toggle(config.glMajorVersion, 2, 4)
        return 'restart'
    end
end

function Engine:toggleHelp()
    self.showHelp = toggle(self.showHelp, false, true)
end

function Engine:update(dt)
    self.components:update(dt)

    if self.action then
        self.action()
    end

    self.app:__update(dt)
end

function Engine:preRender()    
    resetMatrix(true)
    resetStyle()

    setContext(self.renderFrame)
end

function Engine:draw()
    --    self:preRender()

    render(self.renderFrame, function ()
            self.app:__draw()

            if reporting then
                reporting:draw()
            end

            strokeWidth(1)
            stroke(gray)
            
            line(0, H/2, W, H/2)
            line(W/2, 0, W/2, H)
        end)

    self:postRender()

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
        info('debugging', debugging())
        info('compile', jit.status())
        info('arch', jit.arch)
        info('jit version', jit.version)
        info('opengl version', config.glMajorVersion)
        info('res', resourceManager.resources:getnKeys())
    end

    self:drawHelp()

    sdl:swap()
end

function Engine:postRender()
    Context.noContext()

    background(Color(0, 0, 0, 1))

    resetMatrix(true)
    resetStyle()

    ortho(0, W + W_INFO, 0, H)

    blendMode(NORMAL)

    depthMode(false)
    cullingMode('none')

    self.renderFrame:draw(W_INFO, 0, WIDTH, HEIGHT)
end

function Engine:drawHelp()
    if self.showHelp then
        fontSize(8)
        for k,v in pairs(self.onEvents.keydown) do
            info(k)
        end
    end
end
function Engine:keydown(key)
    if self.onEvents.keydown[key] then
        self.onEvents.keydown[key]()
    else
        self.app:__keyboard(key)
    end
end

function Engine:keyup(key)
    if self.onEvents.keyup[key] then
        self.onEvents.keyup[key](self)
    end
end

function Engine:touched(...)
    self.app:__touched(...)
end

function Engine:mouseWheel(...)
    self.app:__mouseWheel(...)
end

function Engine:dirApps(path)
    local apps = dir('./applications'..(path and ('/'..path) or ''))
    apps:apply(function (app)
            return app:lower():gsub('%.lua', '')
        end)
    apps:sort()
    return apps
end

function Engine:dirApps2(path)
    local apps = dirFile('./applications'..(path and ('/'..path) or ''))
    apps:apply(function (app)
            return app:lower():gsub('%.lua', '')
        end)
    apps:sort()
    return apps
end

function Engine:defaultApp()
    self:loadApp('default')
end

function Engine:managerApp()
    self:loadApp('appManager')
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

function Engine:loopApp(delay)
    if self.action then
        self.action = nil
    else
        self.loopAppRef = #self:dirApps()
        self.loopAppDelay = delay or 0

        self.action = callback(self, Engine.loopAppProc, delay)
    end
end

function Engine:loopAppProc(delay)
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

function Engine:loadApp(appName, reloadApp)
    self.appName = appName or self.appName
    self.appPath = 'applications/'..self.appName

    if (not exists(Path.sourcePath..'/'..self.appPath..'.lua') and
        not exists(Path.sourcePath..'/'..self.appPath..'/#.lua') and
        not exists(Path.sourcePath..'/'..self.appPath..'/main.lua'))
    then
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

    for i=1,2 do
        self:preRender()
        background(black)
        self:postRender()
        sdl:swap()
    end
end
