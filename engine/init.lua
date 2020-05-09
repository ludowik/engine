package.path = package.path..';'..'?/#.lua;?/main.lua;'

require 'lua'
require 'maths'

require 'engine.component'

require 'graphics'

require ('engine.core_'..(love and 'love' or 'gl'))

require 'engine.mouse'

require 'engine.game_object'
require 'engine.application'
require 'engine.engine'
require 'engine.frame_time'
require 'engine.engine_memory'
