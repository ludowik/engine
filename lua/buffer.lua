ffi = require 'ffi'

ffi.cdef [[   
    void* malloc(size_t __size);
    void* realloc(void *__ptr, size_t __size);
    
    void free(void *__ptr);
]]

buffer_meta = {}

function buffer_meta.__init(buffer, buffer_class)
    buffer.available = 4

    buffer.sizeof_ctype = buffer_class.sizeof_ctype
    buffer.size = buffer_class.sizeof_ctype * buffer.available

    buffer.data = ffi.cast(buffer_class.ctype, ffi.C.malloc(buffer.size))

    buffer.n = 0

    return buffer
end

function buffer_meta.__len(buffer)
    return buffer.n
end

function buffer_meta.__gc(buffer)
    ffi.C.free(buffer.data)
end

local max = math.max
function buffer_meta.__newindex(buffer, key, value)
    if type(key) == 'number' then
        if buffer.available < key then

            buffer.available = max(buffer.available * 2, key)
            buffer.size = buffer.available * buffer.sizeof_ctype
            
            buffer.data = ffi.cast(ffi.typeof(buffer.data),
                ffi.C.realloc(
                    buffer.data,
                    buffer.size))
            
            assert(buffer.data)

        end

        buffer.n = max(buffer.n, key)
        buffer.data[key-1] = value

    else
        rawset(buffer_meta, key, value)
    end
end

function buffer_meta.__index(buffer, key)
    if type(key) == 'number' then
        return buffer.data[key-1]

    else
        return rawget(buffer_meta, key)
    end
end

function buffer_meta.insert(buffer, value)
    buffer[#buffer] = value
end

function buffer_meta.reset(buffer)
    buffer.n = 0
end

function buffer_meta.tobytes(buffer)
    return buffer.data
end

local buffer_classes = {}

function Buffer(ct)
    ct = ct or 'float'

    local buffer_class = buffer_classes[ct]
    
    if buffer_classes[ct] == nil then
        
        buffer_class = {
            ct = ct,
            ctype = ffi.typeof(ct..'*'),
            sizeof_ctype = ffi.sizeof(ct),
            struct = [[
                typedef struct buffer {
                    int available;
                    int sizeof_ctype;
                    int size;
                    int n;
                    {ct}* data;
                } buffer;
            ]]
        }

        buffer_class.typed_struct = buffer_class.struct:gsub('{ct}', ct)
        ffi.cdef(buffer_class.typed_struct)

        buffer_class.meta = ffi.metatype('buffer', buffer_meta)

        buffer_classes[ct] = buffer_class
        
    end
    
    return buffer_class.meta():__init(buffer_class)
end
