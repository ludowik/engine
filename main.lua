--os.name = 'ios'

require 'engine.#'

ffi.cdef([[
    void exit(int status);
]])


if ios then
    startDebug()
--    debug.sethook(function (...)
--            (__print__ or print)(debug.getinfo(2, 'S').short_src, ...)
--        end,
--        'l')
end

engine = Engine()

if love then
    love.run = function ()
        engine:initialize()

        return function ()
            engine:frame(true)
        end
    end

else
    engine:run()
end
