function setup()
    cam = camera(0, 5, 5)

    model = Model.plane()

    uniforms = {}

    parameter.number('uniforms.freq1', 1, 100, 80)
    parameter.number('uniforms.freq2', 1, 100, 50)
    parameter.number('uniforms.freq3', 1, 100, 20)

    parameter.number('uniforms.octave1', 0, 1, 1)
    parameter.number('uniforms.octave2', 0, 1, 0.5)
    parameter.number('uniforms.octave3', 0, 1, 0.25)

    parameter.number('uniforms.n', 1, 1000, 256)
end

function draw()
    background(51)

    perspective()

    noLight()

--    config.wireframe = 'line'

    model.shader = shaders['terrain2d']
    model.shader.uniforms = model.shader.uniforms or {}

    model.shader.uniforms = uniforms

    model.shader:update()

    local x, z = tointeger(cam.vEye.x), tointeger(cam.vEye.z)

    local w = 128
    
    local b = 10
    for dx = -b,b do
        for dz = -b,b do
            local N, n
            
            local dist = math.abs(dx) + math.abs(dz)
            if dist == 0 then
                N = w
            elseif dist < 2 then                
                N = w/2
            elseif dist < 4 then
                N = w/4
            elseif dist < 8 then
                N = w/8
            else
                N = 2
            end
            
            n = w / N
            
            model.shader.uniforms.n = N
            
            model:drawInstanced(
                N^2,
                nil,
                dx*w + x - w/2,
                0,
                dz*w + z - w/2,
                n,
                n,
                n)
        end
    end
end
