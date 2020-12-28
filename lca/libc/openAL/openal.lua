local srcPath, lib = ...
if osx then
    lib = 'OpenAL.framework/OpenAL'
else
    lib = 'system32/OpenAL32'
end

local content = [[
    #include <openAL/al.h>
    #include <openAL/alc.h>
]]

al = Lib(srcPath, 'openAL', lib, content, 'AL')

function al.initializeDefs()
    for i,fn in ipairs({    
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

        local func = al.defsLoaded[fn]

        al.defs[fn] = function (...)
            local result = func(...)
            if al.alGetError() ~= al.AL_NO_ERROR then
                al.exitOnError(fn)
            end
            return result
        end

    end

    al.defs.alGetError = al.defsLoaded.alGetError

    al.defsLoaded = nil
end

local errors = {}

function al.exitOnError(fn)
    local errorFlag = al.alGetError()
    while errorFlag ~= al.AL_NO_ERROR do
        local i = 0
        while true do
            i = i + 1

            local errorLabel = getFunctionLocation(i..'.ERR('..al.formatError(errorFlag)..'):', i)
            if errorLabel == nil or errors[errorLabel] then
                break
            end
            errors[errorLabel] = errorLabel

            print(fn..':'..errorLabel)
        end
        errorFlag = al.alGetError()        
    end
    assert()
end

function al.formatError(err)
    for k,v in pairs(al) do
        if v == err then
            return k
        end
    end
    return string.format('0x%02X', err)..','..err
end

function al.initialize()
    al.initializeDefs()

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
    local idptr = al.uint()
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
    local idptr = al.uint()
    al.alDeleteSource = function(id)
        idptr[0] = id
        al.alDeleteSources(1, idptr)
    end
    al.alDeleteSource(id)
end

function al.alGetSource(...)
    local idptr = al.uint()
    al.alGetSource = function(source, param)
        al.alGetSourcei(source, param, idptr)
        return idptr[0]
    end
    al.alGetSource(...)
end

return al
