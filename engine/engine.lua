class 'Engine'

function Engine:init()
    assert(engine == nil)
    engine = self

    self.ram = {
        init = ram(),
        current = 0,
        max = 0,
        release = 0
    }

    self.app = Application()
    self.nFrame = 1
end

function Engine:release()
    self.app = nil

    gc()

    self.ram.release = ram()

    function format_ram(ram)
        return string.format('%.2f mo', ram / 1024 / 1024)
    end

    print('memory at init    : '..format_ram(self.ram.init))
    print('memory at max     : '..format_ram(self.ram.max))
    print('memory at release : '..format_ram(self.ram.release))
end

function Engine:run()
    self:setup(1024, 768)


    engine.window, engine.context = sdl_init()

    engine.active = true

    while engine.active do

        sdl_events()

        self:update(1)
        self:draw()

        sdl.SDL_RenderPresent(context)
    end

    sdl_release(window, context)

    self:release()
end

function Engine:quit()
    engine.active = false
end

function Engine:setup(w, h)
    W, H = w, h
    setup()
end

function Engine:update(dt)
    self.ram.current = ram()
    self.ram.max = math.max(self.ram.max, self.ram.current)

    update(dt)
end

function Engine:draw()
    self.nFrame = self.nFrame + 1

    resetMatrix()
    do
        draw()
    end

    resetMatrix()
    do
        text(self.fps, 0, 0)
        text(self.ram.current, 0, 32)
        text(self.nFrame, 0, 64)
        text(tostring(mouse), 0, 96)
    end
end

function Engine:keydown(key)
    if key == 'escape' then
        self.quit()
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
