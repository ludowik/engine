require 'libc.library'

require 'libc.sdl.sdl'
require 'libc.opengl.opengl'
require 'libc.openal.openal'
require 'libc.freetype.freetype'

if windows or ios or osx then
    require 'libc.box2d'
end
