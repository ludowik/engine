function requireLib(...)
    for i,v in pairs({...}) do
        require(scriptPath(3)..'/'..v)
    end
end

function requirePlist(name)
    local plist = load(name)

    for res in (plist:match('<array>(.-)</array>'):gmatch('<string>(.-)</string>')) do
        require(scriptPath(3)..'/'..res)
    end
end

function scriptPath(level)
    level = level or 3
    local source = debug.getinfo(level, "S").source
    local str = source:sub(2)
    return str:match("(.+)[/\\][%w#]+%.lua$")
end

function scriptName(level)
    level = level or 3
    local source = debug.getinfo(level, "S").source
    local str = source:sub(2)
    return str:match("(%w+)%.lua$")
end

