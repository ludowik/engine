class 'Engine'

function Engine:init()
    assert(engine == nil)
    engine = self

    self.app = Application()

    self.active = 'start'

    self.memory = Memory()
    self.frame_time = FrameTime()

    self.components = Node()
    do
        self.components:add(self.memory)
        self.components:add(self.frame_time)
        self.components:add(Path())

        self.components:add(sdl)
        self.components:add(gl)
        self.components:add(ShaderManager())
        self.components:add(Graphics())
        self.components:add(ft)
--        self.components:add(self)
    end

    W = 1280
    H = math.floor(W*9/16)

    WIDTH = W
    HEIGHT = H

    self:initEvents()
end

function Engine:initEvents()
    self.onEvents = {
        keydown = {
            ['escape'] = Engine.quit,
            ['r'] = Engine.restart,
            ['m'] = Engine.changeMode,
            ['v'] = Engine.loopApp,
            ['n'] = Engine.nextApp,
            ['b'] = Engine.previousApp,
        }
    }
end

function Engine:setup()
    loadConfig()
    self.components:setup()
    evaluatePerf()
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

        while self.active == 'running' do
            self:update(self.frame_time.delta_time)
            self:draw()
        end

        if type(self.active) == 'function' then
            self.active = self.active()
        end

        self:release()

    until engine.active ~= 'restart'
end

function Engine:quit()
    self.active = 'stop'
end

function Engine:restart()
    self.active = 'restart'
end

function Engine:changeMode()
    self.active = function ()
        gl.majorVersion = toggle(gl.majorVersion, 2, 4)
        return 'restart'
    end
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

function Engine:draw()
    mode()

    resetMatrix()
    do
        if _G.env.draw then
            _G.env.draw()
        else
            draw()
        end
    end

    resetMatrix()
    blendMode(NORMAL)
    do
        stroke(white)

        text(self.frame_time.fps, 0, H)
        text(self.appName, 0, TEXT_NEXT_Y)
        text(format_ram(self.memory.ram.current), 0, TEXT_NEXT_Y)
        text(tostring(mouse), 0, TEXT_NEXT_Y)
        text(jit.status(), 0, TEXT_NEXT_Y)
        text(gl.majorVersion, 0, TEXT_NEXT_Y)
    end

    sdl:draw()
end

function Engine:keydown(key)
    if self.onEvents.keydown[key] then
        self.onEvents.keydown[key](self)
    end
end

function Engine:loopApp()
    self.action = self.nextApp
end

function Engine:nextApp()
    local files = dir('./applications')
    files:apply(function (file)
            return file:lower():gsub('%.lua', '')
        end)

    local nextAppIndex = 1
    for i,file in ipairs(files) do
        if file == self.appName then
            if i < #files then
                nextAppIndex = i + 1
                break
            end
        end
    end    

    local appName = files[nextAppIndex]
    self:loadApp(appName)
end

function Engine:previousApp()
    local files = dir('./applications')
    files:apply(function (file)
            return file:lower():gsub('%.lua', '')
        end)

    local previousAppIndex = #files
    for i,file in ipairs(files) do
        if file == self.appName then
            if i > 1 then
                previousAppIndex = i - 1
                break
            end
        end
    end    

    local appName = files[previousAppIndex]
    self:loadApp(appName)
end

function Engine:loadApp(appName, reloadApp)    
    self.appName = appName or self.appName
    self.appPath = 'applications.'..self.appName

    Engine.envs = Engine.envs or {}

    if Engine.envs[self.appPath] == nil or reloadApp then
        print('load '..self.appPath)

        Engine.envs[self.appPath] = {}

        local env = Engine.envs[self.appPath]
        _G.env = env

        setfenv(0, setmetatable(env, {__index=_G}))

        ___requireReload = true
        require(self.appPath)
        ___requireReload = false

        if env.appClass then
            env.app = env.appClass()
        else
            env.app = Application()
        end

        if _G.env.setup then
            _G.env.setup()
        else
            setup()
        end

    else
        print('switch '..self.appPath)

        local env = Engine.envs[self.appPath]
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
