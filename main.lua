require 'engine.#'

engine = Engine()

if love then
    love.load = function()
        engine:initialize()
    end

    love.draw = function()
        engine:frame(true)
    end

else
    engine:run()
end
