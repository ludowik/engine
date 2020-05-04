class 'Application'

function Application:init()
    self.scene = Scene()
end

function Application:__setup()
    self:setup()
end

function Application:__update(dt)
    self.scene:update(dt)
    self:update()
end

function Application:__draw()
    self.scene:draw()
    self:draw()
end

function Application:setup()
end

function Application:update(dt)
end

function Application:draw()
end
