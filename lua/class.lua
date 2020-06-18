function class(className)
    local k = {}
    k.__index = k
    k.__className = className:lower()

    k.init = function (self)
--        if self.__base then
--            self.__base.init(self)
--        end
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

function typeof(t)
    local typeof = type(t)
    if typeof == 'table' then 
        return t.__className or 'table'

    elseif typeof == 'cdata' then 
        return 'cdata'

    end
    return typeof
end
