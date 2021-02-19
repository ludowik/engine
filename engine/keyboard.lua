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

    if love then
        BUTTON_LEFT = 'BUTTON_LEFT'
        BUTTON_MIDDLE = 'BUTTON_MIDDLE'
        BUTTON_RIGHT = 'BUTTON_RIGHT'
        BUTTON_X1 = 'BUTTON_X1'
        BUTTON_X2 = 'BUTTON_X2'        
    else
        BUTTON_LEFT = sdl.SDL_BUTTON_LEFT
        BUTTON_MIDDLE = sdl.SDL_BUTTON_MIDDLE
        BUTTON_RIGHT = sdl.SDL_BUTTON_RIGHT
        BUTTON_X1 = sdl.SDL_BUTTON_X1
        BUTTON_X2 = sdl.SDL_BUTTON_X2
    end
end

local keysState

function mapKey(key, reverse)
    if love then return key end
    
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
    return sdl:isDown(mapKey(key))
end

function isButtonDown(button)
    return sdl:isButtonDown(button)
end
