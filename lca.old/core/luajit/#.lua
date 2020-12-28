osLibPath = 'core/luajit/libs'

require 'core.luajit.libs.module'
require 'core.luajit.libs.macro'

lib('core.luajit',
    'debug',
    'system',
    'fs',
    'graphics2d',
    'shader',
    'font',
    'mesh.meshBufferObject',
    'mesh.meshVertexArray',
    'mesh.meshRender',
    'mesh.meshText',
    'mesh.meshManager',
    'image',   
    'event',
    'sound',
    'style')

tools = tools or loadModule('tools', true)
glm   = glm   or loadModule('glm'  , true)
box2d = box2d or loadModule('box2d', true)
--bullet = bullet or loadModule('bullet', true)

physics = box2d
physics3d = bullet
