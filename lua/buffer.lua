ffi = require 'ffi'

ffi.cdef[[
    typedef struct buffer {
        int available;
        int sizeof_ctype;
        int size;
        int n;      
        float* data;
    } buffer;
    
    void* malloc(size_t __size);
    void* realloc(void *__ptr, size_t __size);
    void free(void *__ptr);
]]

local buffer_sizes = {}

buffer_meta = {
    __len = function (buffer)
        return buffer.n
    end,

    __gc = function (buffer)
        ffi.C.free(buffer.data)
    end,

    __newindex = function (buffer, key, value)
        if type(key) == 'number' then
            if buffer.available < key then

                buffer.available = buffer.available * 2
                buffer.size = buffer.available * buffer.sizeof_ctype

                buffer.data = ffi.cast('float*',
                    ffi.C.realloc(
                        buffer.data,
                        buffer.size))

            end

            buffer.n = buffer.n + 1
            buffer.data[key-1] = value

        else
            rawset(buffer, key, value)
        end
    end,

    __index = function (buffer, key)
        if type(key) == 'number' then
            return buffer.data[key-1]

        else
            return rawget(buffer, key)
        end
    end,

    tobytes = function (buffer)
        return buffer.data
    end
}

new_buffer = ffi.metatype('buffer', buffer_meta)

function Buffer()

    local buffer = new_buffer()

    buffer.available = 4
    
    buffer.sizeof_ctype = ffi.sizeof('float')
    buffer.size = buffer.available * buffer.sizeof_ctype
    
    buffer.data = ffi.cast('float*', ffi.C.malloc(buffer.size))

    buffer.n = 0

    return buffer

end
