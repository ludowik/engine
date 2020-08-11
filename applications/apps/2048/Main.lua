function setup()
    -- getFile()
    
    DEFAULT_FONT_NAME = 'ArialMT'
    DEFAULT_FONT_SIZE = 20
    
    H = HEIGHT
    W = WIDTH
    
    call('setup')
    
    displayMode(FULLSCREEN_NO_BUTTONS)
    
    app = App2048()
end

function draw()
    app.scene:layout()
    app.scene:draw()
end

function touched(touch)
    if touch.y < 100 then
        close()
    end
    
    local button = app.scene:touched(touch)
    if button then
        
    end
end
