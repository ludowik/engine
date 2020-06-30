class 'Engine'

function Engine:init()
    assert(engine == nil)

    engine = self
    engine.envs = engine.envs or {}

    ut.run()
    performance.run()

    self.app = Application()

    self.active = 'start'

    self.memory = Memory()
    self.frame_time = FrameTime()

    self.components = Node()
    do
        self.components:add(self.memory)
        self.components:add(Path())

        self.components:add(sdl)
        self.components:add(gl)
        self.components:add(ft)

        self.components:add(ShaderManager())
        self.components:add(Graphics())

        tween.setup()
    end

    W = 1280
    H = math.floor(W*9/16)

    WIDTH = W
    HEIGHT = H

    self:initEvents()

    self:toggleRenderMode()
    self:toggleHelp()
end

function Engine:initEvents()
    self.onEvents = {
        keydown = {
            ['r'] = Engine.restart,
            ['escape'] = Engine.quit,

            ['n'] = Engine.nextApp,
            ['b'] = Engine.previousApp,
            ['v'] = Engine.loopApp,

            ['f1'] = Engine.toggleHelp,

            ['f2'] = Engine.toggleRenderMode,
            ['f3'] = Engine.toggleRenderVersion,
        }
    }
end

function Engine:setup()
    loadConfig()
    self.components:setup()
    self:loadApp(self.appName)
end

function Engine:release()
    saveConfig()
    self.components:release()
    gc()
end

function Engine:run(appName)
    self.appName = self.appName or appName

    repeat

        self:setup()

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
        gl.majorVersion = toggle(gl.majorVersion, 2, 4)
        return 'restart'
    end
end

function Engine:toggleRenderMode()
    self.renderMode = toggle(self.renderMode, 'direct', 'frame')

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

    if _G.env.update then
        _G.env.update(dt)
    else
        update(dt)
    end
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

    do
        if _G.env.draw then
            _G.env.draw()
        else
            draw()
        end
    end

    self:postRender()

--    self:preRender()

    resetMatrix()
    resetStyle()

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
        info('compile', jit.status())
        info('arch', jit.arch)
        info('jit version', jit.version)
        info('opengl version', gl.majorVersion)
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
        log(string.format('no action for {key}', {key=key}))
    end
end

function Engine:loopApp()
    if self.action then
        self.action = nil
    else
        self.action = self.nextApp
    end
end

function Engine:dirApps()
    local apps = dir('./applications')
    apps:apply(function (app)
            return app:lower():gsub('%.lua', '')
        end)
    return apps
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
        log('load '..self.appPath)

        self.envs[self.appPath] = {}

        local env = self.envs[self.appPath]
        _G.env = env

        setfenv(0, setmetatable(env, {__index=_G}))

        ___requireReload = true
        require(self.appPath)
        ___requireReload = false

        if env.appClass then
            self.app = env.appClass()
        else
            self.app = Application()
        end

        app = self.app

        if _G.env.setup then
            _G.env.setup()
        else
            setup()
        end

    else
        log('switch '..self.appPath)

        local env = self.envs[self.appPath]
        _G.env = env
        setfenv(0, env)
    end
end

function setup()
    engine.app:__setup()
end

function update(dt)
    engine.app:__update(dt)
end

function draw()
    engine.app:__draw()
end

function collide(...)
    engine.app:__collide(...)
end
