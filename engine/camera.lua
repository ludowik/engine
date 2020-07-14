-- TODO

-- camera
function updateCamera(dt)
    if engine.camera then
        local dist = 10
        if isDown('up') or isDown('a')  then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                engine.camera:processKeyboardMovement('up', dt)
            else
                engine.camera:processKeyboardMovement('forward', dt)
            end
        end

        if isDown('down') or isDown('q') then
            if isDown(KEY_FOR_MOUSE_MOVING) then
                engine.camera:processKeyboardMovement('down', dt)
            else
                engine.camera:processKeyboardMovement('backward', dt)
            end
        end

        if isDown('left') then
            engine.camera:processKeyboardMovement('left', dt)
        end

        if isDown('right') then
            engine.camera:processKeyboardMovement('right', dt)
        end
    end
end

function processMovementOnCamera(touch)
    if engine.camera then
        engine.camera:processMouseMovement(touch)
    end
    --    app.scene.rotation = app.scene.rotation or vec3()
    --    app.scene.rotation = app.scene.rotation + vec3(touch.deltaX, touch.deltaY)
end

function processWheelMoveOnCamera(x, y)
    if engine.camera then
        if isDown(KEY_FOR_MOUSE_MOVING) then
            engine.camera:moveSideward(x, DeltaTime)
            engine.camera:moveUp(y, DeltaTime)
        else
            engine.camera:zoom(0, y, DeltaTime)
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

-- TODO
--Keyboard.on(KEY_FOR_ACCELEROMETER, function(_, _, isrepeat)
--        if not isrepeat then
--            Gravity = vec3(0, -9.8, 0)
--        end
--    end)

--Keyboard.onrelease(KEY_FOR_ACCELEROMETER, function()
--        Gravity = vec3(0, -9.8, 0)
--    end)