class 'Shader'

function Shader:init(name)
    self.name = name

    self.program_id = gl.glCreateProgram()

    self.ids = {
        vertex = self:build(gl.GL_VERTEX_SHADER, name, 'vertex'),
--        geometry = self:build(gl.GL_GEOMETRY_SHADER, name, 'geometry'),
        fragment = self:build(gl.GL_FRAGMENT_SHADER, name, 'fragment'),
    }

    if gl.majorVersion >= 3 then
        self.ids.geometry = self:build(gl.GL_GEOMETRY_SHADER, name, 'geometry')
    end

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        print(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()
    self:initUniforms()
end

function Shader:build(shaderType, shaderName, shaderExtension)
    local shader_id = gl.glCreateShader(shaderType)

    local path = 'graphics/shaders/'..shaderName..'.'..shaderExtension
    local source = io.read(path)

    if source then
        local include = ''
        include = 
        '#version '..gl:getGlslVersion()..NL..
        '#define VERSION '..gl:getGlslVersion()..NL

        include = include..[[
            #if VERSION >= 300
                #define gl_FragColor fragColor
                out vec4 fragColor;
                
                #define attribute in
                
                #define texture2D texture
            #else
                #define in  varying
                #define out varying
            #endif

            vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
            vec4 blakc = vec4(0.0, 0.0, 0.0, 1.0);

            vec4 red   = vec4(1.0, 0.0, 0.0, 1.0);
            vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
            vec4 blue  = vec4(0.0, 0.0, 1.0, 1.0);

            vec4 transparent = vec4(0.0, 0.0, 0.0, 0.0);
            
            #line 0
        ]]

        local includeLen = 9

        source = include..source        

        gl.glShaderSource(shader_id, source)
        gl.glCompileShader(shader_id)

        local status = gl.glGetShaderiv(shader_id, gl.GL_COMPILE_STATUS)
        if status == gl.GL_FALSE then
            local errors = gl.glGetShaderInfoLog(shader_id)            
            errors = errors:gsub(':(%d*):',
                function (line)
                    line = tonumber(line) - includeLen                    
                    return lfs.currentdir()..'/'..path..' :'..(line)..':'
                end)

            print(errors)
            return nil
        end

        gl.glAttachShader(self.program_id, shader_id)

        return shader_id
    end

    return -1
end

function Shader:release()
    if gl.glIsProgram(self.program_id) == gl.GL_TRUE then
        for _,id in pairs(self.ids) do
            if gl.glIsShader(id) == gl.GL_TRUE then
                gl.glDetachShader(self.program_id, id)
                gl.glDeleteShader(id)
            end
        end
        gl.glDeleteProgram(self.program_id)
    end
end

function Shader:use()
    gl.glUseProgram(self.program_id)
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

function Shader:unuse()
    gl.glUseProgram(0)
end

class 'ShaderManager' : extends(Component)

function ShaderManager:setup()
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
        box      = Shader('sprite'),
--        lines2d  = Shader('lines2d'),
    }
end

function ShaderManager:release()
    for shaderName,shader in pairs(shaders) do
        shader:release()
    end
end
