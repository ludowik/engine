function precompile(str)
    local defs = {}
    
    function define2const(def, value)
        defs[def] = tonumber(value)
        return 'static const int '..def..' = '..value..';\r'
    end

    str = str:gsub("#define%s+(%S+)%s+(%S+)[\r\n]", define2const)

    return str, defs
end

ffi = require 'ffi'

ffi.NULL = ffi.cast('void*', 0)

require 'lib.sdl'
require 'lib.opengl'
require 'lib.openal'
require 'lib.freetype'
