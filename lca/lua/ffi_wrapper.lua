local _ffi = ___require 'ffi'
ffi = class('ffi', _ffi)

function ffi.setup()
    ffi.cdef[[        
        typedef union vector {
            struct { float x, y, z, w; };
            struct { float r, g, b, a; };
        } vector;
        
        typedef union color {
            struct { unsigned char r, g, b, a; };
            struct { unsigned char x, y, z, w; };
        } color;
    ]]

    ffi.C = _ffi.C
    ffi.NULL = ffi.cast('void*', 0)
end
