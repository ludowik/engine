class 'Mouse'

BEGAN = 'began'
MOVING = 'moving'
ENDED = 'ended'
CANCELLED = 'cancelled'

function Mouse:init()
    self.id = 0

    self.status = CANCELLED

    self.x = 0
    self.y = 0

    self.position = vec2()

    self.deltaX, self.dx = 0, 0
    self.deltaY, self.dy = 0, 0

    self.totalX = 0
    self.totalY = 0

    self.isTouch = false

    self.tapCount = 0
end

function Mouse:__tostring()
    return self.x..', '..self.y..' ('..(self.isTouch and 'true' or 'false')..')'
end

function Mouse:mouseMove(id, state, x, y, dx, dy, isTouch, tapCount)
    mouse.id = id

    mouse.state = state

    mouse.x = x - W_INFO
    mouse.y = H - y

    self.position:set(mouse.x, mouse.y)

    mouse.deltaX, mouse.dx = dx, dx
    mouse.deltaY, mouse.dy = dy, dy

    if state == BEGAN then
        self.totalX = 0
        self.totalY = 0
    else
        self.totalX = self.totalX + dx
        self.totalY = self.totalY + dy
    end
    
    mouse.isTouch = isTouch

    mouse.tapCount = tapCount or 1

    if isDown(KEY_FOR_ACCELEROMETER) then
        Gravity.x = Gravity.x + dx * 0.1
        Gravity.y = Gravity.y - dy * 0.1
    end
end

function Mouse:mouseEvent(id, state, x, y, dx, dy, isTouch, tapCount)
    self:mouseMove(id, state, x, y, dx, dy, isTouch, tapCount)
    engine:touched(mouse)
end

function Mouse:mouseWheel(id, dx, dy)
    mouse.id = id

    mouse.deltaX, mouse.dx = dx, dx
    mouse.deltaY, mouse.dy = dy, dy

    engine:mouseWheel(mouse)
end

mouse = Mouse()

CurrentTouch = mouse
