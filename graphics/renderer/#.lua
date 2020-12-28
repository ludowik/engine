local renderer = 'OPENGL'

if renderer == 'OPENGL' then
    require 'graphics.renderer.meshRender'
    require 'graphics.renderer.opengl.meshRender'
    require 'graphics.mesh'

--require 'graphics.renderer.shader'
    require 'graphics.renderer.opengl.shader'

    require 'graphics.image'
    require 'graphics.renderer.opengl.image'

    gl = OpenGL()
    
    renderer = gl

elseif renderer == 'VULKAN' then
    require 'graphics.renderer.meshRender'
    require 'graphics.mesh'

    require 'graphics.renderer.shader'

    require 'graphics.image'

    vulkan = Vulkan()
    
    renderer = vulkan

elseif renderer == 'SDL' then
    require 'graphics.renderer.meshRender'
    require 'graphics.renderer.shader'    
    require 'graphics.renderer.softwaregl.softwaregl'
    
    require 'graphics.image'
    require 'graphics.mesh'

    gl = OpenGL()
    sgl = SoftwareGL()
    
    renderer = sgl
end

function Renderer()
    return renderer
end
