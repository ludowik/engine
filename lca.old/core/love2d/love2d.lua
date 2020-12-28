function love.conf(t)
    t.accelerometerjoystick = true
end

function love.load(...)
    return lca.load(...)
end

function love.update(...)
    return lca.update(...)
end

function love.draw(...)
    return lca.draw(...)
end

function love.touched(...)
    return lca.touched(...)
end

function love.wheelmoved(...)
    return lca.wheelmoved(...)
end

function love.keypressed(...)
    return lca.keypressed(...)
end

function love.keyreleased(...)
    return lca.keyreleased(...)
end

function love.mousepressed(...)
    return lca.mousepressed(...)
end

function love.mousemoved(...)
    return lca.mousemoved(...)
end

function love.mousereleased(...)
    return lca.mousereleased(...)
end
