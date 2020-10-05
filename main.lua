require 'engine.#'

ffi.cdef([[
    void exit(int status);
]])

decorate('error', function (f, ...)
        __error__(...)
        ffi.C.exit(0)
    end)

decorate('assert', function (f, value, ...)
        if not value then
            __assert__(value, ...)
            ffi.C.exit(0)
        end
    end)

-- TODEL
--if not string.lower(arg[1]):find('love') then
--    os.execute('cd /Users/Ludo/Projets/Lua/engine && zip -9 -r -u /Users/Ludo/Projets/Libraries2/love-11.3-ios-source/platform/xcode/applications.love .')
--end

if love then
    engine = Engine()

    if not ios then
        engine:run()

        function love.run()
            return nil
        end
    else
        engine:initialize()

        love.draw = function ()
            engine:frame(true)
        end
    end

else
    engine = Engine()
    engine:run()
end
