class('Reporting')

function Reporting:init()
    self.dashboard1 = Dashboard(Profiler.functions,
        {
            'name',

            'frame.count',

            'frame.time',
            'frame.percentTimeInto',
            'frame.percentTimeUnder',

            'frame.memory',
            'frame.percentMemoryInto',
            'frame.percentMemoryUnder',

            'stat.averageTime',
            'stat.averageMemory',

            'last.time',
            'last.memory',

            'callers'
        },

        {
            count = formatInteger,

            time = formatNumber,

            percentTimeInto = formatPercent,
            percentTimeUnder = formatPercent,

            memory = convertMemory,

            percentMemoryInto = formatPercent,
            percentMemoryUnder = formatPercent,

            averageTime = formatNumber,
            averageMemory = convertMemory,

            lastTime = formatNumber,
            lastMemory = convertMemory,
        })

    self.dashboard1:setSortFunction(function (a,b)
            astat = a.frame
            bstat = b.frame

            if a.focusOn == b.focusOn then
                if astat.memory == bstat.memory then
                    if astat.time == bstat.time then
                        return a.name < b.name
                    end
                    return astat.time > bstat.time
                end
                return astat.memory > bstat.memory
            end
            return a.focusOn
        end)

    self.dashboard2 = Dashboard(classes,
        {
            'className',
            'nInstancesMin',
            'count',
            'nInstancesMax',
        })

    self.dashboard2:setSortFunction(function (a,b)
            if a.count == b.count then
                if a.nInstancesMax == b.nInstancesMax then
                    return a.className < b.className
                end
                return a.nInstancesMax > b.nInstancesMax
            end
            return a.count > b.count
        end)
end

function Reporting:draw()
    if Profiler.running then
        Profiler.profiling = false
        do
            background()

            self.dashboard1:draw()

            --            self.dashboard2.position = vec2(800, 0)
            --            self.dashboard2:draw()
        end
        Profiler.profiling = true
    end
end
