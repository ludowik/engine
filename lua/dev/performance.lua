performance = class 'Performance'

function Performance.evaluate(test, f, ...)
    local infos = {
        n = 1000,
        elapsedTime = 0,
        totalRam = 0
    }

    collectgarbage('stop')

    do
        for i=1,infos.n do
            local startTime = os.clock()
            local startRam = ram()
            do
                f(i, ...)
            end
            local endTime = os.clock()
            local endRam = ram()

            infos.elapsedTime = infos.elapsedTime + (endTime - startTime)
            infos.totalRam = infos.totalRam + (endRam - startRam)
        end
    end

    collectgarbage('restart')
    gc()

    infos.deltaTime = infos.elapsedTime / infos.n
    infos.deltaRam = infos.totalRam / infos.n

    print('====================================')
    print(test)
    print(string.format('elapsed time: %.9f (%s)', infos.elapsedTime, infos.totalRam))
    print(string.format('delta   time: %.9f (%s)', infos.deltaTime, infos.deltaRam))
    print()

    return infos
end

function Performance.compare(test, f1, f2, ...)
    Performance.evaluate(test, f1, ...)
    Performance.evaluate(test, f2, ...)
end

function Performance.test()
    Performance.evaluate('none',
        function (i)
        end)
end

function Performance.run()
    call('perf')
end
