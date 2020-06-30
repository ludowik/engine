local lib_path
if os.name == 'osx' then 
    lib_path = 'OpenAL.framework/OpenAL'
else
    lib_path = 'System32/OpenAL32'
end

local code, defs = precompile(io.read('./libc/openal.c'))
ffi.cdef(code)

class 'OpenAL' : meta(ffi.load(lib_path))

al = OpenAL()

function OpenAL:setup()
end

function OpenAL:update()
end

function OpenAL:release()
end

local device = al.alcOpenDevice(ffi.NULL)

if device then
    context = al.alcCreateContext(device, ffi.NULL)

    if context then
        al.alcMakeContextCurrent(context)

        local id_ptr = ffi.new('ALuint[1]')
        al.alGenBuffers(1, id_ptr)

        local id = id_ptr[0]
        if al.alIsBuffer(id) then

            local source_ptr = ffi.new('ALuint[1]')
            al.alGenSources(1, source_ptr)

            local source = source_ptr[0]
            if al.alIsSource(source) then
                al.alSourcef(source, al.AL_GAIN, 1)
                al.alSourcef(source, al.AL_PITCH, 1)
                al.alSourcei(source, al.AL_LOOPING, al.AL_FALSE)

                al.alSource3f(source, al.AL_POSITION, 0, 0, 0)
                al.alSource3f(source, al.AL_VELOCITY, 0, 0, 0)

                al.alSourcePlay(source)
                al.alSourceStop(source)
                
                al.alSourcei(source, al.AL_BUFFER, 0)
                
                al.alDeleteSources(1, source_ptr)
            end
            
            al.alDeleteBuffers(1, id_ptr)

        end

        al.alcMakeContextCurrent(ffi.NULL)
        al.alcDestroyContext(context)
    end

    al.alcCloseDevice(device)
end