class 'Info'

function Info:init()
    self.infoHide = true
    self.infoAlpha = 0

    self.showHelp = false
end

function Info:toggleHelp()
    self.showHelp = toggle(self.showHelp, false, true)
    if self.showHelp then
        self.infoHide = false
    end
end

function Info:update()
    if self.infoHide then
        self.infoAlpha = 0 -- max(0, self.infoAlpha - dt / 3)
    else
        self.infoAlpha = 1
    end
end

function Info:drawInfo()
    if self.infoAlpha == 0 then return end

    -- background
    noStroke()
    fill(white:alpha(self.infoAlpha))

    -- infos
    font(DEFAULT_FONT_NAME)
    fontSize(DEFAULT_FONT_SIZE)

    rectMode(CORNER)
    textMode(CORNER)

    self:info('fps', engine.frameTime.fps..' / '..engine.frameTime.fpsTarget)
    self:info('fizix', formatPercent(env.physics.elapsedTime / ElapsedTime))
    self:info('os', jit.os)
    self:info('jit version', jit.version)
    self:info('debugging', debugging())
    self:info('compile', jit.status())
    self:info('ram', format_ram(engine.memory.ram.current))
    self:info('res', resourceManager.resources:getnKeys())
    self:info('mouse', mouse:transform())
    self:info('opengl version', config.glMajorVersion)
    self:info('wireframe', config.wireframe)
    self:info('light', config.light)
    self:info('bodies', #env.physics.bodies)
    self:info('projection', config.projectionMode)
end

function Info:drawHelp()
    if self.infoAlpha == 0 then return end

    if self.showHelp then
        fontSize(DEFAULT_FONT_SIZE)
        for k,v in pairs(engine.onEvents.keydown) do
            self:info(k, v)
        end
        for k,v in pairs(engine.onEvents.keyup) do
            self:info(k, v)
        end
    end
end

function Info:info(name, value)
    local info = name..' : '..tostring(value)
    local w, h = textSize(info)

    fill(white:alpha(self.infoAlpha))
    rect(0, TEXT_NEXT_Y-h, w+10, h)

    fill(black:alpha(self.infoAlpha))
    text(info)
end

function Info:draw()
    self:drawInfo()
    self:drawHelp()
end
