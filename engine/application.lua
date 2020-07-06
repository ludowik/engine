class 'Application'

function Application:init()
    _G.env.app = self

    self.scene = Scene()
    self.ui = UIScene()
end

function Application:__setup()
    self:setup()
end

function Application:__update(dt)
    self.scene:update(dt)
    self:update(dt)
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

function Application:__touched(...)
    if _G.env.touched then
        _G.env.touched(...)
    else
        self:touched(...)
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
end

function Application:collide(...)
end

function Application:touched(touch)
end

function application(name)
    local k = class(name)
    k:extends(Application)

    _G.env.appClass = k
end
