class('Keyboard')

function Keyboard.setup()
    Keyboard.actions = {
        keypressed = {            
        },
    
        keyreleased = {            
        },
    }
end

function Keyboard.on(key, f)
    Keyboard.actions.keypressed[key] = f
end

function Keyboard.onrelease(key, f)
    Keyboard.actions.keyreleased[key] = f
end

function Keyboard.keypressed(key, scancode, isrepeat)
    (Keyboard.actions['keypressed'][key] or doNothing)(key, scancode, isrepeat)
end

function Keyboard.keyreleased(key, scancode, isrepeat)
    (Keyboard.actions['keyreleased'][key] or doNothing)(key, scancode, isrepeat)
end
