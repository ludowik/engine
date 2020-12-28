class('Codea', Application)

function Codea:init()
    Application.init(self)
    if _G.currentEnv.setup then
        _G.currentEnv.setup()
    end
end

function Codea:suspend()
    if _G.currentEnv.suspend then
        _G.currentEnv.suspend()
    end
end

function Codea:resume()
    if _G.currentEnv.resume then
        _G.currentEnv.resume()
    end
end

function Codea:update(dt)
    if _G.currentEnv.update then
        self:updateCoroutine(dt)
        _G.currentEnv.update(dt)
    else
        Application.update(app, dt)
    end
end

function Codea:draw()
    if _G.currentEnv.draw then
        _G.currentEnv.draw()
    else
        Application.draw(app)
    end
end

function Codea:touched(touch)
    if _G.currentEnv.touched then
        _G.currentEnv.touched(touch)
    else
        Application.touched(app, touch)
    end
end

function Codea:keypressed(key)
    if _G.currentEnv.keypressed then 
        _G.currentEnv.keypressed(key)
    else
        Application.keypressed(app, key)
    end
end

function Codea:keyreleased(key)
    if _G.currentEnv.keyreleased then 
        _G.currentEnv.keyreleased(key)
    else
        Application.keyreleased(app, key)
    end
end

function Codea:keydown(key)
    if _G.currentEnv.keydown then 
        _G.currentEnv.keydown(key)
    else
        Application.keydown(app, key)
    end
end

function Codea:collide(contact)
    if _G.currentEnv.collide then
        _G.currentEnv.collide(contact)
    else
        Application.collide(contact)
    end
end
