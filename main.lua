require 'engine.#'

engine = Engine()

--engine:on('keydown', 't',
--    function() 
--        engine:on('update', function() 
--                mouse:mouseEvent(0, ENDED, math.random(W), math.random(H), 0, 0, true, false)
--            end)
--    end)

engine:run()
