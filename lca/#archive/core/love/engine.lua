class('Engine')

function Engine:init()
end

function Engine:run(f)
    self:loop(f)
end

function Engine:loop(f)
    local runLoop = f or love.runLoop()
    while not lca.stop do
        love.graphics.setCanvas()
        love.restartParam = runLoop()
    end
end
