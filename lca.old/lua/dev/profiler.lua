-- profiler

Profiler = class('profiler')

local level = 0
local functions = nil
local tables = nil

function Profiler.init()
    if not config.profiling or functions then return end

    functions = Table()
    tables = Table()

    Profiler.override(_G)
end

local Ref = class('ref')

function Ref:init(name, f)
    self.name = name
    self.f = f
    self.count = 0
    self.time = 0
    self.timeLevelDown = 0
end

function Profiler.override(table)
    if tables[table] then return end
    tables[table] = true

    for name,f in pairs(table) do
        if type(f) == 'function' and not name:contains(unpack(Profiler.exclude)) then
            table[name] = Profiler.overrideFunction(Ref(name, f))
        elseif type(f) == 'table' then
            if f ~= gl and f ~= sdl and f ~= al and getmetatable(table) ~= f and f.className then
                log.info('override : '..name)
                Profiler.override(f)
            end
        end
    end
end

function Profiler.overrideFunction(ref)
    if functions[ref] then return end
    functions[ref] = true

    local clock = os.clock

    functions:add(ref)

    return function (...)
        local result, time, startTime, endTime
        if level == 0 then
            times = {}
        end

        level = level + 1

        do
            startTime = clock()
            result = {ref.f(...)}
            endTime = clock()

            time = endTime - startTime
            times[level] = ( times[level] or 0 ) + time
        end

        do
            ref.count = ref.count + 1

            ref.time = ref.time + time

            if times[level+1] then
                ref.timeLevelDown = ref.timeLevelDown + times[level+1]
                times[level+1] = nil
            end
        end

        level = level - 1

        return unpack(result)
    end
end

function Profiler.report()
    if functions == nil then return end

    local print = lua.print

    functions:forEach(function (v)
            v.averageTime = v.time / v.count
            v.timeLocal = v.time - v.timeLevelDown
        end)

    functions:sort(function (a,b)
            return a.time < b.time
        end)

    local time = 0
    functions:forEach(function (v)
            if v.count > 0 then
                time = time + v.time - v.timeLevelDown

                log.info(string.format("%s N:%.d T:%.1fms L:%.1fms A:%.3fms",
                        v.name,
                        v.count,
                        v.time * 1000,
                        v.timeLocal * 1000,
                        v.averageTime * 1000))
            end
        end)

    log.info("Program completed in " .. time .. " seconds") 
end

Profiler.exclude = {
    'pairs', 'ipairs',
    'unpack',
    'metatable',
    'print',
    'raw',
    'setfenv',
    'getfenv',
    'class',
    'tostring', 'tonumber',
    'assert'
}
