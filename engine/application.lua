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
    self.ui:clear()
    
    if _G.env.release then
        _G.env.release()
    end
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

function Application:updateCamera(dt)
    updateCamera(dt)
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

function Application:resize()
    if self.scene.resize then
        self.scene:resize()
    end
    if self.ui.resize then
        self.iu:resize()
    end
end

function Application:__update(dt)
    self:updateCoroutine(dt)
    self:updateCamera(dt)

    self.scene:update(dt)
    self.ui:update(dt)

    if _G.env.update then
        _G.env.update(dt)
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
        local res = _G.env.keyboard(...)
        if not res then
            return self:keyboard(...)
        end
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
        return self.ui:keyboard(key, isrepeat)
    end
end

function Application:touched(touch)    
    if not self.ui:touched(touch) then
        if not self.scene:touched(touch) then
            return false
        end
    end
    return true
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
