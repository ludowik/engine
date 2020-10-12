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
    self.frameTime = FrameTime()

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

    engine.infoAlpha = 0
    engine.infoHide = true

    if osx then
        W = W or 1480
        H = H or 1000

    elseif windows then
        W = W or 1024
        H = H or math.floor(W*9/16)

    elseif ios then
        if love then
            W, H = love.window.getMode()
        else
            H = 1024
            W = math.floor(H*9/16)
        end
    end

    WIDTH = W
    HEIGHT = H

    self:initEvents()
end

function Engine:on(event, key, callback)
    if not self.onEvents[event] then
        self.onEvents[event] = {}
    end

    if event == 'keydown' then
        self.onEvents[event][key] = callback

    elseif event == 'keyup' then
        self.onEvents[event][key] = callback

    else
        self.onEvents[event] = key
    end
end

function Engine:initEvents()
    self.onEvents = {
        keydown = {
            ['r'] = callback(self, Engine.restart),
            ['escape'] = callback(self, Engine.quit),

            ['t'] = scanTODO,

            ['d'] = callback(self, Engine.defaultApp),
            ['a'] = callback(self, Engine.managerApp),

            ['n'] = callback(self, Engine.nextApp),
            ['b'] = callback(self, Engine.previousApp),

            ['v'] = callback(self, Engine.loopApp, 0),
            ['c'] = callback(self, Engine.loopApp, 2),

            ['f1'] = callback(self, Engine.toggleHelp),
            ['f2'] = callback(self, Engine.toggleRenderVersion),

            ['f11'] = Sdl.toggleWindowDisplayMode,

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

            ['m'] = function ()
                initOS('ios')
                self:restart()
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

    engine:on('keydown', 't',
        function()
            engine:on('update', function()
                    mouse:mouseEvent(0, BEGAN, math.random(W), math.random(H), 0, 0, true, false)
                    mouse:mouseEvent(0, ENDED, math.random(W), math.random(H), 0, 0, false, false)
                end)
        end)
end

function Engine:initialize()
    DeltaTime = 0
    ElapsedTime = 0
    
    self.components:initialize()
    self.frameTime:init()

    call('setup')

    self.renderFrame = Image(W, H)

    self:toggleHelp()

    if not ios then
        self:lastApp()
    else
        self:managerApp()
    end

    sdl:setCursor(sdl.SDL_SYSTEM_CURSOR_ARROW)
    
    Context.noContext()
end

function Engine:release()
    saveConfig()

    if self.renderFrame then
        self.renderFrame:release()
    end

    self.components:release()

    gc()
end

function Engine:run(appPath)
    self.appPath = self.appPath or appPath

    repeat

        self:initialize()

        self.active = 'running'

        while self.active == 'running' do
            self:frame()
        end

        if type(self.active) == 'function' then
            self.active = self.active()
        end

        self:release()

    until self.active ~= 'restart'

    debugger.off()
end

function Engine:frame(forceDraw)
    engine.defaultRenderBuffer = gl.glGetInteger(gl.GL_RENDERBUFFER_BINDING)
    engine.defaultFrameBuffer = gl.glGetInteger(gl.GL_FRAMEBUFFER_BINDING)

    sdl:event()

    self.frameTime:update()

    if self.frameTime.deltaTimeAccum >= self.frameTime.deltaTimeMax or forceDraw then

        DeltaTime = self.frameTime.deltaTimeAccum
        ElapsedTime = self.frameTime.elapsedTime

        self:update(DeltaTime)

        self:draw()
        self.frameTime:draw()

        self.frameTime.deltaTimeAccum = (
            self.frameTime.deltaTimeAccum -
            math.floor(self.frameTime.deltaTimeAccum / self.frameTime.deltaTimeMax) * self.frameTime.deltaTimeMax)

    end
end

function Engine:resize(w, h, valeur)
    assert(not valeur)

    W = w
    H = h

    sdl.SDL_SetWindowSize(sdl.window, W, H)
end

function Engine:restart()
    self.active = 'restart'
end

function Engine:quit()
    self.active = 'stop'
end

function quit()
    engine:quit()
end

function exit(res)
    if res then
        print(res)
    end

    quit()
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

    if self.onEvents['update'] then
        self.onEvents['update'](dt)
    end

    if self.action then
        self.action()
    end

    if classnameof(env.physics) == 'physics' then
        env.physics.update(dt)
    elseif classnameof(env.physics) == 'fizix' then
        env.physics:update(dt)
    end

    if engine.infoHide then
        engine.infoAlpha = 0 -- max(0, engine.infoAlpha - dt / 3)
    else
        engine.infoAlpha = 1
    end

    self.app:__update(dt)
    env.parameter:update(dt)
end

function Engine:draw()
    background(red)

    render(self.renderFrame, function ()
            self.app:__draw()

            resetMatrix(true)
            resetStyle(NORMAL, false, false)

            if reporting then
                reporting:draw()
            end

            strokeWidth(1)
            stroke(1, 0.25)

            line(0, H/2, W, H/2)
            line(W/2, 0, W/2, H)
        end)

    self:postRender(screen.MARGE_X, screen.MARGE_Y)

    render(self.renderFrame, function ()
            self:drawInfo(engine.infoAlpha)
            self:drawHelp()
        end)

    self:postRender(screen.MARGE_X, screen.MARGE_Y)

    sdl:swap()
end

function Engine:postRender(x, y, w, h)
    if self.renderFrame then
        pushMatrix()
        do
            resetMatrix(true)
            resetStyle(NORMAL, false, false)

            Context.noContext()

            background(Color(0, 0, 0, 1))

            self.renderFrame:draw(
                x or 0,
                y or 0,
                w or W,
                h or H)
        end
        popMatrix()
    end
end

function Engine:drawInfo(alpha)
    if alpha == 0 then return end

    blendMode(NORMAL)

    depthMode(false)

    -- background
    noStroke()
    fill(white:alpha(alpha))

    -- infos
    font(DEFAULT_FONT_NAME)
    fontSize(DEFAULT_FONT_SIZE)

    rectMode(CORNER)
    textMode(CORNER)

    local function info(name, value)
        local info = name..' : '..tostring(value)
        local w, h = textSize(info)

        fill(white:alpha(alpha))
        rect(0, TEXT_NEXT_Y-h, w+10, h)

        fill(black:alpha(alpha))
        text(info)
    end

    info('fps', self.frameTime.fps)
    info('fps target', self.fpsTarget)
    info('opengl version', config.glMajorVersion)
    info('mouse', mouse)
    info('ram', format_ram(self.memory.ram.current))
    info('res', resourceManager.resources:getnKeys())
    info('os', jit.os)
    info('jit version', jit.version)
    info('debugging', debugging())
    info('compile', jit.status())
end

function Engine:drawHelp()
    if self.showHelp then
        fontSize(DEFAULT_FONT_SIZE)
        for k,v in pairs(self.onEvents.keydown) do
            info(k)
        end
    end
end
function Engine:keydown(key, isrepeat)
    if self.onEvents.keydown[key] then
        self.onEvents.keydown[key]()
    else
        self.app:__keyboard(key, isrepeat)
    end
end

function Engine:keyup(key)
    if self.onEvents.keyup[key] then
        self.onEvents.keyup[key](self)
    end
end

function Engine:touched(touch)
    if not env.parameter:touched(touch) then
        if not self.app:__touched(touch) then
            processMovementOnCamera(touch)
        end
    end

    if touch.state == ENDED then
        if touch.x < 0 then
            if touch.y > H / 2 then
                engine.infoHide = not engine.infoHide
            else
                ffi.C.exit(0)
            end

        elseif touch.x > W then
            if touch.y > H * 2 / 3 then
                engine:nextApp()

            elseif touch.y > H * 1 / 3 then
                engine:previousApp()

            else
                engine:loopApp()
            end            
        end
    end
end

function Engine:mouseMove(touch)
end

function Engine:mouseWheel(touch)
    if not env.parameter:mouseWheel(touch) then
        if not self.app:__mouseWheel(touch) then
            processWheelMoveOnCamera(touch)
        end
    end
end

function Engine:dir(path, method, recursivly)
    local apps = method(path or '', recursivly)
    apps:apply(function (app)
            return app:gsub('%.lua', '')
        end)
    apps:sort()
    return apps
end

function Engine:dirApps(path, recursivly)
    return self:dir(path or 'applications', dirApps, recursivly)
end

function Engine:dirFiles(path, recursivly)
    return self:dir(path, dirFiles, recursivly)
end

function Engine:dirDirectories(path, recursivly)
    return self:dir(path, dirDirectories, recursivly)
end
