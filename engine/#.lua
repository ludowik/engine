package.path = package.path..';'..'?/#.lua;?/main.lua;'

require 'lua'
require 'maths'

require 'engine.config'
require 'engine.mouse'
require 'engine.keyboard'

require 'engine.objects.component'
require 'engine.objects.object'
require 'engine.objects.node'
require 'engine.objects.scene'

require 'engine.application'
require 'engine.engine'
require 'engine.frame_time'
require 'engine.engine_memory'
require 'engine.parameter'
require 'engine.resourceManager'
require 'engine.touchDirection'

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
