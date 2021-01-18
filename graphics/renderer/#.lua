local renderer = 'OPENGL'

require 'graphics.renderer.meshRender'

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

elseif renderer == 'SDL' then
    require 'graphics.renderer.softwaregl.softwaregl'
    require 'graphics.renderer.shader'    

    require 'graphics.mesh'
    
    require 'graphics.image'

    gl = OpenGL()
    sgl = SoftwareGL()

    renderer = sgl
end

function Renderer()
    return renderer
end
