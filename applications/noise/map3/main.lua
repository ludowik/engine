function setup()
    model = Model.plane()

    uniforms = {}

    parameter.number('uniforms.freq1', 5, 50, 10)
    parameter.number('uniforms.freq2', 1, 1000, 50)
    parameter.number('uniforms.freq3', 1, 1000, 20)

    parameter.number('uniforms.octave1', 0, 1, 1)
    parameter.number('uniforms.octave2', 0, 1, 0)
    parameter.number('uniforms.octave3', 0, 1, 0)

    cam = camera(0, 250, 10, 0, 200, 0)
    
    parameter.watch('isButtonDown(1)')
    parameter.watch('isButtonDown(2)')
    parameter.watch('isButtonDown(3)')
    parameter.watch('isButtonDown(4)')
    parameter.watch('isButtonDown(5)')
end

function draw()
    background(51)

    perspective()

    noLight()

    model.shader = shaders['terrain2d']
    model.shader.uniforms = model.shader.uniforms or {}

    model.shader.uniforms = uniforms

    model.shader:update()

    local x, y, z = tointeger(cam.vEye.x), tointeger(cam.vEye.y), tointeger(cam.vEye.z)

    local w = 256
    
    local b = 10
    
    local n, N, dist
    for dx = -b,b do
        for dz = -b,b do            
            dist = math.sqrt(dx^2 + dz^2)
            
            n = max(1, 2^floor(dist))
            N = w / n
            
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
