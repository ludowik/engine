function perf(test, f, ...)
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

    print("====================================")
    print(test)
    print(string.format("elapsed time: %.9f (%s)", infos.elapsedTime, infos.totalRam))
    print(string.format("delta   time: %.9f (%s)", infos.deltaTime, infos.deltaRam))
    print()

    return infos
end

function evaluatePerf()
    perf('none', 
        function (i)
        end)

    perf('create matrix', 
        function (i)
            matrix(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
        end)

    perf('create and set matrix', 
        function (i, m)
            m:set(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
        end,
        matrix())
    
    perf('multiply matrix',
        function (i, m1, m2)
            local m = m1 * m2
        end,
        matrix(), matrix())
end
