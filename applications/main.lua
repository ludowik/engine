function setup()
    msphere = Model.sphere(1000)
    camera(0, 1000, -1000)
    
    uniforms = {}
    
    parameter.number('uniforms.freq1', 1, 100,  1)
    parameter.number('uniforms.freq2', 1, 100, 20)
    parameter.number('uniforms.freq3', 1, 100, 50)

    parameter.number('uniforms.octave1', 0, 1, 1)
    parameter.number('uniforms.octave2', 0, 1, 0.5)
    parameter.number('uniforms.octave3', 0, 1, 0.25)
end

function draw()
    background(51)
    
    perspective()
    
    light()
    
    msphere.shader = shaders['terrain']
    msphere.shader.uniforms = msphere.shader.uniforms or {}
    
    msphere.shader.uniforms = uniforms
    
    msphere.shader:update()
    
    msphere:draw()
end
