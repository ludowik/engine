class 'ShaderManager' : extends(Component)

function ShaderManager:initialize()
    shaders = {
        default = Shader('default'),

        point  = Shader('point'),
        points = Shader('point'),

        line  = Shader('line'),
        lines = Shader('line'),

        polyline = Shader('line'),

        polygon  = Shader('line'),

        rect       = Shader('polygon'),
        rectBorder = Shader('line'),

        circle = Shader('circle'),
--        circleBorder = Shader('line'),

        ellipse       = Shader('circle'),
--        ellipseBorder = Shader('line'),

        sprite = Shader('sprite'),

        text = Shader('text'),

        box = Shader('default'),
        sphere = Shader('default'),

        model3d = Shader('default'),

        terrain = Shader('terrain'),
        terrain2d = Shader('terrain2d')
    }
end

function ShaderManager:release()
    for shaderName,shader in pairs(shaders) do
        shader:release()
    end
end
