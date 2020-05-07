function precompile(str)
    defs = {}
    
    function define2const(def, value)
        defs[def] = tonumber(value)
        return 'static const int '..def..' = '..value..';\r'
    end

    str = str:gsub("#define%s+(%S+)%s+(%S+)[\r\n]", define2const)

    return str
end  

require 'lib.sdl'
require 'lib.opengl'