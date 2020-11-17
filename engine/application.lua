function application(name)
    local k = class(name)
    k:extends(Application)

    _G.env.appClass = k
end
App = application

class 'Application'

function Application:init()
    _G.env.app = self

    self.scene = Scene()
    self.scene.bgColor = color(51)

    self.ui = UIScene()
end

function Application:release()
    self.scene:clear()
end

function Application:suspend()
    self:pause()
end

function Application:pause()
    self.running = false
end

function Application:resume()
    self.running = true
end

function Application:pushScene(scene)
    local ref = tostring(self)..'.'..'scene'
    push(ref, self.scene)
    self.scene = scene
end

function Application:popScene()
    local ref = tostring(self)..'.'..'scene'
    self.scene = pop(ref)
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
                self:endCoroutine()
            end
        end
    end
end

function Application:endCoroutine()
end

function Application:__setup()
    if _G.env.setup then
        _G.env.setup()
    else
        self:setups()
    end
end

function Application:__update(dt)
    self.scene:update(dt)

    if _G.env.update then
        _G.env.update(dt)
        self:updateCoroutine(dt)
    else
        self:update(dt)
    end
end

function Application:__draw()
    if getCamera() then
        getCamera():setViewMatrix()
    end

    if _G.env.draw then
        _G.env.draw()
    else
        self:draw()
    end
end

function Application:__drawParameter()
    env.parameter:draw()
end

function Application:__keyboard(...)
    if _G.env.keyboard then
        return _G.env.keyboard(...)
    else
        return self:keyboard(...)
    end
end

function Application:__touched(...)
    if _G.env.touched then
        return _G.env.touched(...)
    else
        return self:touched(...)
    end
end

function Application:__mouseWheel(...)
    if _G.env.wheelmoved then
        return _G.env.wheelmoved(...)
    else
        return self:mouseWheel(...)
    end
end

function Application:__collide(...)
    if _G.env.collide then
        return _G.env.collide(...)
    else
        return self:collide(...)
    end
end

function Application:setup()
end

function Application:update(dt)
    self:updateCoroutine(dt)

    updateCamera(dt)

    self.scene:update(dt)
    self.ui:update(dt)
end

function Application:draw()
    self:render(self.scene)
    self:render(self.ui)
end

function Application:render(scene)
    pushMatrix()
    do
        resetMatrix(true)
        resetStyle()

        scene:layout()
        scene:draw()
    end
    popMatrix()
end

function Application:keyboard(key, isrepeat)
    if key == 'down' then
        self.ui:nextFocus()
    elseif key == 'up' then
        self.ui:previousFocus()
    elseif key == 'return' then
        if self.ui.focus then
            self.ui.focus:action()
        end
    else
        self.ui:keyboard(key, isrepeat)
    end
end

function Application:touched(touch)
    if not self.ui:touched(touch) then
        if not self.scene:touched(touch) then
        end
    end
end

function Application:mouseWheel(mouse)
    if not self.ui:wheelmoved(mouse) then
        if not self.scene:wheelmoved(mouse) then
        end
    end
end

function Application:collide(contact)
end

function Application:captureImage()
    local w = 256
    local h = floor(w * H / W)

    getRenderFrame():save(config.appPath:replace('/', '.'))
end

function Application:help()
    self:pushScene(Dialog('Help !!!!!!'))
end

class('Sketche', Application)

function Sketche:init()
    Application.init(self)
    if env.setup then
        env.setup()
    end
end

function Sketche:release()
    if env.release then
        env.release()
    else
        Application.release(self)
    end
end

function Sketche:suspend()
    if env.suspend then
        env.suspend()
    else
        Application.suspend(self)
    end
end

function Sketche:update(dt)
    if env.update then
        env.update(dt)
        self:updateCoroutine(dt)
    else
        Application.update(self, dt)
    end
end

function Sketche:draw()
    if env.draw then
        env.draw()
    else
        Application.draw(self)
    end
end

function Sketche:keyboard(key, isrepeat)
    if env.keyboard then
        env.keyboard(key, isrepeat)
    else
        Application.keyboard(self, key, isrepeat)
    end
end

function Sketche:touched(touch)
    if env.touched then
        env.touched(touch)
    else
        Application.touched(self, touch)
    end
end

function Sketche:wheelmoved(mouse)
    if env.wheelmoved then
        env.wheelmoved(mouse)
    else
        Application.wheelmoved(self, mouse)
    end
end

function Sketche:collide(contact)
    if env.collide then
        env.collide(contact)
    else
        Application.collide(self, contact)
    end
end
