class('Keys')

local mapKeysReverse = {}
local mapKeys = {
    ['lshift'] = 'left shift',
    ['lctrl'] = 'left ctrl'
}

function Keys.setup()
    for k,v in pairs(mapKeys) do
        mapKeysReverse[v] = k
    end

    BUTTON_LEFT = sdl.SDL_BUTTON_LEFT
    BUTTON_MIDDLE = sdl.SDL_BUTTON_MIDDLE
    BUTTON_RIGHT = sdl.SDL_BUTTON_RIGHT
    BUTTON_X1 = sdl.SDL_BUTTON_X1
    BUTTON_X2 = sdl.SDL_BUTTON_X2
end

local keysState

function mapKey(key, reverse)
    if reverse then
        if mapKeysReverse[key] then
            return mapKeysReverse[key]
        end
    else
        if mapKeys[key] then
            return mapKeys[key]
        end
    end
    return key
end

function isDown(key)
    key = mapKey(key)

    keysState = sdl.SDL_GetKeyboardState(nil)

    local scanCode = sdl.SDL_GetScancodeFromName(key)
    return keysState[scanCode] == 1 and true or false
end

function isButtonDown(button)
    return hasbit(sdl.SDL_GetMouseState(nil, nil), 2^(button-1))
end
