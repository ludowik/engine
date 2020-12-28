class('Mouse', vec2)

function Mouse.setup()
    BEGAN = 'began'
    MOVING = 'moving'
    ENDED = 'ended'
    CANCELLED = 'cancelled'
    
    mouse = Mouse()
    CurrentTouch = mouse
    
    mouse:attribs{
        id = 0,
        
        state = CANCELLED,
        
        x = 0,
        y = 0,
        
        deltaX = 0,
        deltaY = 0,
        
        totalX = 0,
        totalY = 0,
        
        istouch = 0
    }
end
