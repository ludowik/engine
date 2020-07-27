local code, defs = Library.precompile(io.read('./libc/box2d/box2d.h'))
ffi.cdef(code)

box2d = Library.compileFile('libc/box2d/box2d.cpp',
    'box2d',
    '-I "'..Path.libraryPath..'/box2d-master/include"',
    '-I "'..Path.libraryPath..'/box2d-master/src"',
    '-L "'..Path.libraryPath..'/box2d-master/Build/src/Debug" -lbox2d')


pixelToMeterRatio = 32
mtpRatio = pixelToMeterRatio
ptmRatio = 1 / mtpRatio

requireLib(
    'box2d',
    'body',
    'joint')
