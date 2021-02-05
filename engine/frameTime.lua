class 'FrameTime' : extends(Component)

function FrameTime:initialize()
    Component.init(self)

    self.nframes = 0

    self.fps = 0
    self.fpsTarget = 60

    self.startTime = 0
    self.endTime = 0

    self.deltaTime = 0
    self.deltaTimeAccum = 0
    self.deltaTimeMax = 1/self.fpsTarget

    self.elapsedTime = 0

    self.oneSecond = 0
    self.deltaFramesBySecond = 0
end

function FrameTime:__update()
    self.startTime = sdl.getTicks() * 0.001

    self.__update = function (self, ...)
        self.endTime = sdl.getTicks() * 0.001

        self.deltaTime = self.endTime - self.startTime
        self.deltaTimeAccum = self.deltaTimeAccum + self.deltaTime

        self.elapsedTime = self.elapsedTime + self.deltaTime

        self.oneSecond = self.oneSecond + self.deltaTime

        if self.oneSecond >= 1 then
            self.fps = self.deltaFramesBySecond
            self.oneSecond = 0
            self.deltaFramesBySecond = 0
        end

        self.startTime = self.endTime
    end

    self:__update()
end

function FrameTime:__draw()
    self.nframes = self.nframes + 1
    self.deltaFramesBySecond = self.deltaFramesBySecond + 1

    if self.deltaTime > 1/35 then
        self.fpsTarget = 30
    elseif self.deltaTime < 1/65 then
        self.fpsTarget = 60
    end
    
    self.deltaTimeMax = 1/self.fpsTarget
end
