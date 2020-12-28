local function hzFromKey(n)
    return 2^((n-49)/12) * 440
end

local function keyFromHz(hz)
    return floor(12 * math.log(hz/440, 2) + 49)
end

App('AppSound')

function AppSound:init()
    Application.init(self)
    
    audio = sound({
            -- seed
            Seed = 455854,

            -- waveform
            Waveform = SOUND_SQUAREWAVE,

            -- envelope
            AttackTime = 2,
            SustainTime = 2,
            SustainPunch = 1,
            DecayTime = 1,

            -- frequency
            StartFrequency = 0.0,
            MinimumFrequency = 0.2,
            Slide = 0.2,
            DeltaSlide = 0.2,

            -- vibrato
            VibratoDepth = 0.5,
            VibratoSpeed = 0.2,
            VibratoDelay = 1           
        })

    params:add(MenuBar('Sounds')
        :action('play', function ()
                audio:play()
            end)
        :action('mutate', function ()
                audio:mutate()
                audio:play()
            end)
        :action('save', function ()
                audio:save('_res/sounds/random')
            end)
        :action('load', function ()
                audio:loadBufferFromSfxr('_res/sounds/random')
            end)
        :action('blit', function ()
                audio = sound(SOUND_BLIT)
            end)
        :action('explode', function ()
                audio = sound(SOUND_EXPLODE)
            end)
        :action('hit', function ()
                audio = sound(SOUND_HIT)
            end)
        :action('jump', function ()
                audio = sound(SOUND_JUMP)
            end)
        :action('pickup', function ()
                audio = sound(SOUND_PICKUP)
            end)
        :action('powerup', function ()
                audio = sound(SOUND_POWERUP)
            end)
        :action('shoot', function ()
                audio = sound(SOUND_SHOOT)
            end)
        :action('square', function ()
                audio = sound({
                        Waveform = SOUND_SQUAREWAVE
                    })
            end)
        :action('sinus', function ()
                audio = sound({
                        Waveform = SOUND_SINEWAVE
                    })
            end)
        :action('saw', function ()
                audio = sound({
                        Waveform = SOUND_SAWTOOTH
                    })
            end)
        :number('hz', 0, 4186, 1046.50,
            function ()
                keyNumber = keyFromHz(hz)

                audio:stop()
                audio:loadBuffer(amplitude, hz, sampleRate)
                audio:play(true)
            end)
        :number('keyNumber', 1, 102, 49,
            function ()
                hz = hzFromKey(keyNumber)
                audio:stop()
                audio:loadBuffer(amplitude, hz, sampleRate)
                audio:play(true)
            end)
        :number('sampleRate', 0, 44100, 44100,
            function ()
                audio:stop()
                audio:loadBuffer(amplitude, hz, sampleRate)
                audio:play(true)
            end))
end

function AppSound:_draw()
    local sampleRate = audio.sampleRate or 44100
    
    local vertices = Table()
    local verticesFin = Table()
    for i=0,sampleRate-1 do
        vertices:add(vec3(#vertices, audio.buffer[i]))
    end
    for i=sampleRate-100,sampleRate-1 do
        verticesFin:add(vec3(#verticesFin, audio.buffer[i]))
    end

    pushMatrix()
    do
        translate(100, HEIGHT/2)
        scale(1, 100/AMPLITUDE_MAX)

        noFill()
        polygon(vertices)
    end
    popMatrix()

    pushMatrix()
    do
        translate(0, HEIGHT/2)
        scale(1, 100/AMPLITUDE_MAX)

        noFill()
        polygon(verticesFin)
    end
    popMatrix()

end
