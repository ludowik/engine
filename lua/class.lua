__classes = {}

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

    table.insert(__classes, k)

    k.init = defaultInit

    k.extends = function (k, ...)
        local __bases = {...}
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

        return k
    end

    k.properties = {
        get = {},
        set = {}
    }

    k.meta = function (self, __base)
        k.init = function (self)
            return self
        end

        local mt = getmetatable(self)

        mt.__index = __base
        mt.__call = function (_, ...)
            assert(mt.__call ~= k.init)
            mt.__call = k.init
            return mt.__call(_, ...)
        end

        return self
    end

    k.attribs = table.attribs
    k.clone = table.clone

    local mt
    mt = {
        __call = function (_, ...)
            classWithProperties(k)

            mt.__call = function (_, ...)
                local instance = {}
                setmetatable(instance, k)
                instance = k.init(instance, ...) or instance
                return instance
            end

            return mt.__call(_, ...)
        end,

        __tostring = function ()
            return k.__className
        end
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
        if ffi.typeof(object) == __vec2 then
            return 'vec2'
        elseif ffi.typeof(object) == __vec3 then
            return 'vec3'
        elseif ffi.typeof(object) == __vec4 then
            return 'vec4'
        elseif ffi.typeof(object) == __color then
            return 'color'
        end
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

function callOnObject(fname, object)
    local f = attributeof(fname, object)
    if f and type(f) == 'function' then
        f(object)
        return true
    end
end

function call(fname)
    for k,object in pairs(__classes) do
        callOnObject(fname, object)
    end
end

class('__class')

function __class:test()
    assert(class, 'exist')
    assert(class(), 'new')

    local t1 = class("class.test1")
    function t1:f() end
    assert(t1.__className == 'class.test1', 'className.class')
    assert(t1().__className == 'class.test1', 'className.instance')
    assert(t1().f == t1.f, 'className.f1')

    local t2 = class("class.test2", t1)
    function t2:f() end
    assert(t2.__className == 'class.test2', 'className.derived.class')
    assert(t2().__className == 'class.test2', 'className.derived.instance')
    assert(t2().f == t2.f, 'className.f2')

    local t3 = class('class.test3', t1)
    assert(t3().f == t1.f, 'className.f3')
end
