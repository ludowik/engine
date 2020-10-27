class 'Engine' : extends(ApplicationManager)

function Engine:init()
    assert(engine == nil)    
    engine = self

    self.envs = {}

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

    self.infoAlpha = 0
    self.infoHide = true

    if osx then
        W = W or 1480
        H = H or 1000

    elseif windows then
        W = W or 1024
        H = H or math.floor(W*9/16)

    elseif ios then
        if love then
            screen.w, screen.h = love.window.getMode()
        else
            H = 1024
            W = math.floor(H*9/16)
        end
    end

    WIDTH = W
    HEIGHT = H
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

function Engine:initialize()
    DeltaTime = 0
    ElapsedTime = 0

    self.components:initialize()
    self.frameTime:init()

    call('setup')

    self:initEvents()

    self.renderFrame = Image(W, H)

    self:toggleHelp()

    if not ios then
        self:lastApp()
    else
        self:managerApp()
    end

    sdl:setCursor(sdl.SDL_SYSTEM_CURSOR_ARROW)
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
    self.defaultRenderBuffer = gl.glGetInteger(gl.GL_RENDERBUFFER_BINDING)
    self.defaultFrameBuffer = gl.glGetInteger(gl.GL_FRAMEBUFFER_BINDING)

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

function Engine:portrait()
    if config.orientation == 'portrait' then return end

    config.orientation = 'portrait'

    self:resize(
        min(screen.w, screen.h),
        max(screen.w, screen.h))    
end

function Engine:landscape()    
    if config.orientation == 'landscape' then return end

    config.orientation = 'landscape'

    self:resize(
        max(screen.w, screen.h),
        min(screen.w, screen.h))
end

function Engine:flip()
    if screen.w > screen.h then
        self:portrait()
    else
        self:landscape()
    end
end

function Engine:wireframe()
    if config.wireframe == 'fill' then
        config.wireframe = 'line'

    elseif config.wireframe == 'line' then
        config.wireframe = 'fill&line'

    else
        config.wireframe = 'fill'
    end
end

function Engine:resize(w, h)
    screen.w, screen.h = w, h

    if screen.w > screen.h then
        W, H = max(W, H), min(W, H)
    else
        W, H = min(W, H), max(W, H)
    end

    sdl:setWindowSize()

    Context.noContext()
    if self.renderFrame then
        self.renderFrame:release()
    end

    self.renderFrame = Image(W, H)
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
        assert(false)
        return 'restart'
    end
end

function Engine:toggleHelp()
    self.showHelp = toggle(self.showHelp, false, true)
    if self.showHelp then
        self.infoHide = false
    end
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

    if self.infoHide then
        self.infoAlpha = 0 -- max(0, self.infoAlpha - dt / 3)
    else
        self.infoAlpha = 1
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
            self:drawInfo()
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
                (w or W) * screen.ratio,
                (h or H) * screen.ratio)
        end
        popMatrix()
    end
end

local function info(name, value)
    local info = name..' : '..tostring(value)
    local w, h = textSize(info)

    fill(white:alpha(engine.infoAlpha))
    rect(0, TEXT_NEXT_Y-h, w+10, h)

    fill(black:alpha(engine.infoAlpha))
    text(info)
end

function Engine:drawInfo()
    if self.infoAlpha == 0 then return end

    blendMode(NORMAL)

    depthMode(false)

    -- background
    noStroke()
    fill(white:alpha(self.infoAlpha))

    -- infos
    font(DEFAULT_FONT_NAME)
    fontSize(DEFAULT_FONT_SIZE)

    rectMode(CORNER)
    textMode(CORNER)

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
    info('wireframe', config.wireframe)
end

function Engine:drawHelp()
    if self.infoAlpha == 0 then return end

    if self.showHelp then
        fontSize(DEFAULT_FONT_SIZE)
        for k,v in pairs(self.onEvents.keydown) do
            info(k, v)
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
        self.onEvents.keyup[key]()
    end
end

function Engine:buttondown(button)
    if self.onEvents['buttondown'] then
        local f = self.onEvents['buttondown'][button]
        if f then
            f()
        end
    end
end

function Engine:buttonup(button)
    if self.onEvents['buttonup'] then
        local f = self.onEvents['buttonup'][button]
        if f then
            f()
        end
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
            if touch.y > H * 2 / 3 then
                self.infoHide = not self.infoHide

            elseif touch.y > H * 1 / 3 then
                engine:managerApp()

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
