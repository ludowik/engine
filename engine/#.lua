local luapath = './luajit/lualibs/?.lua;;./luajit/lualibs/?/?.lua'..';?/#.lua;?/main.lua;'
local cpath = './luajit/clibs/?.dll'

package.path = package.path..';'..luapath
package.cpath = package.cpath..';'..cpath

if jit then print(jit.version) end
if love then print(love.version) end

print(_VERSION)

if love then
    love.filesystem.setRequirePath(love.filesystem.getRequirePath()..';'..luapath)
end

require 'lua'
require 'maths'

require 'engine.config'
require 'engine.mouse'
require 'engine.keyboard'
require 'engine.screen'

require 'engine.application'
require 'engine.applicationManager'

require 'engine.engine'
require 'engine.events'
require 'engine.introspection'
require 'engine.renderFrame'

require 'engine.scene.object'
require 'engine.scene.node'
require 'engine.scene.scene'

require 'engine.component'
require 'engine.componentManager'

require 'engine.frameTime'
require 'engine.memory'
require 'engine.info'

require 'engine.parameter'
require 'engine.resourceManager'

require 'engine.gesture'
require 'engine.camera'

require 'engine.font'

require 'libc'

require 'graphics'

require 'ui'

require 'sound'

require 'fizix'

if ios then
    startDebug()
end

if hook then
    debug.sethook(function (...)
            local n = debug.getinfo(2, 'nfSlu');
            if n then
                (__print__ or print)(string.sub(n.source, 2)..':'..n.linedefined..':'..' ' ..(n.name or ''), ...)
            end
        end,
        'l')
end
