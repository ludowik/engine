local classes = {}
local newClasses = {}

function class(name, ...)
    local bases
    if name == nil or type(name) ~= 'string' then
        bases = {name, ...}
        name = '???'
    else
        bases = {...}
    end

    local class = {}    
    class.__index = class

    class.className = name:lower()

    class.properties = {
        get = {},
        set = {}
    }

    table.insert(newClasses, class)

    table.insert(classes, class)
    classes[name] = class

    local mt = {
        __call = function (k, ...)
            local instance, res
            instance = {}
            setmetatable(instance, k)
            res = instance:init(...)
            if res and res ~= instance then
                instance = setmetatable(res, k)
            end
            return instance
        end
    }
    setmetatable(class, mt)

    class.init = function () end

    class.clone = table.clone

    if #bases then
        class.__bases = bases
        class.__base = bases[1]
        for i=#bases,1,-1 do
            base = bases[i]
            for k,v in pairs(base) do
                assert(v)
                if type(v) == 'function' then
                    class[k] = v
                end
            end
        end
    end

    _G[name] = class
    return class
end

function classWithProperties(proto)
    local get = proto.properties.get
    if table.getnKeys(get) > 0 then
        proto.__index = function(tbl, key)
            if get[key] then
                return get[key](tbl)
            elseif proto[key] then
                return proto[key]
            else
                return rawget(tbl, key)
            end
        end
    end

    local set = proto.properties.set
    if table.getnKeys(set) > 0 then
        proto.__newindex = function(tbl, key, val)
            if set[key] then
                set[key](tbl, val)
            elseif proto[key] then
                proto[key] = val
            else
                rawset(tbl, key, val)
            end
        end
    end
end

function setupClasses()
    for name,class in pairs(newClasses) do
        assert(class[name] == nil, name)
    end

    for i,class in ipairs(newClasses) do
        classWithProperties(class)

        if type(class) == 'table' and class.setup then
            class.setup(class)
            class.clone = table.clone
        end
    end

    resetClasses()
end

function resetClasses()
    newClasses = {}
end
