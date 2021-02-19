utf8 = require 'lib.utf8'
json = require 'lib.json'

require 'lua.os'
require 'lua.debug'
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
require 'lua.path'
require 'lua.io'
require 'lua.string'
require 'lua.fs'
require 'lua.tween'
require 'lua.heap'
require 'lua.convert'
require 'lua.grid'
require 'lua.date'
require 'lua.id'
require 'lua.bit'
require 'lua.callback'
require 'lua.attribs'
require 'lua.enum'
require 'lua.args'

require 'lua.quadtree'
require 'lua.octree'

require 'lua.http'
require 'lua.video'
require 'lua.url'
require 'lua.timer'
require 'lua.dev'
require 'lua.todo'

function toggle(value, opt1, opt2)
    if value == nil then return opt1 end

    if value == opt1 then
        return opt2
    end
    return opt1
end

function nilf()
end

niltable = {}
