local keysState
function isDown(key)
    keysState = keysState or sdl.SDL_GetKeyboardState(NULL)
    local scanCode = sdl.SDL_GetScancodeFromName(key)
    return keysState[scanCode] == 1 and true or false
end
