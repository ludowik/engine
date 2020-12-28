local keyEvents = {
    ['keypressed'] = {},
    ['keyreleased'] = {},
    ['keydown'] = {}
}

function addEvent(eventType, key, f, ...)    
    keyEvents[eventType][key] = {
        f = f,
        args = {...}
    }
end

function dispatchEvent(eventType, key)
    local event = keyEvents[eventType][key]
    if event then
        event.f(unpack(event.args))
    else
        if app[eventType] then
            app[eventType](app, key)
        end
    end
end

function checkEvent(eventType)
    for key,f in pairs(keyEvents[eventType]) do
        if lca.keyboard.isDown(key) then
            dispatchEvent(eventType, key)
        end
    end
end

addEvent('keyreleased', 'escape', quit)
addEvent('keyreleased', 'r', restart)

addEvent('keyreleased', 'o', function ()
        toggleOrientation()
    end)

addEvent('keyreleased', 'm', function ()
        toggleScale()
    end)

addEvent('keyreleased', 'w', function ()
        config.wireFrame = not config.wireFrame
    end)

addEvent('keyreleased', 'c', appManager)
addEvent('keyreleased', 'v', loopApp)
addEvent('keyreleased', 'b', previousApp)
addEvent('keyreleased', 'n', nextApp)
addEvent('keyreleased', 'l', function ()
        config.light = not config.light
    end)

addEvent('keyreleased', 'p', function ()
        if config.projectionMode == 'perspective' then
            config.projectionMode = 'ortho'
        else
            config.projectionMode = 'perspective'
        end
    end)

addEvent('keyreleased', 'i', function ()
        config.logMode = not config.logMode
    end)

addEvent('keyreleased', 'tab', function ()
        local currentFocus = app.scene:getFocus()
        local nextFocus = nil
        local previousItem = app.scene

        if currentFocus then
            currentFocus.focus = false

            Table.scan(app.scene, 'nodes', function (v)
                    if previousItem == currentFocus then
                        nextFocus = v
                    end
                    previousItem = v
                end)
        end

        if nextFocus then
            nextFocus.focus = true
        else
            app.scene.focus = true
        end

        currentFocus = app.scene:getFocus()
        if currentFocus then
            print('_____________________________________')
            print('        className = '..currentFocus.className)
            print('verticalDirection = '..currentFocus.verticalDirection or 'none')
            print('         position = '..currentFocus.position:__tostring())
            print(' absolutePosition = '..currentFocus.absolutePosition:tostring())
            print('             size = '..currentFocus.size:tostring())
            print('       alignement = '..currentFocus.alignment)
        end
    end)

function lca.keypressed(key, scancode, isrepeat)
    dispatchEvent('keypressed', key)
end

function lca.keyreleased(key, scancode, isrepeat)
    dispatchEvent('keyreleased', key)
end

local mapKeys = {
    ['left shift'] = 'lshift'
}

function isDown(key)
    if mapKeys[key] then
        key = mapKeys[key]
    end
    return lca.keyboard.isDown(key)
end
