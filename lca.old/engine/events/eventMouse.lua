local systemTouch

function setupMouseMotion()
    BEGAN = 'began'
    MOVING = 'moving'
    ENDED = 'ended'
    CANCELLED = 'cancelled'

    CurrentTouch = Touch()
    systemTouch = Touch()

    mouseMotion(BEGAN, WIDTH/2, HEIGHT/2, 0, 0)
end

local id = 0

function lca.mousepressed(x, y, button, isTouch, presses)
    id = id + 1
    if button == 1 then
        mouseMotion(BEGAN, x, y, 0, 0, presses)
    elseif button == 4 then
        lca.pressed(button)
    end
end

function lca.mousemoved(x, y, dx, dy)
    if mouse.isDown(1) then
        mouseMotion(MOVING, x, y, dx, dy)
    end
end

function lca.mousereleased(x, y, button, isTouch, presses)
    if button == 1 then
        mouseMotion(ENDED, x, y, 0, 0, presses)
    end
end

function mouseMotion(state, x, y, dx, dy, presses)
    mouseMotionTouch(systemTouch, state,
        x,
        y,
        dx,
        dy, presses)

    if drawings then
        CurrentTouch = systemTouch:clone():translate(drawings[1])
    end

    lca.touched(systemTouch)
end

function mouseMotionTouch(touch, state, x, y, dx, dy, presses)
    local ratio = 1
    touch.id = id

    touch.prevState = touch.state
    touch.state = state

    if state == BEGAN then
        touch.totalX = 0
        touch.totalY = 0
    else
        touch.totalX = touch.totalX + dx / ratio
        touch.totalY = touch.totalY + dy / ratio
    end

    touch.prevX = touch.x
    touch.prevY = touch.y

    touch.x = x / ratio
    touch.y = screen.h - y / ratio

    touch.screenX = x / ratio
    touch.screenY = screen.h - y / ratio

    touch.deltaX =  dx / ratio
    touch.deltaY = -dy / ratio

    touch.tapCount = presses or 1
end

class('Touch', vector)

function Touch:init()
    vector.init(self)
end

function Touch:clone()
    return table.clone(self)
end

function Touch:translate(x, y, w, h, ratio)
    if type(x) == 'table' then
        local drawing = x
        x = drawing.x
        y = drawing.y
        w = drawing.w
        h = drawing.h
        ratio = drawing.ratio or 1
    end

    -- translate
    self.x = (self.x - x)
    self.y = (self.y - y)

    self.prevX = (self.prevX - x)
    self.prevY = (self.prevY - y)

    -- scale
    self.totalX = self.totalX * ratio
    self.totalY = self.totalY * ratio

    self.prevX = self.prevX * ratio
    self.prevY = self.prevY * ratio

    self.x = self.x * ratio
    self.y = self.y * ratio

    self.screenX = self.screenX * ratio
    self.screenY = self.screenY * ratio

    self.deltaX = self.deltaX * ratio
    self.deltaY = self.deltaY * ratio

    return self
end
