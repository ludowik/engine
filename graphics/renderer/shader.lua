local Shader = class 'Shader'

function Shader:init(name, path)
    self.name = name
    self.path = path or 'graphics/shaders'
    
    self:create()
end

function Shader:__tostring()
    return self.name
end

function Shader:create()
end

function Shader:update()
end

function Shader:compile()
end

function Shader:release()
end

function Shader:use()
end

function Shader:unuse()
end
