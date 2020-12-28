-- OpenAL

al = al or class()

function al.load()
    if al.loaded then return end
    al.loaded = true

    if osx then
        local content = [[
            #include <openAL/al.h>
            #include <openAL/alc.h>
            ]]

        save(osLibPath..'/openal/src/stub.c', content)

        os.execute(
            "gcc -F/Library/Frameworks     -E '"..osLibPath.."/openal/src/stub.c' | grep -v '^#' > '"..osLibPath.."/openal/src/ffi_OpenAL.c';"..
            "gcc -F/Library/Frameworks -dM -E '"..osLibPath.."/openal/src/stub.c'                > '"..osLibPath.."/openal/src/ffi_OpenAL.h';")
    end

    local lib
    if osx then
        lib = 'OpenAL'
    else
        lib = 'system32/OpenAL32'
    end

    cload(al,
        lib,
        'AL_',
        osLibPath..'/openal/src/ffi_OpenAL.h',
        osLibPath..'/openal/src/ffi_OpenAL.c',
        true)

    for i,v in ipairs({    
            'alcOpenDevice',
            'alcCloseDevice',
            'alcGetContextsDevice',

            'alcCreateContext',
            'alcDestroyContext',
            'alcMakeContextCurrent',
            'alcGetCurrentContext',

            'alListener3f',
            'alListenerfv',
            'alGenBuffers',
            'alDeleteBuffers',
            'alIsBuffer',
            'alBufferData',
            'alGenSources',
            'alDeleteSources',
            'alSource3f',
            'alSourcef',
            'alSourcei',
            'alSourcePlay',
            'alSourceStop',
            'alGetSourcei'
            }) do
        
        local func = al.defsLoaded[v]        
        al.defs[v] = function (...)
            local result = func(...)
            al.exitOnError(v)
            return result
        end

        al.defs.alGetError = al.defsLoaded.alGetError
    end
    
    al.defsLoaded = nil
end

local errors = {}
function al.exitOnError(txt)
    local err = al.alGetError()
    while err ~= al.AL_NO_ERROR do
        local i = 2
        while true do
            local error = getFunctionLocation((i-1)..'.ERR('..string.format('0x%02X', err)..','..err..'):', i)
            if error == nil or errors[error] then
                break
            end

            errors[error] = error
            print(error)

            i = i + 1
        end
        err = al.alGetError()
    end
end

function al.init()
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

function al.release()
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

function al.int(len, value)
    return ffi.new('ALint[?]', len or 1, value or 0)
end

function al.uint(len, value)
    return ffi.new('ALuint[?]', len or 1, value or 0)
end

function al.alGenBuffer()
    local id = al.uint()
    al.alGenBuffer = function()
        al.alGenBuffers(1, id)
        return id[0]
    end
    return al.alGenBuffer()
end

function al.alDeleteBuffer(id)
    local idptr = gl.uint()
    al.alDeleteBuffer = function(id)
        idptr[0] = id
        al.alDeleteBuffers(1, idptr)
    end
    al.alDeleteBuffer(id)
end

function al.alGenSource()
    local id = al.uint()
    al.alGenSource = function()
        al.alGenSources(1, id)
        return id[0]
    end
    return al.alGenSource()
end

function al.alDeleteSource(id)
    local idptr = gl.uint()
    al.alDeleteSource = function(id)
        idptr[0] = id
        al.alDeleteSources(1, idptr)
    end
    al.alDeleteSource(id)
end

function al.alGetSource(...)
    local idptr = gl.int()
    al.alGetSource = function(source, param)
        al.alGetSourcei(source, param, idptr)
        return idptr[0]
    end
    al.alGetSource(...)
end

return al
