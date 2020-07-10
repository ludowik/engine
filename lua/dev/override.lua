local level = 0
local overrideFunctions = {}

function override()
    for k,v in pairs(_G) do
        if type(v) == 'function' and not k:contains(
            'unpack',
            'pairs',
            'script',
            'require')
        then
            overrideFunctions[k] = {
                name = k,
                f = function (...)
                    level = level + 1
                    overrideFunctions[k].count = overrideFunctions[k].count + 1
                    local res = {v(...)}
                    level = level - 1
                    return unpack(res)
                end,
                v = v,
                count = 0
            }
            table.insert(overrideFunctions, overrideFunctions[k])
        end
    end

    for k,v in ipairs(overrideFunctions) do
        _G[v.name] = v.f
    end
end

function unoverride()
    for k,v in ipairs(overrideFunctions) do
        _G[v.name] = v.v
    end

    print(level)

    table.sort(overrideFunctions, function (a, b)
            return a.count > b.count
        end)

    for k,v in ipairs(overrideFunctions) do
        if v.count > 0 then
            print(v.name..':'..v.count)
        end
    end
end
