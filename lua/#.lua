lfs = require 'lfs'
utf8 = require 'lib.utf8'
json = require 'lib.json'

require 'lua.require'
require 'lua.class'
require 'lua.decorator'
require 'lua.log'
require 'lua.eval'
require 'lua.ut'
require 'lua.table'
require 'lua.array'
require 'lua.data'
require 'lua.range'
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
require 'lua.id'
require 'lua.introspection'
require 'lua.bit'
require 'lua.callback'
require 'lua.attribs'
require 'lua.enum'

require 'lua.octree'
require 'lua.http'
require 'lua.video'

os.name = os.getenv("HOME") and os.getenv("HOME"):sub(1, 1) == '/' and 'osx' or 'windows'

function toggle(value, opt1, opt2)
    if value == nil then return opt1 end

    if value == opt1 then
        return opt2
    end
    return opt1
end
