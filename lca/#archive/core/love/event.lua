local mapKeys = {
    ['left shift'] = 'lshift',
    ['left control'] = 'lctrl'
}

function isDown(key)
    if mapKeys[key] then
        key = mapKeys[key]
    end
    return love.keyboard.isDown(key)
end

function isButtonDown(button)
    return love.mouse.isDown(button or 1)
end
