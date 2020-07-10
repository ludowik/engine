class 'Application'

function Application:init()
    _G.env.app = self

    self.scene = Scene()
    self.ui = UIScene()
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
    else
        self:update(dt)
    end
end

function Application:__draw()
    if _G.env.draw then
        _G.env.draw()
    else
        self:draw()
    end
end

function Application:__collide(...)
    if _G.env.collide then
        _G.env.collide(...)
    else
        self:collide(...)
    end
end

function Application:__keyboard(...)
    if _G.env.keyboard then
        _G.env.keyboard(...)
    else
        self:keyboard(...)
    end
end

function Application:__touched(...)
    if _G.env.touched then
        _G.env.touched(...)
    else
        self:touched(...)
    end
end

function Application:__mouseWheel(...)
    if _G.env.mouseWheel then
        _G.env.mouseWheel(...)
    else
        self:mouseWheel(...)
    end
end

function Application:setup()
end

function Application:update(dt)
end

function Application:draw()
    background(black)
    
    resetMatrix()
    resetStyle()
    
    self.scene:draw()
    self.ui:draw()
    
    parameter:draw()
end

function Application:collide(...)
end

function Application:keyboard(key)
end

function Application:touched(touch)
end

function Application:mouseWheel(dx, dy)
end

function application(name)
    local k = class(name)
    k:extends(Application)

    _G.env.appClass = k
end
