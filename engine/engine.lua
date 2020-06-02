class 'Engine'

function Engine:init()
    assert(engine == nil)
    engine = self

    self.app = Application()

    self.active = true

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
            ['n'] = Engine.nextApp
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
    self.appName = appName

    self.components:setup()

    while engine.active do
        self.components:update(self.frame_time.delta_time)
        self.components:draw()            
    end

    self.components:release()
end

function Engine:quit()
    engine.active = false
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

        text(self.frame_time.fps, 0, 0)
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
    self:loadApp(appNamed)
end

function Engine:loadApp(appName, reloadApp)    
    self.appName = appName
    self.appPath = 'applications.'..appName

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
