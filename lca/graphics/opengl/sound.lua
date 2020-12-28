sfxr = require 'tools.lib.sfxr'

AMPLITUDE_MAX = (2^15-1)

SOUND_RANDOM = sfxr.Sound.randomize

SOUND_BLIT = sfxr.Sound.randomBlip
SOUND_EXPLODE = sfxr.Sound.randomExplosion
SOUND_HIT = sfxr.Sound.randomHit
SOUND_JUMP = sfxr.Sound.randomJump
SOUND_PICKUP = sfxr.Sound.randomPickup
SOUND_POWERUP = sfxr.Sound.randomPowerup
SOUND_SHOOT = sfxr.Sound.randomLaser

SOUND_NOISE = sfxr.WAVEFORM.NOISE

SOUND_SQUAREWAVE = sfxr.WAVEFORM.SQUARE
SOUND_SINEWAVE = sfxr.WAVEFORM.SINE

SOUND_SAWTOOTH = sfxr.WAVEFORM.SAW

DATA = 'data'

DECODE = 'decode'
ENCODE = 'encode'

class('Audio')

function Audio.setup()
    local function info(func, code, description)
        print(code..'('..tonumber(al[code])..') : '..description)
    end

--    print('AL_OUT_OF_MEMORY('..tonumber(al.AL_OUT_OF_MEMORY)..') : There is not enough memory available to create this buffer.')
--    print('AL_INVALID_VALUE('..tonumber(al.AL_INVALID_VALUE)..') : The size parameter is not valid for the format specified, the buffer is in use, or the data is a NULL pointer.')
--    print('AL_INVALID_ENUM ('..tonumber(al.AL_INVALID_ENUM )..') : The specified format does not exist.')

--    info('alGetSourcei', 'AL_INVALID_VALUE', 'The value pointer given is not valid.')
--    info('alGetSourcei', 'AL_INVALID_ENUM', 'The specified parameter is not valid.')
--    info('alGetSourcei', 'AL_INVALID_NAME', 'The specified source name is not valid.')
--    info('alGetSourcei', 'AL_INVALID_OPERATION', 'There is no current context.')
end

function Audio:init(name, ...)
    self.id = -1

    self.sampleRate = sampleRate or 44100

    if name then
        self:load(name)
    end
end

function Audio:genBuffer()
    -- buffer generation
    if self.id > 0 and al.alIsBuffer(self.id) == al.AL_TRUE then
        self:release()
    end

    self.id = al.alGenBuffer()
end

function Audio:load(file)
    self:genBuffer()

    -- loading an audio stream to a buffer
    local wavspec, wavbuf, wavlen = sdl.loadWav(file)
    assert(wavspec ~= NULL)

    -- map wav header to openal format
    local format
    if wavspec.format == sdl.AUDIO_U8 or wavspec.format == sdl.AUDIO_S8 then
        format = wavspec.channels == 2 and al.AL_FORMAT_STEREO8 or al.AL_FORMAT_MONO8

    elseif wavspec.format == sdl.AUDIO_U16 or wavspec.format == sdl.AUDIO_S16 then
        format = wavspec.channels == 2 and al.AL_FORMAT_STEREO16 or al.AL_FORMAT_MONO16

    else
        sdl.SDL_FreeWAV(wavspec)
        assert(false)
    end

    al.alBufferData(self.id, format, wavbuf[0], wavlen[0], wavspec.freq)

    sdl.SDL_FreeWAV(wavbuf[0])
end

function Audio:loadBuffer(amplitude, Hz, sampleRate)
    self:genBuffer()

    -- sound generation
    self.amplitude = amplitude or AMPLITUDE_MAX
    self.Hz = Hz or 440
    self.sampleRate = sampleRate or 44100

    self.F = TAU * floor(self.Hz) / self.sampleRate

    self.buffer = ffi.new('int16_t[?]', self.sampleRate)

    for t=0,self.sampleRate-1 do
        self.buffer[t] = floor(self.amplitude * sin(self.F * t))
    end

    -- buffer alimentation
    self:stop()
    al.alBufferData(self.id, -- buffer id
        al.AL_FORMAT_MONO16, -- format
        self.buffer,
        ffi.sizeof(self.buffer), -- size in bytes
        self.sampleRate)
end

function Audio:loadBufferFromSfxr(f)
    self:genBuffer()

    -- sound randomization
    self.amplitude = amplitude or AMPLITUDE_MAX
    self.Hz = Hz or 440

    local sound = sfxr.newSound()
    self.sound = sound

    if type(f) == 'function' then
        f(sound)

    elseif type(f) == 'table' then
        sound.waveform = f.Waveform or sound.waveform

        sound.repeatspeed = f.RepeatSpeed or sound.repeatspeed

        sound.envelope.attack  = f.AttackTime   or sound.envelope.attack
        sound.envelope.sustain = f.SustainTime  or sound.envelope.sustain
        sound.envelope.punch   = f.SustainPunch or sound.envelope.punch
        sound.envelope.decay   = f.DecayTime    or sound.envelope.decay

        sound.frequency.start  = f.StartFrequency   or sound.frequency.start
        sound.frequency.min    = f.MinimumFrequency or sound.frequency.min
        sound.frequency.slide  = f.Slide            or sound.frequency.slide
        sound.frequency.dslide = f.DeltaSlide       or sound.frequency.dslide

        sound.vibrato.depth = f.VibratoDepth or sound.vibrato.depth
        sound.vibrato.speed = f.VibratoSpeed or sound.vibrato.speed
        sound.vibrato.delay = f.VibratoDelay or sound.vibrato.delay

        sound.change.amount = f.ChangeAmount or sound.change.amount
        sound.change.speed  = f.ChangeSpeed  or sound.change.speed

        if f.SquareDuty then
            sound.duty.ratio = (0.5 - square_duty) / 0.5
        end
        sound.duty.sweep = f.DutySweep  or sound.duty.sweep

        sound.phaser.offset = f.PhaseOffset or sound.phaser.offset
        sound.phaser.sweep  = f.PhaserSweep or sound.phaser.sweep

        sound.lowpass.cutoff    = f.LowPassFilterCutoff       or sound.lowpass.cutoff
        sound.lowpass.sweep     = f.LowPassFilterCutoffSweep  or sound.lowpass.sweep
        sound.lowpass.resonance = f.LowPassFilterResonance    or sound.lowpass.resonance

        sound.highpass.cutoff   = f.HighPassFilterCutoff      or sound.highpass.cutoff
        sound.highpass.sweep    = f.HighPassFilterCutoffSweep or sound.highpass.sweep

        sound.volume.sound = f.Volume or sound.volume.sound

        sound:randomize(f.Seed)

    elseif f == DATA then
        -- TODO : Can also be DATA followed by a base64 string encoding the parameters which is generated by Codea based on the sound picker panel properties and should not be edited

    else
        sound:load(f)
    end

    self:generateFromTable()
end

function Audio:generateFromTable(sound)
    sound = self.sound or sound

    local tab, count = sound:generateTable(44100, 0)

    self.buffer = ffi.new('int16_t[?]', count)

    for t=0,count-1 do
        tab[t+1] = tab[t+1] or 0
        self.buffer[t] = tab[t+1] * self.amplitude
    end

    self.sampleRate = count

    -- buffer alimentation
    self:stop()

    al.alBufferData(self.id, -- buffer id
        al.AL_FORMAT_MONO16, -- format
        self.buffer,
        ffi.sizeof(self.buffer), -- size in bytes
        self.sampleRate)
end

function Audio:save(name)
    if self.sound then
        self.sound:save(name)
    end
end

function Audio:mutate(name)
    if self.sound then
        self.sound:mutate()
        self:generateFromTable()
    end
end

function Audio:release()
    al.alSourceStop(al.source)
    al.alSourcei(al.source, al.AL_BUFFER, 0)

    al.alDeleteBuffer(self.id)

    self.id = -1
end

function Audio:play(loop, volume, pan)
    al.alSourceStop(al.source)

    -- assign the buffer to this source
    al.alSourcei(al.source, al.AL_BUFFER, self.id)
    --al.alSourceQueueBuffers(al.source, 1, al.int(1, self.id))

    -- loop?
    al.alSourcei(al.source, al.AL_LOOPING, loop and al.AL_TRUE or al.AL_FALSE)

    -- set volume
    al.alSourcef(al.source, al.AL_GAIN, volume or config.volume or 1)

    -- pan
    al.alListener3f(al.AL_POSITION, pan or 0, 0, 0)

    -- play
    al.alSourcePlay(al.source)
end

function Audio:stop()
    if al.alGetSource(al.source, al.AL_SOURCE_STATE) == al.AL_PLAYING then
        al.alSourceStop(al.source)
    end
end

function Audio:getSampleCount()
    return self.sampleRate
end

function Audio:getSampleRate()
    return self.sampleRate
end

function Audio:getSample(i)
    return self.buffer and self.buffer[i] or 0
end

function music(file, loop, volume, pan)
    Audio(file):play(loop, volume, pan)
end

do 
    local audio
    function sound(name)
        local audio = Audio()

        if name then
            audio:loadBufferFromSfxr(name)
            audio:play()
        end

        return audio
    end

    function soundBufferSize()
        -- TODO
        return 0, 0
    end
end
