class 'ShaderManager' : extends(Component)

function ShaderManager:initialize()
    shaders = {
        default  = Shader('default'),
        point    = Shader('point'),
        line     = Shader('line'),
        polyline = Shader('line'),
        polygon  = Shader('line'),
        ellipse  = Shader('default'),
        rect     = Shader('default'),
        sprite   = Shader('sprite'),
        text     = Shader('text'),
        box      = Shader('default'),
    }
end

function ShaderManager:release()
    for shaderName,shader in pairs(shaders) do
        shader:release()
    end
end
