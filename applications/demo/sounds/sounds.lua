local function hzFromKey(n)
    return 2^((n-49)/12) * 440
end

local function keyFromHz(hz)
    return floor(12 * math.log(hz/440, 2) + 49)
end

application('AppSound')

function AppSound:init()
    Application.init(self)

    audio = sound(SOUND_BLIT)

    keyNumber = 49
    hz = hzFromKey(keyNumber)
    sampleRate = 44100

    parameter.add(MenuBar('Sounds')
        :action('play', function ()
                audio:play()
            end)
        :action('mutate', function ()
                audio:mutate()
                audio:play()
            end)
        :action('save', function ()
                audio:save('res/sounds/random')
            end)
        :action('load', function ()
                audio:loadBufferFromSfxr('res/sounds/random')
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
        :number('hz', 0, 4186, hz,
            function ()
                keyNumber = keyFromHz(hz)

                audio:stop()
                audio:loadBuffer(amplitude, hz, sampleRate)
                audio:play(true)
            end)
        :number('keyNumber', 1, 102, keyNumber,
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

    parameter.watch('al.nbuffers')
end

function AppSound:draw()
    background()

    local sampleRate = audio:getSampleRate()
    local sampleCount = audio:getSampleCount()

    local vertices = Buffer('vec3')
    local verticesFin = Buffer('vec3')

    for i=0,sampleCount-1 do
        vertices:add(vec3(#vertices, audio:getSample(i)))
    end

    for i=max(0, sampleCount-100),sampleCount-1 do
        verticesFin:add(vec3(#verticesFin, audio:getSample(i)))
    end

    pushMatrix()
    do
        translate(100, HEIGHT/2)
        scale(1, 100/AMPLITUDE_MAX)

        noFill()
        polyline(vertices)
    end
    popMatrix()

    pushMatrix()
    do
        translate(0, HEIGHT/2)
        scale(1, 100/AMPLITUDE_MAX)

        noFill()
        polyline(verticesFin)
    end
    popMatrix()
end
