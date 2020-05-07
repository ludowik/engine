class 'Shader'

function Shader:init(name)
    self.program_id = gl.glCreateProgram()

    self.vertex_id = self:build(gl.GL_VERTEX_SHADER, name, 'vertex')
    self.fragment_id = self:build(gl.GL_FRAGMENT_SHADER, name, 'fragment')

    gl.glLinkProgram(self.program_id)

    local err = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if err == gl.GL_FALSE then
        print(gl.glGetProgramInfoLog(self.program_id))
    end
end

function Shader:release()
    if gl.glIsProgram(self.program_id) == gl.GL_TRUE then
        if gl.glIsShader(self.vertex_id) == gl.GL_TRUE then
            gl.glDetachShader(self.program_id, self.vertex_id)
            gl.glDeleteShader(self.vertex_id)
        end

        if gl.glIsShader(self.fragment_id) == gl.GL_TRUE then
            gl.glDetachShader(self.program_id, self.fragment_id)
            gl.glDeleteShader(self.fragment_id)
        end

        gl.glDeleteProgram(self.program_id)
    end
end

function Shader:build(shaderType, shaderName, shaderExtension)
    local shader_id = gl.glCreateShader(shaderType)
    local source = io.open('graphics/shaders/'..shaderName..'.'..shaderExtension):read('*a')

    gl.glShaderSource(shader_id, source)
    gl.glCompileShader(shader_id)

    gl.glAttachShader(self.program_id, shader_id)

    local err = gl.glGetShaderiv(shader_id, gl.GL_COMPILE_STATUS)
    if err == gl.GL_FALSE then
        print(gl.glGetShaderInfoLog(shader_id))
        return nil
    end

    return shader_id
end

function Shader:use()
    gl.glUseProgram(self.program_id)
end

function Shader:unuse()
    gl.glUseProgram(0)
end

function initShaders()
    defaultShader = Shader('default')
end

function releaseShaders()
    defaultShader:release()
end
