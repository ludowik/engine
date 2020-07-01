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
    if button == 1 then 
        button = sdl.SDL_BUTTON_LEFT
    elseif button == 2 then 
        button = sdl.SDL_BUTTON_RIGHT
    end
    return hasbit(sdl.SDL_GetMouseState(nil, nil), button)
end
