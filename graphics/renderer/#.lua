local renderer = 'OPENGL'

if love then
    renderer = 'LOVE2D'
end

require 'graphics.renderer.mediaInterface'
require 'graphics.renderer.rendererInterface'
require 'graphics.renderer.audioInterface'

if renderer == 'OPENGL' then
    require 'graphics.renderer.opengl.meshRender'
    require 'graphics.mesh'

--require 'graphics.renderer.shader'
    require 'graphics.renderer.opengl.shader'

    require 'graphics.image'
    require 'graphics.renderer.opengl.image'

    gl = OpenGL()
    
--    sgl = SoftwareGL()

    renderer = gl

elseif renderer == 'VULKAN' then
    require 'graphics.mesh'

    require 'graphics.renderer.shader'

    require 'graphics.image'

    vulkan = Vulkan()

    renderer = vulkan

elseif renderer == 'LOVE2D' then
    require 'graphics.renderer.love2d.love2d'
    require 'graphics.renderer.shader'    

    require 'graphics.mesh'
    
    require 'graphics.image'

    renderer = Love2dRenderer()
end

function Renderer()
    return renderer
end
