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

    self.deltaX = 0
    self.deltaY = 0

    self.isTouch = false
end

function Mouse:__tostring()
    return self.x..', '..self.y..' ('..(self.isTouch and 'true' or 'false')..')'
end

function Mouse:mouseEvent(id, status, x, y, dx, dy, isTouch)
    mouse.id = id

    mouse.status = status

    mouse.x = x
    mouse.y = H - y

    mouse.deltaX = dx
    mouse.deltaY = dy

    mouse.isTouch = isTouch

    engine:touched(self)
end

function Mouse:mouseWheel(id, dx, dy)
    engine:mouseWheel(dx, dy)
end

mouse = Mouse()

CurrentTouch = mouse
