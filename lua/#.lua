require 'lua.class'
require 'lua.table'
require 'lua.array'
require 'lua.data'
require 'lua.range'
require 'lua.math'
require 'lua.random'
require 'lua.decorator'
require 'lua.buffer'
require 'lua.memory'
require 'lua.perf'
require 'lua.path'
require 'lua.io'
require 'lua.string'
require 'lua.module'
require 'lua.fs'

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'

function dir(path)
    local list = Array()
    for file in lfs.dir(path) do
        if file ~= '.' and file ~= '..'  then
            table.insert(list, file)
        end
    end
    return list
end

function toggle(value, opt1, opt2)
    if value == opt1 then
        return opt2
    end
    return opt1
end
