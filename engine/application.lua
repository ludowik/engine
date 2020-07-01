class 'Application'

function Application:init()
    app = self
    
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
    self:draw()

    resetMatrix()
    self.scene:draw()
end

function Application:__collide(...)
    self:collide(...)
end

function Application:setup()
end

function Application:update(dt)
end

function Application:draw()
    background(black)
end

function Application:collide(...)
end

function application(name)
    local k = class(name)
    k:extends(Application)
    
    _G.env.appClass = k
end
