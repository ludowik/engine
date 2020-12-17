require 'libc.library'

require 'libc.sdl.sdl'
require 'libc.opengl.opengl'
require 'libc.openal.openal'
require 'libc.freetype.freetype'
--require 'libc.vulkan.vulkan'

if windows then
    require 'libc.box2d'
end

ffi.cdef [[
    void exit(int status);
]]
