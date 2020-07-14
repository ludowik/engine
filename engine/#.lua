package.path = package.path..';'..'?/#.lua;?/main.lua;'

require 'lua'
require 'maths'

require 'engine.config'
require 'engine.mouse'
require 'engine.keyboard'

require 'engine.application'
require 'engine.applicationManager'

require 'engine.component'
require 'engine.engine'

require 'engine.trackTime'
require 'engine.trackMemory'

require 'engine.scene.object'
require 'engine.scene.node'
require 'engine.scene.scene'

require 'engine.parameter'
require 'engine.resourceManager'

require 'engine.touchDirection'
require 'engine.camera'

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
