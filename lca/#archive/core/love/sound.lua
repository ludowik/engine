sfxr = require 'lib.sfxr'

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
end

function Audio:init(name, ...)
    self.sound = sfxr.newSound()

    local nameType = type(name)
    
    if name == DATA then
        self.sound:randomize()
    elseif name == ENCODE then
        self.sound:randomize()
    elseif nameType == 'function' then
        name(self.sound)
    elseif nameType == 'string' then
        print(name, ...)
        love.sound.newSoundData(name)
    else
        self.sound:randomize()
    end

    self:load()
    self:play()
end

function Audio:load()
    self.buffer = self.sound:generateSoundData()
    self.source = love.audio.newSource(self.buffer)
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

    self.F = TAU * floor(self.Hz) / self.sampleRate

    self.buffer = love.sound.newSoundData(self.sampleRate/60,
        self.sampleRate,
        16,
        1)

    for t=0,self.buffer:getSampleCount()-1 do
        self.buffer:setSample(t, floor(self.amplitude * sin(self.F * t)))
    end

    self:load()
end

function Audio:getSampleCount()
    return self.buffer:getSampleCount()
end

function Audio:getSampleRate()
    return self.buffer:getSampleRate()
end

function Audio:getSample(i)
    return self.buffer:getSample(i)
end

function music(file, loop, volume, pan)
    Audio(file):play(loop, volume, pan)
end

do 
    local audio
    function sound(...)
        audio = Audio(...)
        return audio
    end

    function soundBufferSize(_)
        if audio == nil then return 0, 0 end

        local size = audio.buffer:getSize()
        return size, size
    end
end
