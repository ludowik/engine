require 'lua.class'
require 'lua.ut'
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
require 'lua.tween'
require 'lua.heap'
require 'lua.date'

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'

function dir(path, list, subPath)
    list = list or Array()
    for file in lfs.dir(path) do
        if not file:startWith('.') then
            if isFile(path..'/'..file) then
                table.insert(list, subPath and (subPath..'/'..file) or file)
            else
                dir(path..'/'..file, list, subPath and (subPath..'/'..file) or file)
            end
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
