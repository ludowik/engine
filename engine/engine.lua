class 'Engine'

function Engine:init()
    assert(engine == nil)
    engine = self

    loadConfig()

    ut.run()

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
    applicationManager = ApplicationManager()

    graphics = Graphics()

    self.info = Info()

    -- add components
    self.components = ComponentManager()
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

        self.components:add(RenderFrame)
        self.components:add(Profiler)

        self.components:add(self.info)
        self.components:add(self.frameTime)

        self.components:add(tween)

        tween.setup()
    end

    screen = Screen(W, H)
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

    call('setup')

    self.components:initialize()

    self:initEvents()

    if not ios then
        applicationManager:lastApp()
    else
        applicationManager:managerApp()
    end

    sdl:setCursor(sdl.SDL_SYSTEM_CURSOR_ARROW)
end

function Engine:release()
    saveConfig()

    self.envs = {}

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
end

function loop()
    env.app.drawFrame = nil
end

function redraw()
    env.app.drawFrame = 1
end

function noLoop()
    env.app.drawFrame = 1
end

function Engine:frame(forceDraw)
    sdl:event()

    if env.app.drawFrame then
        if env.app.drawFrame <= 0 then
            return
        end

        env.app.drawFrame = env.app.drawFrame - 1

        forceDraw = true
    end

    if ios and love then
        self.defaultRenderBuffer = gl.glGetInteger(gl.GL_RENDERBUFFER_BINDING)
        self.defaultFrameBuffer = gl.glGetInteger(gl.GL_FRAMEBUFFER_BINDING)
    end

    self.frameTime:update()

    if self.frameTime.deltaTimeAccum >= self.frameTime.deltaTimeMax or forceDraw or sdl.SDL_GL_GetSwapInterval() == 0 then

        DeltaTime = self.frameTime.deltaTimeAccum
        ElapsedTime = self.frameTime.elapsedTime

        self:update(DeltaTime)
        self:draw()

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
    Context.noContext()

    screen:resize(w, h)

    sdl:setWindowSize(screen)
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

function Engine:vsync()
    sdl.SDL_GL_SetSwapInterval(0)
end

function Engine:update(dt)
    self.components:update(dt)

    -- TODO : à gerer dans ComponentsManager
    if self.onEvents['update'] then
        self.onEvents['update'](dt)
    end

    -- TODO : à gerer dans ComponentsManager ?
    if applicationManager.action then
        applicationManager.action()
    elseif self.action then
        self.action()
    end

    env.parameter:update(dt)
    env.physics.update(dt)

    self.app:__update(dt)
end

function Engine:draw(f)
    self:preRender()

    self:postRender(
        function ()
            zLevel(0)

            if f then
                f()
            else
                self.app:__draw()
            end
        end,
        RenderFrame.getRenderFrame())

    self:postRender(
        function ()
            if f then return end

            if reporting then
                reporting:draw()
            end

            strokeWidth(1)
            stroke(1, 0.25)

            line(0, screen.H/2, screen.W, screen.H/2)
            line(screen.W/2, 0, screen.W/2, screen.H)

            self.app:__drawParameter()

            self.components:draw()
        end,
        engine.renderFrameInfo,
        true)

    local w, h = textSize(self.frameTime.fps)
    textMode(CENTER)
    text(self.frameTime.fps,
        screen.MARGE_X/2,
        screen.h - screen.MARGE_Y - h/2)

    sdl:swap()
end

function Engine:preRender()
    Context.noContext()
    background(transparent)
end

function Engine:postRender(f, renderFrame, resetBackground)
    assert(renderFrame)

    if resetBackground then
        renderFrame:background(transparent)
    end

    renderFunction(f, renderFrame)

    resetMatrix(true)

    Context.noContext()

    renderFrame:draw(
        screen.MARGE_X,
        screen.MARGE_Y,
        screen.W * screen.ratio,
        screen.H * screen.ratio)
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

function Engine:touched(_touch)
    if (_touch.x >= screen.MARGE_X and _touch.x <= screen.MARGE_X + screen.W * screen.ratio and
        _touch.y >= screen.MARGE_Y and _touch.y <= screen.MARGE_Y + screen.H * screen.ratio)
    then
        local touch = _touch:transform()

        if env.parameter:touched(touch) then
            return
        end

        if self.app:__touched(touch) then
            return
        end

        processMovementOnCamera(touch)
    end

    do
        local touch = _touch:clone()

        if touch.state == ENDED then
            if touch.x < screen.MARGE_X then
                if touch.y > screen.h * 2 / 3 then
                    self.info.infoHide = not self.info.infoHide

                elseif touch.y > screen.h * 1 / 3 then
                    engine:managerApp()

                else
                    ffi.C.exit(0)
                end

            elseif touch.x > screen.w - screen.MARGE_X then
                if touch.y > screen.h * 2 / 3 then
                    applicationManager:nextApp()

                elseif touch.y > screen.h * 1 / 3 then
                    applicationManager:previousApp()

                else
                    applicationManager:loopApp()
                end            
            end
        end
    end
end

function Engine:mouseMove(_touch)
    local touch = _touch:transform()
end

function Engine:mouseWheel(_touch)
    local touch = _touch:transform()
    if not env.parameter:mouseWheel(touch) then
        if not self.app:__mouseWheel(touch) then
            processWheelMoveOnCamera(touch)
        end
    end
end
