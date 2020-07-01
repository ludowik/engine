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
require 'engine.keyboard'

require 'engine.game_object'
require 'engine.application'
require 'engine.engine'
require 'engine.frame_time'
require 'engine.engine_memory'
require 'engine.parameter'

require 'libc'
require 'lib.json'
require 'lib.sfxr'
require 'lib.utf8'

require 'graphics'
require 'ui'

require 'sound'

require 'fizix'

-- legacy
randomInt = random.range

App = application

mesh = Mesh
color = Color

function vector(...)
    local v = {}
    setmetatable(v, {__index=vec2(...)})
    return v
end

newPhysics = Fizix

math.MAX_INTEGER = math.maxinteger
math.MIN_INTEGER = math.mininteger

function callback(object, f)
    return function (...)
        if f then
            f(object, ...)
        elseif object then
            object(...)
        end
    end
end
