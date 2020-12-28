requireLib(
    'lib',
    'module')

osLibPath = 'libc'

if osx then
    osLibDir = 'osx'
else
    osLibDir = 'win'
end

requireLib(
    'tools.tools',
    'sdl.sdl',
    'ft.ft',
    'opengl.opengl',
    'openal.openal',
    'box2d')
