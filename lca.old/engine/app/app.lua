class('Application')

function Application:init()
    app = self

    app.scene = Scene()
    app.scenes = Table()

    app.ui = UIScene()

    camera(0, 0, 10)
end

function Application:suspend()
end

function Application:pause()
end

function Application:resume()
end

function Application:destroy()
    self.scene:clear()
end

function Application:updateCoroutine(dt)
    if self.coroutine then
        local status = coroutine.status(self.coroutine)
        if status ~= 'dead' then
            local res, error = coroutine.resume(self.coroutine, dt)
            if not res then
                assert(res, error)
            end
            status = coroutine.status(self.coroutine)
            if status == 'dead' then
                app:endCoroutine()
            end
        end
    end
end

function Application:endCoroutine()
end

function Application:update(dt)
    self:updateCoroutine(dt)

    updateCamera(dt)

    app.ui:update(dt)
    app.scene:update(dt)
end

function Application:draw()
    background(51)    

    resetStyle()
    resetMatrix(true)

    app.scenes:draw()

    app.scene:layout()
    app.scene:draw()

    resetStyle()
    resetMatrix(true)

    ortho()

    app.ui:layout()
    app.ui:draw()
end

function Application:pushScene(newScene)
    self.scenes:push(self.scene)
    self.scene = newScene
    newScene.app = self
    return newScene
end

function Application:popScene()
    if #self.scenes > 0 then
        self.scene.app = nil
        self.scene = self.scenes:pop()
        return self.scene
    end
end

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

function Application:contains(touch)
    return Rect(0, 0, WIDTH, HEIGHT):contains(touch)
end

function Application:touched(touch)
    if not app.ui:touched(touch) then
        if not app.scene:touched(touch) then
            app.scene:touchedAction(touch, app) 
        end
    end

    processMovementOnCamera(touch)
end

function Application:pressed(button)
    if button == 4 then
        appManager()
    end
end

function Application:wheelmoved(id, x, y)
    app.ui:wheelmoved(id, x, y)
    app.scene:wheelmoved(id, x, y)

    processWheelMoveOnCamera(x, y)
end

function Application:collide(contact)
end

function Application:keypressed(key)
    app.ui:keypressed(key)
end

function Application:keyreleased(key)
    app.ui:keypressed(key)
end

function Application:keydown(key)
    app.ui:keypressed(key)
end

function App(appName)
    _G.currentEnv.application = class(appName, Application)
    return _G.currentEnv.application
end
