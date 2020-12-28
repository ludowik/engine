love.filesystem.setRequirePath('?.lua;?/#.lua;?/main.lua;')

utf8 = require 'utf8'
ffi = require 'ffi'

require 'lua.debug'
require 'lua.require'

requireLib 'lua'
requireLib 'core.love2d'
requireLib 'lca'

requireLib 'engine.libs'
requireLib 'engine'
