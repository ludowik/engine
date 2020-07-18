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
        
        circle = Shader('polygon'),
        circleBorder = Shader('line'),
        
        ellipse       = Shader('polygon'),
        ellipseBorder = Shader('line'),
        
        sprite = Shader('sprite'),
        
        text = Shader('text'),
        
        box = Shader('default'),
        
        b3d = Shader('default'),
        
        terrain = Shader('terrain')
    }
end

function ShaderManager:release()
    for shaderName,shader in pairs(shaders) do
        shader:release()
    end
end
