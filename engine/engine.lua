class 'Engine'

function Engine:init()
    assert(engine == nil)
    engine = self

    self.ram = {
        init = ram()
    }
    self.ram.current = self.ram.init
    self.ram.min = self.ram.init
    self.ram.max = self.ram.init
    self.ram.release = self.ram.init

    self.app = Application()
    self.nFrame = 1
end

function Engine:release()
    self.app = nil

    gc()

    self.ram.release = ram()

    print('memory at init    : '..format_ram(self.ram.init))
    print('memory min        : '..format_ram(self.ram.min))
    print('memory max        : '..format_ram(self.ram.max))
    print('memory variation  : '..format_ram(self.ram.max - self.ram.min))
    print('memory at release : '..format_ram(self.ram.release))
end

function Engine:run()
    self:setup(1024, 768)

    engine.window, engine.context = sdl_init()
    opengl_init()
    
    initShaders()
    
    engine.active = true
    
    while engine.active do

        sdl_events()
        
        mode()

        self:update(1)
        self:draw()

        sdl.SDL_GL_SwapWindow(engine.window)
    end

    releaseShaders()
    
    opengl_release()
    sdl_release(engine.window, engine.context)

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
    
    self.ram.min = math.min(self.ram.min, self.ram.current)
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
        text(format_ram(self.ram.current), 0, 32)
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
