package.path = package.path..';'..'?/#.lua;?/main.lua;'

loadstring = load

require 'lua.require'

require 'lua'

require 'maths'
require 'tools'
require 'event'
require 'engine.config'
require 'graphics'
require 'physics'

require 'engine.scene'
require 'engine.application'

require 'ui'

require 'libc'

require 'engine.engine'
require 'engine.lca'

Engine():run()
