class('Shaders')

function Shaders.setup()
    Shader.shaders = {}

    Shader.shadersPath = 'graphics/opengl/shaders'

    Shader.shaders['default'] = Shader('default',
        {'include.vertex', 'default.vertex'},
        {'include.fragment', 'default.fragment'})

    Shader.shaders['line'] = Shader('line',
        {'include.vertex', 'line.vertex'},
        {'include.fragment', 'line.fragment'})

    Shader.shaders['rect'] = Shader('rect',
        {'include.vertex', 'circle.vertex'},
        {'include.fragment', 'rect.fragment'})

    Shader.shaders['circle'] = Shader('circle',
        {'include.vertex', 'circle.vertex'},
        {'include.fragment', 'circle.fragment'})

    Shader.shaders['sprite'] = Shader('sprite',
        {'include.vertex', 'circle.vertex'},
        {'include.fragment', 'sprite.fragment'})

    Shader.shaders['text'] = Shader('text',
        {'include.vertex', 'circle.vertex'},
        {'include.fragment', 'text.fragment'})

    Shader.shaders['mesh'] = Shader('mesh',
        {'include.vertex', 'default.vertex'},
        {'include.fragment', 'default.fragment'})

    Shader.shaders['basic'] = Shader('basic',
        {'include.vertex', 'basic.vertex'},
        {'include.fragment', 'basic.fragment'})

    Shader.shaders['terrain'] = Shader('terrain',
        {'include.vertex', 'noise3D.glsl', 'terrain.vertex'},
        {'include.fragment', 'terrain.fragment'})
end
