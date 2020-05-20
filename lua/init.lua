require 'lua.class'
require 'lua.array'
require 'lua.range'
require 'lua.math'
require 'lua.random'
require 'lua.decorator'
require 'lua.buffer'
require 'lua.memory'
require 'lua.perf'

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'

io.read = function (fileName)
    local f, res = io.open(fileName)
    if f then
        res = f:read('*a')
        f:close()
    end
    return res
end

io.write = function (fileName, content)
    local f, res = io.open(fileName, "wt")
    if f then
        res = f:write(content)
        f:close()
    end
    return res
end

NL = '\n'
