local classes = {}

function class(className)
    local k = {}
    k.__index = k
    k.__className = className:lower()

    table.insert(classes, k)

    k.init = function (self)
    end

    k.extends = function (self, __base)
        assert(__base)

        self.__base = __base
        for k,v in pairs(__base) do
            if self[k] == nil then
                self[k] = v
            end
        end
    end

    k.meta = function (self, __base)
        k.init = function (self)
        end

        getmetatable(self).__index = __base

        return self
    end

    k.attribs = table.attribs

    mt = {
        __call = function (_, ...)
            local instance = {}
            setmetatable(instance, k)
            instance = k.init(instance, ...) or instance
            return instance
        end,
    }

    setmetatable(k, mt)

    _G[className] = k

    return k
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
