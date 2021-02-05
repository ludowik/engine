function getCamera()
    return env.app and env.app.scene and env.app.scene.camera
end

function updateCamera(dt)
    local camera = getCamera()
    if camera then
        camera:update(dt)
    end
end

function processMovementOnCamera(touch)
    local camera = getCamera()
    if camera then
        camera:processMouseMovement(touch)
    end
end

function processWheelMoveOnCamera(touch)
    local camera = getCamera()
    if camera then
        camera:processWheelMoveOnCamera(touch)
    end
end
