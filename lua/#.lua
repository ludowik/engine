require 'lua.class'
require 'lua.array'
require 'lua.range'
require 'lua.math'
require 'lua.random'
require 'lua.decorator'
require 'lua.buffer'
require 'lua.memory'
require 'lua.perf'
require 'lua.io'
require 'lua.string'
require 'lua.module'

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'

function dir(path)
    local list = {}
    for file in lfs.dir(path) do
        if file ~= '.' and file ~= '..'  then
            table.insert(list, file)
        end
    end
    return list
end
