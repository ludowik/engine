function class(className)
    local k = {}
    k.__index = k

    k.init = function ()
    end

    k.extends = function (self, __base)
        for k,v in pairs(__base) do
            if self[k] == nil then
                self[k] = v
            end
        end
    end

    mt = {
        __call = function (_, ...)
            local instance = {}
            setmetatable(instance, k)
            k.init(instance, ...)
            return instance
        end,
    }

    setmetatable(k, mt)

    _G[className] = k

    return k
end
