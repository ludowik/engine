class 'Shader'

function Shader:init(name)
    gl.glCreateProgram()
end

function initShaders()
    defaultShader = Shader('default')
end
