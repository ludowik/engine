if love then
    -- TODO : mettre dans fs
    lfs = {}

    lfs.attributes = function (name)
        local info = love.filesystem.getInfo(name)
        if info then
            return {
                mode = info.type,
                modification = info.modtime
            }
        end
    end

    lfs.currentdir = function ()
        return love.filesystem.getWorkingDirectory()
    end

    lfs.mkdir = function (name)
        love.filesystem.createDirectory(name)
    end

    lfs.dir = function (path)
        local files = Table()
        local items = love.filesystem.getDirectoryItems(path)
        for i,item in ipairs(items) do
            files:add(item)
        end
        local i = 0
        return function ()
            if i == #files then return nil end
            i = i + 1
            return files[i]
        end
    end

else
    lfs = require 'lfs'
end

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
