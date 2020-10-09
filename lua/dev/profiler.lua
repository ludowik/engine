class('Profiler')

local clock = function ()
    return os.clock() * 1000
end

local mem = function ()
    return collectgarbage('count') * 1024
end

function Profiler.setup()
    Profiler.functionsName = Table()
    Profiler.functions = Table()
    Profiler.tables = Table()

    Profiler.tables[Profiler] = true

    Profiler.running = false
    Profiler.profiling = false
end

function Profiler.init()
    Profiler.override(_G, '_G')

    Profiler.level = 0

    Profiler.levelTime = {0}
    Profiler.levelMemory = {0}
    Profiler.levelRef = {Ref('root')}

    local startMemory = mem()
    local result = {
        nilf()
    }
    local endMemory = mem()

    Profiler.defaultMemory = endMemory - startMemory
end

function Profiler.resetClasses()
    if not Profiler.running then return end

    local k
    for i=1,#__classes do
        k = __classes[i]

        k.nInstancesMin = nil
        k.nInstancesMax = 0

        k.count = 0
    end
end

function Profiler.updateClasses()
    if not Profiler.running then return end

    Profiler.profiling = false
    do
        local k
        for i=1,#__classes do
            k = __classes[i]

            if k.count > 1 then
                k.nInstancesMin = k.nInstancesMin and min(k.nInstancesMin, k.count) or k.count
                k.nInstancesMax = k.nInstancesMax and max(k.nInstancesMax, k.count) or k.count
            end
            k.count = 0
        end
    end
    Profiler.profiling = true
end

local Stat = class('Stat')

function Stat:init()
    self.count = 0

    self.time = 0
    self.timeInto = 0
    self.timeUnder = 0

    self.memory = 0
    self.memoryInto = 0
    self.memoryUnder = 0
end

function Stat:computeKPI()
    self.timeInto = self.time - self.timeUnder

    self.percentTimeInto = self.timeInto / self.time
    self.percentTimeUnder = self.timeUnder / self.time

    self.averageTime = self.time / self.count

    self.memoryInto = self.memory - self.memoryUnder

    self.percentMemoryInto = self.memoryInto / self.memory
    self.percentMemoryUnder = self.memoryUnder / self.memory

    self.averageMemory = self.memory / self.count
end

local Ref = class('Ref')

function Ref:init(name, f)
    self.name = name
    self.f = f

    self.stat = Stat()

    self:reset()
end

function Ref:reset()
    self.frame = self.temp or Stat()

    self.temp = Stat()

    self.last = self.last or Stat()
    self.last:init()

    self.callers = self.callers or Array()
    self.callers:forEachKey(function (caller)
            caller.count = 0
        end)
end

function Profiler.reset()
    if not Profiler.running then return end

    Profiler.functions:forEach(function (v, k)
            v:reset()
        end)
end

function Profiler.override(t, className, name)
    assert(className)

    if not Profiler.tables[t] then
        Profiler.tables[t] = true

        if name then
            print('override class '..className..' from '..name)
        else
            print('override class '..className)
        end

        for name,f in pairs(t) do
            local nType = type(name)
            local fType = type(f)

            if (nType == 'string' and
                not name:inList(Profiler.excludeNames))
            then
                if fType == 'function' then
                    local fName = className and (className..'.'..name) or name
                    t[name] = Profiler.overrideFunction(fName, f)

                elseif fType == 'table' and className == '_G' then
                    local className = classnameof(f)
                    if className then
                        Profiler.override(f, className, name)
                    end
                end
            end
        end
    end
end

function Profiler.overrideFunction(name, f)
    if not Profiler.functionsName[name] then
        Profiler.functionsName[name] = true

        print('override function '..name)

        local ref = Ref(name, f)
        Profiler.functions:add(ref)

        if name:contains(Profiler.focusOn) then
            ref.focusOn = true
        end

        return function (...)
            if Profiler.running and Profiler.profiling then
                local result

                -- level down
                Profiler.level = Profiler.level + 1

                Profiler.levelTime[Profiler.level+1] = 0
                Profiler.levelMemory[Profiler.level+1] = 0

                Profiler.levelRef[Profiler.level+1] = ref

                do
                    ref.result = nil

                    collectgarbage('stop')

                    -- profiling
                    ref.startTime = clock()
                    ref.startMemory = mem()

                    do
                        ref.result = { ref.f(...) }
                    end

                    ref.endMemory = mem() - Profiler.defaultMemory
                    ref.endTime = clock()

                    ref.last.count = 1

                    ref.last.time   = (ref.endTime - ref.startTime)
                    ref.last.memory = (ref.endMemory - ref.startMemory)

                    ref.temp.count = ref.temp.count + 1

                    ref.temp.time   = ref.temp.time   + ref.last.time
                    ref.temp.memory = ref.temp.memory + ref.last.memory

                    ref.temp.timeUnder = ref.temp.timeUnder + Profiler.levelTime[Profiler.level+1]
                    ref.temp.memoryUnder = ref.temp.memoryUnder + Profiler.levelMemory[Profiler.level+1]

                    Profiler.levelTime[Profiler.level] = Profiler.levelTime[Profiler.level] + ref.last.time
                    Profiler.levelMemory[Profiler.level] = Profiler.levelMemory[Profiler.level] + ref.last.memory

                    -- callers
                    local caller = Profiler.levelRef[Profiler.level].name -- getFunctionLocation() or 'root'
                    if ref.callers[caller] == nil then
                        ref.callers[caller] = {
                            caller = caller,
                            count = 0,
                        }
                    end
                    ref.callers[caller].count = ref.callers[caller].count + 1
                end

                -- level up
                Profiler.level = Profiler.level - 1

                return unpack(ref.result)
            else
                return ref.f(...)
            end
        end
    end
end

function Profiler:start()
    Profiler.running = true
end

function Profiler:stop()
    collectgarbage('collect')

    Profiler.running = false
    Profiler.profiling = false
end

function Profiler:update(dt)
    if not Profiler.running then return end

    Profiler.profiling = false

    Profiler.functions:forEach(function (ref)
            local stat = ref.stat
            local temp = ref.temp

            -- count
            stat.count = stat.count + temp.count

            -- time
            stat.time = stat.time + temp.time
            stat.timeUnder = stat.timeUnder + temp.timeUnder

            -- memory
            stat.memory = stat.memory + temp.memory
            stat.memoryUnder = stat.memoryUnder + temp.memoryUnder
        end)

    Profiler.functions:forEach(function (ref)
            ref:reset()

            ref.stat:computeKPI()
            ref.frame:computeKPI()
            ref.last:computeKPI()
        end)

    collectgarbage('collect')
    collectgarbage('stop')
end

Profiler.focusOn = {
    'shader',
    'opengl',
    'matrix'
}

Profiler.excludeNames = {
    'Profiler',
    'Ref',
    'Stat',
    'Reporting',
    'Dashboard',

    'scriptPath',
    'scriptName',

    'require',
    'class',
    'classes',
    'setmetatable',
    'getmetatable',
    'setfenv',
    'getfenv',
    'pcall',
    'assert',
    'load',
    'loadstring',

    '__new',
    '__alloc',

    'type',
    'typeof',
    'classnameof',

    'rawget',
    'rawset',
    'rawequal',

    'pairs', 'ipairs', 'next',

    'unpack',

    'debugger',
    'mobdebug',

    'print',

    'os',
    'collectgarbage',
    'clock',

    'random',

    'tostring',
    'tonumber',

    'getFileLocation',
    'getFunctionLocation',
    '__FILE__',
    '__LINE__',
    '__FUNC__',
}
