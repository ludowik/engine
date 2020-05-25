class 'Shader'

function Shader:init(name)
    self.name = name

    self.program_id = gl.glCreateProgram()

    self.vertex_id = self:build(gl.GL_VERTEX_SHADER, name, 'vertex')
    self.geometry_id = self:build(gl.GL_GEOMETRY_SHADER, name, 'geometry')
    self.fragment_id = self:build(gl.GL_FRAGMENT_SHADER, name, 'fragment')

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        print(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()
    self:initUniforms()
end

function Shader:initAttributes()
    self.attributes = {}

    local attributeNameLen = 64
    local attributeName = ffi.new('char[?]', attributeNameLen)

    local length_ptr = ffi.new('GLsizei[1]')
    local size_ptr = ffi.new('GLint[1]')
    local type_ptr = ffi.new('GLenum[1]')

    local activeAttributes = gl.glGetProgramiv(self.program_id, gl.GL_ACTIVE_ATTRIBUTES)
    for i=1,activeAttributes do
        gl.glGetActiveAttrib(self.program_id,
            i-1,
            attributeNameLen,
            length_ptr,
            size_ptr,
            type_ptr,
            attributeName)

        self.attributes[ffi.string(attributeName)] = {
            attribLocation = gl.glGetAttribLocation(self.program_id, attributeName),
            id = gl.glGenBuffer()
        }
    end
end

function Shader:initUniforms()
    self.uniforms = {}

    local uniformName = ffi.new('char[64]')

    local length_ptr = ffi.new('GLsizei[1]')
    local size_ptr = ffi.new('GLint[1]')
    local type_ptr = ffi.new('GLenum[1]')

    local activeUniforms = gl.glGetProgramiv(self.program_id, gl.GL_ACTIVE_UNIFORMS)
    for i=1,activeUniforms do
        gl.glGetActiveUniform(self.program_id,
            i-1,
            64,
            length_ptr,
            size_ptr,
            type_ptr,
            uniformName)

        self.uniforms[ffi.string(uniformName)] = {
            uniformLocation = gl.glGetUniformLocation(self.program_id, uniformName)
        }
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
    local source = io.read('graphics/shaders/'..shaderName..'.'..shaderExtension)

    if source then
        gl.glShaderSource(shader_id, source)
        gl.glCompileShader(shader_id)

        local status = gl.glGetShaderiv(shader_id, gl.GL_COMPILE_STATUS)
        if status == gl.GL_FALSE then
            print(gl.glGetShaderInfoLog(shader_id))
            return nil
        end

        gl.glAttachShader(self.program_id, shader_id)
        
        return shader_id
    end
    
    return -1
end

function Shader:use()
    gl.glUseProgram(self.program_id)
end

function Shader:unuse()
    gl.glUseProgram(0)
end

class 'ShaderManager' : extends(Component)

function ShaderManager:setup()
    shaders = {
        default  = Shader('default'),
        point    = Shader('point'),
        line     = Shader('point'),
        polyline = Shader('point'),
        polygon  = Shader('point'),
        ellipse  = Shader('default'),
        rect     = Shader('default'),
        sprite   = Shader('sprite'),
        text     = Shader('text'),
        box      = Shader('sprite'),
        lines2d  = Shader('lines2d'),
    }
end

function ShaderManager:release()
    for shaderName,shader in pairs(shaders) do
        shader:release()
    end
end
