local lib_path
if os.name == 'osx' then 
    lib_path = 'OpenAL.framework/OpenAL'
else
    lib_path = 'System32/OpenAL32'
end

local code, defs = precompile(io.read('./libc/openal/openal.c'))
ffi.cdef(code)

class 'OpenAL' : extends(Component) : meta(ffi.load(lib_path))

function OpenAL:loadProcAdresses()
    self.defs = {
        -- error
        'alGetError',
        
        -- source,
        'alGenSources',
        'alDeleteSources',
        'alGetSourcei',
        'alSourcef',
        'alSource3f',
        'alSourcei',
        'alSourcePlay',
        'alSourceStop',

        -- buffer
        'alGenBuffers',
        'alDeleteBuffers',
        'alBufferData',
        
        -- listener
        'alListener3f',
        'alListenerfv',
    }

    for i,v in ipairs(self.defs) do
        local f = ffi.cast('PFN_'..v, al.alGetProcAddress(v))
        self.defs[v] = f
        self[v] = function (...)
            local res = f(...)
            local err = self.defs.alGetError()
            if err ~= self.AL_NO_ERROR then
                for k,v in pairs(self) do
                    if v == err then
                        errAsString = k
                        break
                    end
                end
                local error_name = string.format('OpenAL Error %s : 0x%x %s', v, err, errAsString)
                assert(false, error_name)
            end
            return res
        end
    end

    for k,v in pairs(defs) do
        self[k] = v
    end
end

function OpenAL:initialize()
    self:loadProcAdresses()

    intptr = ffi.new('ALint[1]')
    idptr  = ffi.new('ALuint[1]')

    function self.alGenBuffer()
        self.alGenBuffers(1, idptr)
        return idptr[0]
    end

    function self.alDeleteBuffer(buffer)
        idptr[0] = buffer
        self.defs.alDeleteBuffers(1, idptr)
    end

    function self.alGenSource()
        self.alGenSources(1, idptr)
        return idptr[0]
    end

    function self.alDeleteSource(source)
        idptr[0] = source
        self.defs.alDeleteSources(1, idptr)
    end

    function self.alGetSource(source, param)
        self.alGetSourcei(source, param, idptr)
        return idptr[0]
    end
    
    -- device opening
    al.device = al.alcOpenDevice(NULL)

    -- context creation and initialization
    al.context = al.alcCreateContext(al.device, NULL)
    al.alcMakeContextCurrent(al.context)

    -- defining and configuring the listener
    local listenerOri = ffi.new("float[6]", { 0, 0, 1, 0, 1, 0 })

    al.alListener3f(al.AL_POSITION, 0, 0, 1)
    al.alListener3f(al.AL_VELOCITY, 0, 0, 0)
    al.alListenerfv(al.AL_ORIENTATION, listenerOri)

    -- source generation
    al.source = al.alGenSource()

    al.alSourcef(al.source, al.AL_GAIN, 1)
    al.alSourcef(al.source, al.AL_PITCH, 1)
    al.alSourcei(al.source, al.AL_LOOPING, al.AL_FALSE)

    al.alSource3f(al.source, al.AL_POSITION, 0, 0, 0)
    al.alSource3f(al.source, al.AL_VELOCITY, 0, 0, 0)
end

function OpenAL:release()
    al.alSourceStop(al.source)
    al.alSourcei(al.source, al.AL_BUFFER, 0)
    al.alDeleteSource(al.source)

    -- get context and device
    local context = al.alcGetCurrentContext()
    local device = al.alcGetContextsDevice(context)

    -- unbind context
    al.alcMakeContextCurrent(NULL)

    -- destroy context
    al.alcDestroyContext(context)

    -- close device
    al.alcCloseDevice(device)
end
