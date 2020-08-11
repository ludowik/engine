function setup()
    -- getFile()
    
    DEFAULT_FONT_NAME = 'Courier'
    DEFAULT_FONT_SIZE = 20
    
    H = HEIGHT
    W = WIDTH
    
    call('setup')
    
    displayMode(FULLSCREEN_NO_BUTTONS)
    
    app = App2048()
end

function draw()
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
