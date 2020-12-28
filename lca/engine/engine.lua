class('Engine')

function Engine:init()
    sdl:loadLib()

    gl:loadLib()
    al:loadLib()

    lca.setup()
end

function Engine:run(f)
    self:loop(f)
    system.release()
end

function Engine:loop(f)
    ElapsedTime = 0

    self.currentTime = system.getTime()
    self.previousTime = self.currentTime
    self.nextTime = self.currentTime

    lca.frame = 0

    assert(sdl.SDL_SetThreadPriority(sdl.SDL_THREAD_PRIORITY_HIGH)==0)

    local runLoop = self.runLoop
    while not lca.stop do
        runLoop(self, f)
    end
end

function Engine:runLoop(f)
    self.currentTime = system.getTime()
    local dt = self.currentTime - self.previousTime
    self.previousTime = self.currentTime

    local redraw = false
    if config.framerate == 60 then
        system.frameSyncMode(config.frameSync)
        redraw = true
    else
        system.frameSyncMode(false)

        if self.nextTime <= self.currentTime then
            local dt = 1 / config.framerate
            self.nextTime = self.currentTime + dt * 0.98
            redraw = true
        end
    end

    system.processEvents()

    if redraw and not isButtonDown(sdl.SDL_BUTTON_RIGHT) then
        Context.noContext()
        background()

        if f then
            f()
        else
            if renderFrame then
                setContext(renderFrame)
            else
                Context.noContext()
            end

            lca.update(dt)
            lca.draw()

            line(0, HEIGHT/2, WIDTH, HEIGHT/2)
            line(WIDTH/2, 0, WIDTH/2, HEIGHT)
            
            Profiler:update(dt)

            if renderFrame then
                Context.noContext()
                ortho(0, W + W_INFO, 0, H)

                if mouse.x < 0 then
                    tint(white)
                    renderFrame:draw(W_INFO, 0, WIDTH, HEIGHT)

                    lca.drawInfo()

                else
                    clip(0, 0, W_INFO, HEIGHT)
                    lca.drawInfo()
                    noClip()

                    tint(white)
                    renderFrame:draw(W_INFO, 0, WIDTH, HEIGHT)
                end
            end

            if lca.nextAppPath then
                lca.loadApp(lca.nextAppPath)
                lca.nextAppPath = nil
                loop()
            end
        end
        system.swap()
    end
end
