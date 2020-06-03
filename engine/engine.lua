class 'Engine'

function Engine:init()
    assert(engine == nil)
    engine = self

    self.app = Application()

    self.active = 'start'

    self.memory = Memory()
    self.frame_time = FrameTime()

    self.components = Node()

    self.components:add(self.memory)
    self.components:add(self.frame_time)

    self.components:add(sdl)
    self.components:add(gl)
    self.components:add(ShaderManager())
    self.components:add(ft)
    self.components:add(self)

    W = 1280
    H = math.floor(W*9/16)

    WIDTH = W
    HEIGHT = H

    self.onEvents = {
        keydown = {
            ['escape'] = Engine.quit,
            ['r'] = Engine.restart,
            ['n'] = Engine.nextApp,
        }
    }
end

function Engine:setup()
    evaluatePerf()
    self:loadApp(self.appName)
end

function Engine:release()
    gc()
end

function Engine:run(appName)
    self.appName = self.appName or appName

    self.components:setup()

    self.active = 'running'
    while self.active == 'running' do
        self.components:update(self.frame_time.delta_time)
        self.components:draw()            
    end

    self.components:release()

    if engine.active == 'restart' then
        gl.majorVersion = 2
        self:run()
    end
end

function Engine:restart()
    self.active = 'restart'
end

function Engine:quit()
    self.active = 'stop'
end

function Engine:update(dt)
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
    end
end

function Engine:keydown(key)
    if self.onEvents.keydown[key] then
        self.onEvents.keydown[key](self)
    end
end

function Engine:nextApp()
    local nextAppIndex = 1

    local files = dir('./applications')
    for i,file in ipairs(files) do
        local name = file:lower():gsub('%.lua', '')
        if name == self.appName then
            if i < #files then
                nextAppIndex = i + 1
                break
            end
        end
    end    

    local appName = files[nextAppIndex]:lower():gsub('%.lua', '')
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

        env.app = env.app and env.app() or Application()

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
