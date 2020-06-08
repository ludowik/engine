function table.load(name)
    if fs.getInfo(name) == nil then return end

    local content = fs.read(name)
    local ftables = loadstring(content)

    return ftables and ftables() or nil
end

function table.save(t, name)
    assert(name)

    local code = "return "..table.format(t, name)
    local file = fs.write(name, code)
end

function table.format(t, name, tab_)
    local tab = (tab_ or "").."    "

    local code = "{"
    local varName

    for k,v in pairs(t) do
        if v ~= t then
            local typeIndex = type(k)
            if typeIndex == 'number' then
                varName = '['..k..']'
            else
                varName = '["'..k..'"]'
            end

            code = code..NL..tab..varName.." = "..convert(v, k, tab)..","
        end
    end

    code = code..NL..(tab_ or "").."}"
    return code
end

conversions = {
    ['table'] = function (v)
        if v.__formatting then return "..." end

        v.__formatting = true
        local result
        if v.format then
            result = v:format()
        else
            result = table.format(v)
        end
        v.__formatting = nil

        return result
    end,

    ['string'] = function (v)
        return '"'..tostring(v)..'"'
    end,

    ['number'] = function (v)
        return tostring(v)
    end,

    ['boolean'] = function (v)
        return v and 'true' or 'false'
    end,
}

function convert(v)
    local conversion = conversions[type(v)] or tostring
    return conversion(v)
end
