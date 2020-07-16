class 'Shader'

function Shader:init(name)
    self.name = name
    
    self:create()
end

function Shader:tostring()
    return self .name
end

function Shader:create()
    self.program_id = gl.glCreateProgram()

    self.ids = {
        vertex = self:build(gl.GL_VERTEX_SHADER, self.name, 'vertex'),
--        geometry = self:build(gl.GL_GEOMETRY_SHADER, self.name, 'geometry'),
        fragment = self:build(gl.GL_FRAGMENT_SHADER, self.name, 'fragment'),
    }

    if config.glMajorVersion >= 4 then
        self.ids.geometry = self:build(gl.GL_GEOMETRY_SHADER, self.name, 'geometry')
    end

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        print(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()

    self:initUniforms()
end

function Shader:update()
    self:release()
    self:create()
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
            vec4 black = vec4(0.0, 0.0, 0.0, 1.0);

            vec4 red   = vec4(1.0, 0.0, 0.0, 1.0);
            vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
            vec4 blue  = vec4(0.0, 0.0, 1.0, 1.0);

            vec4 transparent = vec4(0.0, 0.0, 0.0, 0.0);
            
            #line 1
        ]]

        source = include..source        

        gl.glShaderSource(shader_id, source)
        gl.glCompileShader(shader_id)

        local status = gl.glGetShaderiv(shader_id, gl.GL_COMPILE_STATUS)
        if status == gl.GL_FALSE then
            local errors = gl.glGetShaderInfoLog(shader_id)            
            errors = errors:gsub(':(%d*):',
                function (line)
                    line = tonumber(line)                    
                    return lfs.currentdir()..'/'..path..' :'..(line)..':'
                end)

            error(errors)
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

function Shader:unuse()
    gl.glUseProgram(0)
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

-- TODO
function Shader:pushTableToShader(table, name, option)
    local t = {}
    t[option] = #table

    self:pushToShader(t)
    for i,item in ipairs(table) do
        self:pushToShader(item, name, i-1)
    end
end

function Shader:pushToShader(object, array, i)
    for k,v in pairs(object) do
        if array then
            if i then
                k = array.."["..i.."]".."."..k
            else
                k = array.."."..k
            end
        end
        self:send(k, v)
    end
end

function Shader:send(k, v)
    local uid = self.uniformLocations[k]
    if uid == nil then
        self.uniformLocations[k] = gl.glGetUniformLocation(self.ids.program, k)
        uid = self.uniformLocations[k]
    end

    if uid ~= -1 then
        local utype = self.uniformTypes[k]
        if utype == nil then
            self.uniformTypes[k] = typeof(v)
            utype = self.uniformTypes[k]
        end

        if utype == 'number' then
            if self.uniformGlslTypes[k] == gl.GL_INT then
                gl.glUniform1i(uid, v)
            elseif self.uniformGlslTypes[k] == gl.GL_SAMPLER_2D then
                gl.glUniform1i(uid, v)
            else
                gl.glUniform1fv(uid, 1, v)
            end

        elseif utype == 'vec2' then
            gl.glUniform2fv(uid, 1, v.x, v.y)

        elseif utype == 'vec3' then
            gl.glUniform3fv(uid, 1, v.x, v.y, v.z)

        elseif utype == 'vec4' then
            gl.glUniform4fv(uid, 1, v.x, v.y, v.z, v.w)

        elseif utype == 'color' then
            gl.glUniform4fv(uid, 1, v.r, v.g, v.b, v.a)

        elseif utype == 'matrix' or utype == 'cdata' then
            if matrix == glm_matrix then
                assert()
                gl.glUniformMatrix4fv(uid, 1, gl.GL_FALSE, v)
            else
                gl.glUniformMatrix4fv(uid, 1, gl.GL_TRUE, v)
            end

        elseif utype == 'boolean' then
            if v == true then
                gl.glUniform1i(uid, 1)
            else
                gl.glUniform1i(uid, 0)
            end

        else
            assert(false, "shader : unmanaged type "..utype.." for "..k)
        end
    else
        warning(false, self.name.." : unknown uniform '"..k.."'")
    end
end

function Shader:initUniforms()
    self.uniformsLocations = {}

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

        self.uniformsLocations[ffi.string(uniformName)] = {
            uniformLocation = gl.glGetUniformLocation(self.program_id, uniformName)
        }
    end
end
