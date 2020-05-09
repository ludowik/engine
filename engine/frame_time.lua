class 'FrameTime' : extends(Component)

function FrameTime:init()
    Component.init(self)
    
    self.nframes = 0
    self.fps = 0

    self.start_time = 0
    self.end_time = 0

    self.delta_time = 0
    self.elapsed_time = 0

    self.one_second = 0
    self.delta_frames = 0
end

function FrameTime:update()
    self.nframes = self.nframes + 1
    self.delta_frames = self.delta_frames + 1

    self.end_time = sdl.SDL_GetTicks() * 0.001

    self.delta_time = self.end_time - self.start_time
    self.elapsed_time = self.elapsed_time + self.delta_time

    self.one_second = self.one_second + self.delta_time

    if self.one_second >= 1 then
        self.fps = self.delta_frames
        self.one_second = 0
        self.delta_frames = 0
    end

    self.start_time = self.end_time
end
