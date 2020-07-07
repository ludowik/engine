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
    
    self.dx = 0
    self.dy = 0

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

    mouse.dx = dx
    mouse.dy = dy

    mouse.isTouch = isTouch
    
    engine:touched(self)
end

mouse = Mouse()

CurrentTouch = mouse
