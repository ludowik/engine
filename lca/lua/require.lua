local lfs = require 'lfs'
require 'lua.decorate'

___require = ___require or require
___requireReload = false

function __require(...)
    if ___requireReload then
        local args = {...}
        package.loaded[args[1]] = nil
    end
    return ___require(...)
end

function require(...)
    local filesName = {...}
    local res

    for i,fileName in ipairs(filesName) do
        res = __require(fileName) or res
    end
    return res
end

function requireLib(...)
    local filesName = {...}
    local res

    local path = scriptPath(3) -- .. / requireLib / scriptPath
    for i,fileName in ipairs(filesName) do
        res = __require(path..'/'..fileName)
    end
    return res
end

function requirePlist(name)
    local plist = load(name)

    for res in (plist:match('<array>(.-)</array>'):gmatch('<string>(.-)</string>')) do
        require('apps/physics2d/'..res)
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

local excludeFiles = {'string', 'table', 'socket', 'ltn12'}

local __level = 0
local __names = {}
local function requireWithLog(f, name, ...)
    local tag = __names[name]
    if tag == nil then
        __names[name] = 1
    else
        if __names[name] == 1 then
            if not ___requireReload and not name:inList(excludeFiles) then
                print(name..' Already loaded')
            end
        end
        __names[name] = __names[name] + 1        
    end

    __level = __level + 1    
    local res = f(name, ...)
    __level = __level - 1

    return res
end

decorate('require', requireWithLog)
