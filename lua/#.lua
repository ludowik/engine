lfs = require 'lfs'
utf8 = require 'lua.utf8'

require 'lua.log'
require 'lua.require'
require 'lua.class'
require 'lua.ut'
require 'lua.table'
require 'lua.array'
require 'lua.data'
require 'lua.range'
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
require 'lua.convert'
require 'lua.grid'
require 'lua.date'
require 'lua.eval'

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'


function toggle(value, opt1, opt2)
    if value == nil then return opt1 end

    if value == opt1 then
        return opt2
    end
    return opt1
end

__assert = assert

function assert(exp, message, level)
    if not exp then
        error(message or 'error', level and (level+1) or 2)
    end
end

function warning(message, level)
    log(message)
end
