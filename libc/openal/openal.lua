local code, defs = Library.precompile(io.read('libc/openal/openal.c'))
ffi.cdef(code)

local loaded = love

class 'OpenAL' : extends(Component) : meta(not loaded and Library.load('OpenAL', 'OpenAL32') or ffi.C)

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
        'alIsBuffer',
        'alGenBuffers',
        'alDeleteBuffers',
        'alBufferData',

        -- listener
        'alListener3f',
        'alListenerfv',
    }

    for i,v in ipairs(self.defs) do
        local procAddr = al.alGetProcAddress(v)
        local f = ffi.cast('PFN_'..v, procAddr)

        self.defs[v] = f
        self[v] = function (...)
            local res = f(...)
            local err = self.defs.alGetError()
            if err ~= self.AL_NO_ERROR then
                for k,v in pairs(self) do
                    if v == err then
                        errName = k
                        break
                    end
                end
                local errDescription = string.format('OpenAL Error %s : 0x%x %s', v, err, errName)
                assert(false, errDescription)
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

    self.intptr = ffi.new('ALint[1]')
    self.idptr  = ffi.new('ALuint[1]')

    self.nbuffers = 0

    function self.alGenBuffer()
        self.nbuffers = self.nbuffers + 1
        self.alGenBuffers(1, self.idptr)
        return self.idptr[0]
    end

    function self.alDeleteBuffer(buffer)
        self.nbuffers = self.nbuffers - 1
        self.idptr[0] = buffer
        self.defs.alDeleteBuffers(1, self.idptr)
    end

    function self.alGenSource()
        self.alGenSources(1, self.idptr)
        return self.idptr[0]
    end

    function self.alDeleteSource(source)
        self.idptr[0] = source
        self.defs.alDeleteSources(1, self.idptr)
    end

    function self.alGetSource(source, param)
        self.alGetSourcei(source, param, self.idptr)
        return self.idptr[0]
    end

    -- device opening
    al.device = al.alcOpenDevice(NULL)
    if al.device ~= NULL then
        -- context creation and initialization
        al.context = al.alcCreateContext(al.device, NULL)
        al.alcMakeContextCurrent(al.context)
    end

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
    
    self.intptr = nil
    self.idptr  = nil
end
