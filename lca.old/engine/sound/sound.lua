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

function Audio:init(name, ...)
    self.sound = sfxr.newSound()

    if name == DATA then
        self.sound:randomize()
    elseif name == ENCODE then
        self.sound:randomize()
    elseif type(name) == 'function' then
        name(self.sound)
    elseif type(name) == 'string' then
        print(name, ...)
        lca.sound.newSoundData(name)
    else
        self.sound:randomize()
    end

    self:load()
    self:play()
end

function Audio:load()
    self.sounddata = self.sound:generateSoundData()
    self.source = lca.audio.newSource(self.sounddata)
end

function Audio:play()
    self.source:play()
end

function Audio:stop()
    self.source:stop()
end

function Audio:mutate()
    self:stop()
    self.sound:mutate()

    self:load()
end

function Audio:loadBuffer(amplitude, Hz, sampleRate)
    self.amplitude = amplitude or AMPLITUDE_MAX
    self.Hz = Hz or 440
    self.sampleRate = sampleRate or 44100

    self.F = 2 * pi * floor(self.Hz) / self.sampleRate

    self.sounddata = lca.sound.newSoundData(self.sampleRate/60,
        self.sampleRate,
        16,
        1)

    for t=0,self.sounddata:getSampleCount()-1 do
        self.sounddata:setSample(t, floor(self.amplitude * sin(self.F * t)))
    end

    self:load()
end

do 
    local audio
    function sound(...)
        audio = Audio(...)
        return audio
    end

    function soundBufferSize(_)
        if audio == nil then return 0, 0 end

        local size = audio.sounddata:getSize()
        return size, size
    end
end
