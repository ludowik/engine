local classes = {}

local function defaultInit()
end

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
    k.__index = k
    k.__className = className:lower()

    table.insert(classes, k)

    k.init = defaultInit

    k.extends = function (k, ...)
        __bases = {...}
        assert(#__bases > 0)

        if k.init == defaultInit then
            k.init = nil
        end

        k.__bases = __bases
        for i,__base in ipairs(__bases) do
            for name,v in pairs(__base) do
                if k[name] == nil then
                    k[name] = v
                end
            end
        end
    end

    k.properties = {
        get = {},
        set = {}
    }

    k.meta = function (self, __base)
        k.init = function (self)
        end

        getmetatable(self).__index = __base

        return self
    end

    k.attribs = table.attribs
    k.clone = table.clone

    local mt
    mt = {
        __call = function (_, ...)
            classWithProperties(k)
            mt.__call = mt.__call2
            return mt.__call(_, ...)
        end,

        __call2 = function (_, ...)
            local instance = {}
            setmetatable(instance, k)
            instance = k.init(instance, ...) or instance
            return instance
        end,
    }

    setmetatable(k, mt)

    rawset(_G, className, k)

    if #args > 0 then
        k:extends(unpack(args))
    end

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

function typeof(object)
    local typeof = type(object)
    if typeof == 'table' then 
        return classnameof(object) or 'table'

    elseif typeof == 'cdata' then 
        return 'cdata'

    end
    return typeof
end

function classnameof(object)
    return attributeof('__className', object)
end

function attributeof(attrName, object)
    _G.__object__ = object
    return evalExpression('_G.__object__.'..attrName)
end

function call(fname)
    for k,v in pairs(classes) do
        local f = attributeof(fname, v)
        if f and type(f) == 'function' then
            f()
            v[fname] = nil
        end
    end
end
