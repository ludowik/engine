class ('BufferManager')

function BufferManager:setup()
    ffi.cdef[[
        typedef struct BufferFloat {
            int zero;
            int available;
            int count;
            const char* ctype;
            float* data;            
        } BufferFloat;
        
        typedef struct BufferUshort {
            int zero;
            int available;
            int count;
            const char* ctype;
            unsigned short* data;
        } BufferUshort;
        
        void *malloc(size_t __size);
        void *calloc(size_t __count, size_t __size);
        void *realloc(void *__ptr, size_t __size);

        void free(void *__ptr);
        
        void *memcpy(void *__dst, const void *__src, size_t __n);
        void *memset(void *__b, int __c, size_t __len);
    ]]

    memMemory = 0
    memAlloc = 0
    memRealloc = 0
    memFree = 0

    __alloc = function (buffer, count, ctype)
        local size = count * ffi.sizeof(ctype)
        memMemory = memMemory + size
        
        local data
        if buffer then
            memRealloc = memRealloc + 1
            data = ffi.cast(ctype..'*', ffi.C.realloc(buffer.data, size))
            assert(data ~= NULL)
        else
            memAlloc = memAlloc + 1
            data = ffi.cast(ctype..'*', ffi.C.malloc(size))
            assert(data ~= NULL)
            ffi.C.memset(data, 0, size)
        end
        
        return data
    end

--    ___alloc = function (buffer, count, ctype)
--        local size = count * ffi.sizeof(ctype)
--        memMemory = memMemory + size
        
--        memAlloc = memAlloc + 1
--        local data = ffi.cast(ctype..'*', ffi.C.malloc(size))
--        assert(data ~= NULL)
--        ffi.C.memset(data, 0, size)

--        if buffer then
--            memMemory = memMemory - buffer.size
--            ffi.C.memcpy(data, buffer.data, buffer.size)
            
--            memFree = memFree + 1
--            ffi.C.free(buffer.data)
--        end
        
--        return data
--    end

    mtBuffer = {
        __len = function (buffer)
            return buffer.count
        end,

        __gc = function (buffer)
            ffi.C.free(buffer.data)
            memMemory = memMemory - buffer.count * ffi.sizeof(ffi.string(buffer.ctype))
            memFree = memFree + 1
        end,

        __newindex = function (buffer, key, value)
            local keyType = type(key)
            if keyType == 'number' then
                local count = max(buffer.count, key+1-buffer.zero)

                if count > buffer.available then
                    repeat
                        buffer.available = buffer.available * 2
                    until buffer.available >= count

                    buffer.data = __alloc(buffer, buffer.available, ffi.string(buffer.ctype))
                end

                buffer.data[key-buffer.zero] = value
                buffer.count = count
            else
                rawset(buffer, key, value)
            end
        end,

        __index = function (buffer, key)
            local keyType = type(key)
            if keyType == 'number' then
                return buffer.data[key-buffer.zero]
            else
                return rawget(buffer, key)
            end
        end,
    }

    newBufferFloat = ffi.metatype('BufferFloat', mtBuffer)
    
    newBufferUshort = ffi.metatype('BufferUshort', mtBuffer)

    Buffer = function (ctype, n, zero)
        ctype = ctype or 'float'

        local buffer
        if ctype == 'float' then
            buffer = newBufferFloat()
        else
            buffer = newBufferUshort()
        end

        buffer.zero = zero or 0
        buffer.available = n or 2
        buffer.count = 0
        buffer.ctype = ctype
        buffer.data = __alloc(NULL, buffer.available, ffi.string(buffer.ctype))
        return buffer
    end

    BufferLua = function (ctype, n)
        return Buffer(ctype, n, 1)
    end
end
