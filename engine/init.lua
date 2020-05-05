package.path = package.path..';'..'?/#.lua;?/main.lua;'

require 'lua'
require 'maths'
require 'graphics'

require ('engine.core_'..(love and 'love' or 'gl'))

require 'engine.mouse'

require 'engine.game_object'
require 'engine.application'
require 'engine.engine'
