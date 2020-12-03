--os.name = 'ios'

require 'engine.#'

if ios then
    startDebug()
end

if hook then
    debug.sethook(function (...)
            local n = debug.getinfo(2, 'nfSlu');
            if n then
                (__print__ or print)(string.sub(n.source, 2)..':'..n.linedefined..':'..' ' ..(n.name or ''), ...)
            end
        end,
        'l')
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
