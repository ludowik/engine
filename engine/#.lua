local luapath = './luajit/lualibs/?.lua;;./luajit/lualibs/?/?.lua'..';?/#.lua;?/main.lua'
local cpath = './luajit/clibs/?.dll'

package.path = package.path..';'..luapath
package.cpath = package.cpath..';'..cpath

if love then
    love.filesystem.setRequirePath(love.filesystem.getRequirePath()..';'..luapath)
end

require 'lua'
require 'maths'

require 'engine.config'
require 'engine.mouse'
require 'engine.keyboard'

require 'engine.application'
require 'engine.applicationManager'

require 'engine.component'
require 'engine.engine'

require 'engine.frameTime'
require 'engine.memory'

require 'engine.scene.object'
require 'engine.scene.node'
require 'engine.scene.scene'

require 'engine.parameter'
require 'engine.resourceManager'

require 'engine.touchDirection'
require 'engine.camera'

require 'engine.font'

require 'libc'

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

math.MAX_INTEGER = math.maxinteger
math.MIN_INTEGER = math.mininteger
