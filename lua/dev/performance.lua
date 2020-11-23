performance = class 'Performance'

function Performance.timeit(test, f, ...)
    return Performance.__timeit(test, true, f, ...)
end

function Performance.__timeit(test, output, f, ...)
    local infos = {
        n = 10^3,
        elapsedTime = 0,
        totalRam = 0
    }

    -- white call
    f(0, ...)

    gc()
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

    if output then
        print('====================================')
        print(test)
        print(string.format('elapsed time: %.9f (%s)', infos.elapsedTime, infos.totalRam))
        print(string.format('delta   time: %.9f (%s)', infos.deltaTime, infos.deltaRam))
    end

    return infos
end

function Performance.compare(test, f1, f2, ...)
    local info1 = Performance.__timeit(test, false, f1, ...)
    local info2 = Performance.__timeit(test, false, f2, ...)
    print(info1.deltaTime < info2.deltaTime and 'first is the best' or 'second is the best')
    return info1.deltaTime < info2.deltaTime
end

function Performance.run()
    call('perf')
end

class 'perf_div2'
function perf_div2:perf()
    print('divide by 2 vs mul by 0.5')

    local a, b
    b = random() * 10^26

    Performance.timeit('divide by 2',
        function () 
            a = b / 2
        end)

    Performance.timeit('mul by 0.5',
        function () 
            a = b * 0.5
        end)
end
