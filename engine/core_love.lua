if arg[#arg] == "-debug" then
    require("mobdebug").start()
end

function love.load()
    major, minor, revision, codename = love.getVersion()
    print(codename..' '..major..'.'..minor..'.'..revision)

    love.window.setMode(1024, 800)

    transform = love.math.newTransform()

    Engine()
    engine:setup(love.window.getMode())


    engine.quit = decore(engine.quit, function ()
            love.event.quit()
        end)
end

function love.quit()
    engine:release()
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()
    engine.fps = love.timer.getFPS()    
    engine:draw()
end

function love.keypressed(key, scancode, isrepeat)
    engine:keydown(key)
--    if key == 'escape' then
--        love.event.quit()
--    elseif key == 'r' then
--        love.event.quit('restart')
--    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    mouse.x = x
    mouse.y = y

    mouse.dx = dx
    mouse.dy = dy

    mouse.istouch = istouch
end
