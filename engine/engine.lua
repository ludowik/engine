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
end

function Engine:setup()
    setup()
end

function Engine:release()
    gc()
end

function Engine:run()
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
    update(dt)
end

function Engine:draw()
    mode()

    resetMatrix()
    do
        draw()
    end

    resetMatrix()
    do
        stroke(white)

        text(self.frame_time.fps, 0, 0)
        text(format_ram(self.memory.ram.current), 0, TEXT_NEXT_Y)
        text(tostring(mouse), 0, TEXT_NEXT_Y)
        text(jit.status(), 0, TEXT_NEXT_Y)
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
