function love.conf(t)
    t.accelerometerjoystick = true
end

function love.load()
    lca.setup()
end

function love.run()
    return function () return love.restartParam end
end

function love.runLoop()
    if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    return function()
        -- Process events.
        if love.event then
            love.event.pump()
            for name, a,b,c,d,e,f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a or 0
                    end
                end
                love.handlers[name](a,b,c,d,e,f)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then dt = love.timer.step() end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            if love.draw then love.draw() end

            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end

function love.update(dt)
    lca.update(dt)    
end

-- TODO : aligner lca.draw et love.draw
function love.draw()
    if renderFrame then
        love.graphics.setCanvas({
                renderFrame:getContext(),
                depthstencil = true,
                depth = true
            })
    end

    lca.draw()
    
    Profiler:update(dt)

    if renderFrame then
        love.graphics.reset()

        renderFrame:resetContext()

        ortho(0, W + W_INFO, 0, H)

        spriteMode(CORNER)
        renderFrame:draw(W_INFO, 0, WIDTH, HEIGHT)
    end

    lca.drawInfo()
end

function love.keypressed(key, scancode, isrepeat)
    lca.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    lca.keyreleased(key, scancode)
end

function love.mousepressed(x, y, istouch)
    lca.mouseEvent(BEGAN, 1, x, y, 0, 0, istouch)
end

function love.mousemoved(x, y, dx, dy, istouch)
    lca.mouseEvent(MOVING, 1, x, y, dx, dy, istouch)
end

function love.mousereleased(x, y, istouch)
    lca.mouseEvent(ENDED, 1, x, y, 0, 0, istouch)
end


function love.wheelmoved(id, x, y)
    lca.wheelmoved(id, x, y)
end
