function getCamera()
    return env.app and env.app.scene and env.app.scene.camera
end

function updateCamera(dt)
    local camera = getCamera()
    if camera then
        local dist = 10
        if isDown('up') or isDown('a')  then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                camera:processKeyboardMovement('up', dt)
            else
                camera:processKeyboardMovement('forward', dt)
            end
        end

        if isDown('down') or isDown('q') then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                camera:processKeyboardMovement('down', dt)
            else
                camera:processKeyboardMovement('backward', dt)
            end
        end

        if isDown('left') then
            camera:processKeyboardMovement('left', dt)
        end

        if isDown('right') then
            camera:processKeyboardMovement('right', dt)
        end
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
        if isDown(KEY_FOR_MOUSE_MOVING) then
            camera:moveSideward(touch.dx, DeltaTime)
            camera:moveUp(touch.dy, DeltaTime)
        else
            camera:zoom(0, touch.dy, DeltaTime)
        end
    end
end
