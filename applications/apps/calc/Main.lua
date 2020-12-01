function setup()
    H = HEIGHT
    W = WIDTH

    displayMode(FULLSCREEN_NO_BUTTONS)

    app = AppCalc()
end

function draw()
    app:update(DeltaTime)
    app:draw()
end

function touched(touch)
    if touch.state == BEGAN then
        beganPos = touch.pos
    end

    mouse = {
        id = touch.id,

        state = touch.state,

        pos = touch.position,

        x = touch.x,
        y = touch.y,

        deltaX = touch.delta.x,
        deltaY = touch.delta.y,

        totalX = touch.x - beganPos.x,
        totalY = -(touch.y - beganPos.y),
    }
    app:touched(mouse)
end
