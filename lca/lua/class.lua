classes = {}

function class(...)
    local args = {...}

    local className
    if #args > 0 and type(args[1]) == 'string' then    
        className = args[1]
        table.remove(args, 1)
    else
        className = 'file.'..scriptName()..id(scriptName())
    end

    local k = {}
    k.className = className:lower()

    k.nInstancesMin = nil
    k.nInstancesMax = 0
    k.count = 0

    k.setup = doNothing
    k.runSetup = true

    k.test = doNothing

    k.debugSetup = true

    k.__index = k

    k.__new = function (k)
        local instance = {}
        setmetatable(instance, k)
        return instance
    end

    k.init = function (self)
    end

    k.attribs = table.attribs
    
    k.clone = table.clone
    k.clear = table.clear
    k.forEach = table.forEach
    k.push2Global = table.push2Global

    if #args > 0 then
        k.__base = args
        for i=#args,1,-1 do
            table.derived(k, args[i], true)
        end
    end

    k.properties = {
        get = {},
        set = {}
    }

    local mt = {
        __call = function (_, ...)
            local instance = k.__new(k)
            k.count = k.count + 1
            return instance:init(...) or instance
        end,

        __tostring = function ()
            return k.className
        end
    }
    setmetatable(k, mt)

    table.add(classes, k)

    local env = _G.env or _G
    assert(env[className] == nil, 'class already declared : '..className)    
    env[className] = k

    assert(classes[k] == nil, 'class already registered : '..className)
    classes[k] = className

    return k
end

function classWithProperties(proto)
    local get = proto.properties.get
    if table.getnKeys(get) > 0 then
        proto.__index = function(tbl, key)
            if get[key] then
                return get[key](tbl)
            elseif proto[key] then
                return proto[key]
            elseif type(key) == 'number' and get.index then
                return get.index(tbl, key)
            else
                return rawget(tbl, key)
            end
        end
    end

    local set = proto.properties.set
    if table.getnKeys(set) > 0 then
        proto.__newindex = function(tbl, key, value)
            if set[key] then
                set[key](tbl, value)
            elseif proto[key] then
                proto[key] = value
            elseif type(key) == 'number' and set.index then
                set.index(tbl, key, value)
            else
                rawset(tbl, key, value)
            end
        end
    end
end

class('__class')

function __class:test()
    assert(class, 'exist')
    assert(class(), 'new')

    local t1 = class("class.test1")
    function t1:f() end
    assert(t1.className == 'class.test1', 'className.class')
    assert(t1().className == 'class.test1', 'className.instance')
    assert(t1().f == t1.f, 'className.f1')

    local t2 = class("class.test2", t1)
    function t2:f() end
    assert(t2.className == 'class.test2', 'className.derived.class')
    assert(t2().className == 'class.test2', 'className.derived.instance')
    assert(t2().f == t2.f, 'className.f2')

    local t3 = class('class.test3', t1)
    assert(t3().f == t1.f, 'className.f3')
end

function classes:setup()
    local k
    for i=1,#self do
        k = self[i]

        classWithProperties(k)

        if k.setup and k.runSetup ~= false then
            if k.debugSetup == false then
                debugger.off()
            end

            if k.setup and k.setup ~= doNothing then
                print('setup '..k.className)

                k.setup(k)
                k.runSetup = false
            end

            if k.debugSetup == false then
                debugger.on()
            end
        end
    end
end

function classes:test()
    table.test()

    local noOptimization = config.noOptimization
    config.noOptimization = true
    
    local k
    for i=1,#self do
        k = self[i]

        if k.test then
            print('test '..k.className)
            k.test()
        end
    end
    
    config.noOptimization = noOptimization
end

function classes:version()
    local k
    for i=1,#self do
        k = self[i]

        if k.getVersion then
            local version = k.getVersion()
            print(k.className..' '..version)
        end
    end
end

function classes:reset()
    if not Profiler.running then return end

    local k
    for i=1,#self do
        k = self[i]

        k.nInstancesMin = nil
        k.nInstancesMax = 0
        
        k.count = 0
    end
end

function classes:update()
    if not Profiler.running then return end

    Profiler.profiling = false
    do
        local k
        for i=1,#self do
            k = self[i]

            if k.count > 1 then
                k.nInstancesMin = k.nInstancesMin and min(k.nInstancesMin, k.count) or k.count
                k.nInstancesMax = k.nInstancesMax and max(k.nInstancesMax, k.count) or k.count
            end
            k.count = 0
        end
    end
    Profiler.profiling = true
end

function typeof(t)
    local typeof = type(t)
    if typeof == 'table' then 
        return classnameof(t) or 'table'

    elseif typeof == 'cdata' then 
        return 'cdata'

    end
    return typeof
end

function classnameof(object)
    __object__ = object
    local className = evalExpression('__object__.className')
    return className and tostring(className)
end
