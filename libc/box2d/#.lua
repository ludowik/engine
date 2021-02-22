class 'Libbox2d'

function Libbox2d.setup()
    local code, defs = Library.precompile(io.read('libc/box2d/box2d.h'))
    ffi.cdef(code)

    local path = getLibPath('box2d-master')

    box2d = class 'box2d' : meta(Library.compileFileCPP('libc/box2d/box2d.cpp',
            'box2d',
            '-I "'..path..'/include"',
            '-L "'..path..'/build/src/release" -l box2d',
            '-MT -std=c++17'))

    pixelToMeterRatio = 32
    mtpRatio = pixelToMeterRatio
    ptmRatio = 1 / mtpRatio

    requireLib(
        'box2d',
        'body',
        'joint')
end
