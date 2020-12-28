function requireLib(...)
    return require(...)
end

function lib(...)
    return libPath(scriptPath(), ...)
end

function dll(dll, ...)
    return libPath(scriptPath()..'/'..dll, ...)
end

function libPath(path, ...)
    local res
    local args = {...}
    
    local ls
    if dir then
        ls = dirApp(path)
    end
    
    for _,v in ipairs (args) do
        local file
        if ls then -- for iOS : file system case sensitive
            local i, item = ls:findItem(path..'/'..v, true)
            assert(item, path..'/'..v..' not found')
            file = item
        else
            file = path..'/'..v
        end
        
        res = require(file) or res
    end
    return res
end

function scriptPath()
    local str = debug.getinfo(3, "S").source:sub(2)
    return str:match("(.*)/")
end

require 'lua.decorate'

local __level = 0
local __names = {}
local function requireWithLog(f, name, ...)
    local tab = ''
    for i=1,__level do
        tab = tab .. '  '
    end

    local tag = __names[name]
    if tag == nil then
        __names[name] = 1
    else
        print(tab..name..' : Already loaded')
        __names[name] = __names[name] + 1        
    end

    __level = __level + 1    
    local res = f(name, ...)
    __level = __level - 1

    return res
end

decorate('require', requireWithLog)
