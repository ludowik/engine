ffi = require 'ffi'

ffi.cdef [[
    void* malloc(size_t num);
    void* realloc(void *ptr, size_t num);
    
    void* memset(void *ptr, int value, size_t num);
    
    void* memmove(void *destination, const void *source, size_t num);
    void* memcpy(void *destination, const void *source, size_t num);

    void free(void *ptr);
]]

buffer_meta = {}

function buffer_meta.__init(buffer, buffer_class, data, ...)
    buffer.ct = buffer_class.ct

    buffer.id = id('buffer')

    buffer.available = 4

    buffer.sizeof_ctype = buffer_class.sizeof_ctype
    buffer.size = buffer_class.sizeof_ctype * buffer.available

    buffer.data = ffi.cast(buffer_class.ctype,
        ffi.C.malloc(
            buffer.size))
    
    ffi.C.memset(buffer.data, 0, buffer.size)

    buffer.n = 0
    buffer.version = 0
    
    if data then
        buffer:set(data, ...)
    end
    
    return buffer
end

function buffer_meta:set(data, ...)
    if data then
        if type(data) == 'number' or type(data) == 'cdata' then
            data = {data, ...}
        end

        for i,v in ipairs(data) do
            self[i] = v
        end
    end
end

function buffer_meta.clone(buffer)
    local buf2 = Buffer(ffi.string(buffer.ct))
    buf2:resize(buffer.n)
    ffi.C.memcpy(buf2:addr(), buffer:addr(), buffer.sizeof_ctype * buffer.n)
    buf2.n = buffer.n
    return buf2
end

function buffer_meta.__len(buffer)
    return buffer.n
end

function buffer_meta.__gc(buffer)
    ffi.C.free(buffer.data)
end

function buffer_meta.resize(buffer, n)
    if buffer.available < n then
        local previousAvailable = buffer.available
        local previousSize = buffer.size
        
        buffer.available = n
        buffer.size = buffer.available * buffer.sizeof_ctype

        buffer.data = ffi.cast(ffi.typeof(buffer.data),
            ffi.C.realloc(
                buffer.data,
                buffer.size))
        
        ffi.C.memset(buffer.data+previousAvailable, 0, buffer.size-previousSize)

        assert(buffer.data)
    end
    return buffer
end

local max = math.max
function buffer_meta.__newindex(buffer, key, value)
    if type(key) == 'number' then
        if buffer.available < key then
            buffer:resize(max(buffer.available * 2, key))
        end

        buffer.data[key-1] = value

        buffer.n = max(buffer.n, key)
        buffer.version = buffer.version +1

    else
        rawset(buffer, key, value)
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
    buffer[buffer.n+1] = value
end
buffer_meta.add = buffer_meta.insert

function buffer_meta.addItems(buffer, buf2)
    local n = buffer.n + buf2.n

    if buffer.available < n then
        buffer:resize(max(buffer.available * 2, n))
    end

    ffi.C.memcpy(buffer:addr(buffer.n), buf2:addr(0), buf2.sizeof_ctype * buf2.n)

    buffer.n = n
    buffer.version = buffer.version +1
end

function buffer_meta.remove(buffer, i)
    if i > 0 and i <= buffer.n then
        if i < buffer.n then
            ffi.C.memmove(buffer:addr(i-1), buffer:addr(i), buffer.sizeof_ctype * (buffer.n-i))
        end
        buffer.n = buffer.n - 1
        buffer.version = buffer.version +1
    end
end

function buffer_meta.reset(buffer)
    buffer.n = 0
    buffer.version = buffer.version +1
end

function buffer_meta.sizeof(buffer)
    return buffer.sizeof_ctype * buffer.n
end

function buffer_meta.addr(buffer, i)
    return buffer.data + (i or 0)
end

function buffer_meta.tobytes(buffer)
    return buffer.data
end

function buffer_meta.__ipairs(buffer)
    local i = 0
    local f = function ()
        if i < buffer.n then
            i = i + 1
            return i, buffer[i]
        end
    end
    return f, v, nil
end

function buffer_meta.cast(buffer, ct)
    local buffer2 = Buffer(ct)
    buffer2.data = ffi.cast(ffi.typeof(buffer2.data), buffer.data)

    if buffer.sizeof_ctype > buffer2.sizeof_ctype then
        local coef = buffer.sizeof_ctype / buffer2.sizeof_ctype
        buffer2.available = buffer.available * coef
        buffer2.n = buffer.n * coef
    else
        local coef = buffer2.sizeof_ctype / buffer.sizeof_ctype
        buffer2.available = buffer.available / coef
        buffer2.n = buffer.n / coef
    end

    return buffer2
end

local buffer_classes = {}

function Buffer(ct, data, ...)
    ct = ct or 'float'

    local buffer_class = buffer_classes[ct]

    if buffer_classes[ct] == nil then

        buffer_class = {
            ct = ct,
            ctAsType = 'buffer_'..ct:gsub(' ', '_'),

            ctype = ffi.typeof(ct..'*'),
            sizeof_ctype = ffi.sizeof(ct),

            struct = [[
                typedef struct {ctAsType} {
                    const char* ct;
                    int id;
                    int available;
                    int sizeof_ctype;
                    int size;
                    int n;
                    int version;
                    {ct}* data;
                    } {ctAsType};
            ]]
        }

        buffer_class.typed_struct = buffer_class.struct:format({
                ct = buffer_class.ct,
                ctAsType = buffer_class.ctAsType
            })

        ffi.cdef(buffer_class.typed_struct)

        buffer_class.meta = ffi.metatype(buffer_class.ctAsType, buffer_meta)

        buffer_classes[ct] = buffer_class

    end

    return buffer_class.meta():__init(buffer_class, data, ...)
end
