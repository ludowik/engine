package.path = package.path..';'..'?/#.lua;?/main.lua;'

debugger = require('mobdebug')
if arg[#arg] == '-debug' then
    debugger.start()
    debugger.on()
    debugger.coro()

    debugging = true
end

jit.on()

require 'lua'
require 'maths'

require 'engine.component'

require 'engine.config'
require 'engine.mouse'

require 'engine.game_object'
require 'engine.application'
require 'engine.engine'
require 'engine.frame_time'
require 'engine.engine_memory'
require 'engine.parameter'

require 'graphics'
require 'lib'
