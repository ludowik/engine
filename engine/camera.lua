-- TODO

-- camera
function updateCamera(dt)
    if lca.camera then
        local dist = 10
        if isDown('up') or isDown('a')  then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                lca.camera:processKeyboardMovement('up', dt)
            else
                lca.camera:processKeyboardMovement('forward', dt)
            end
        end

        if isDown('down') or isDown('q') then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                lca.camera:processKeyboardMovement('down', dt)
            else
                lca.camera:processKeyboardMovement('backward', dt)
            end
        end

        if isDown('left') then
            lca.camera:processKeyboardMovement('left', dt)
        end

        if isDown('right') then
            lca.camera:processKeyboardMovement('right', dt)
        end
    end
end

function processMovementOnCamera(touch)
    if lca.camera then
        lca.camera:processMouseMovement(touch)
    end
    --    app.scene.rotation = app.scene.rotation or vec3()
    --    app.scene.rotation = app.scene.rotation + vec3(touch.deltaX, touch.deltaY)
end

function processWheelMoveOnCamera(x, y)
    if lca.camera then
        if isDown(KEY_FOR_MOUSE_MOVING) then
            lca.camera:moveSideward(x, DeltaTime)
            lca.camera:moveUp(y, DeltaTime)
        else
            lca.camera:zoom(0, y, DeltaTime)
        end
    end
end

function mouseEvent(state, touchId, x, y, dx, dy, istouch, clicks)   
    if isButtonDown(1) or state == ENDED then
        if not parameter:touched(mouse) then
            env.app:touched(mouse)
            processMovementOnCamera(mouse)
        end        
    end
end

-- TODO
-- gravity simulation
function mouseEvent(state, touchId, x, y, dx, dy, istouch, clicks)   
    if isDown(KEY_FOR_ACCELEROMETER) then
        Gravity.x = Gravity.x + dx * 0.1
        Gravity.y = Gravity.y - dy * 0.1
    end
end

Keyboard.on(KEY_FOR_ACCELEROMETER, function(_, _, isrepeat)
        if not isrepeat then
            Gravity = vec3(0, -9.8, 0)
        end
    end)

Keyboard.onrelease(KEY_FOR_ACCELEROMETER, function()
        Gravity = vec3(0, -9.8, 0)
    end)