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
        
        circle = Shader('default'),
        circleBorder = Shader('line'),
        
        ellipse       = Shader('default'),
        ellipseBorder = Shader('line'),
        
        rect       = Shader('default'),
        rectBorder = Shader('line'),
        
        sprite = Shader('sprite'),
        
        text = Shader('text'),
        
        box = Shader('default'),
        
        b3d = Shader('default'),
    }
end

function ShaderManager:release()
    for shaderName,shader in pairs(shaders) do
        shader:release()
    end
end
