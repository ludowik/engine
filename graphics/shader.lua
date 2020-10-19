class 'Shader'

function Shader:init(name, path)
    self.name = name
    self.path = path or 'graphics/shaders'

    self.modifications = {}

    self:create()
end

function Shader:__tostring()
    return self.name
end

function Shader:create()
    self.program_id = gl.glCreateProgram()

    self.ids = {
        vertex = self:build(gl.GL_VERTEX_SHADER, self.name, 'vertex'),
        fragment = self:build(gl.GL_FRAGMENT_SHADER, self.name, 'fragment'),
    }

    if config.glMajorVersion >= 4 then
        -- TODEL ?
--        self.ids.geometry = self:build(gl.GL_GEOMETRY_SHADER, self.name, 'geometry')
    end

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        error(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()

    self:initUniforms()
end

function Shader:update()
    if (not self:check(gl.GL_VERTEX_SHADER, self.name, 'vertex') or 
        not self:check(gl.GL_FRAGMENT_SHADER, self.name, 'fragment'))
    then
        self:unuse()
        self:release()
        self:create()
    end
end

function Shader:check(shaderType, shaderName, shaderExtension)
    local path = self.path..'/'..shaderName..(shaderExtension and ('.'..shaderExtension) or '')
    if fs.getInfo(path).modification > self.modifications[shaderType] then
        return false
    end
    return true
end

function Shader:build(shaderType, shaderName, shaderExtension)
    local path = self.path..'/'..shaderName..(shaderExtension and ('.'..shaderExtension) or '')
    if isFile(path) then
        local source = io.read(path)
        if source then
            return self:compile(shaderType, source, path)
        end
    end
    return -1
end

function Shader:compile(shaderType, source, path)
    local include = ''

    if opengles then
        include = include..(
            '#define VERSION '..gl:getGlslVersion()..NL..
            'precision highp float;'..NL            
        )
    else
        include = include..(
            '#version '..gl:getGlslVersion()..NL..
            '#define VERSION '..gl:getGlslVersion()..NL..            
            'precision highp float;'..NL
        )
    end

    local noise3D = io.read('graphics/shaders/noise3D.glsl')
    assert(noise3D)
    include = include..(
        noise3D..NL
    )

    local includeGlsl = io.read('graphics/shaders/include.glsl')
    assert(includeGlsl)
    include = include..(
        includeGlsl..NL
    )

    include = include..[[
        #if VERSION >= 300
        #define attribute in

        #define texture2D texture

        #define gl_FragColor fragColor
        out vec4 fragColor;
        #else
        #define in  varying
        #define out varying

        #define texture texture2D

        #define fragColor gl_FragColor
        #endif

        vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
        vec4 black = vec4(0.0, 0.0, 0.0, 1.0);

        vec4 red   = vec4(1.0, 0.0, 0.0, 1.0);
        vec4 green = vec4(0.0, 1.0, 0.0, 1.0);
        vec4 blue  = vec4(0.0, 0.0, 1.0, 1.0);

        vec4 transparent = vec4(0.0, 0.0, 0.0, 0.0);
        
        vec4 brown = vec4(165./255., 42./255., 42./255., 1.0);

        #line 1
    ]]

    source = include..source

    local shader_id = gl.glCreateShader(shaderType)
    assert(shader_id > 0)

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

    self.modifications[shaderType] = fs.getInfo(path).modification

    gl.glAttachShader(self.program_id, shader_id)

    return shader_id
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
    log('send '..k..' = '..tostring(v))

    local uid = self.uniformsLocations[k]
    if uid == nil then
        self.uniformsLocations[k] = gl.glGetUniformLocation(self.program_id, k)
        uid = self.uniformsLocations[k]
    end

    if uid ~= -1 then
        uid = uid.uniformLocation

        local utype = self.uniformsTypes[k]
        if utype == nil then
            self.uniformsTypes[k] = typeof(v)
            utype = self.uniformsTypes[k]
        end

        if utype == 'number' then
            if self.uniformsGlslTypes[k] == gl.GL_INT then
                gl.glUniform1i(uid, v)
            elseif self.uniformsGlslTypes[k] == gl.GL_SAMPLER_2D then
                gl.glUniform1i(uid, v)
            else
                gl.glUniform1f(uid, v)
            end

        elseif utype == 'vec2' then
            gl.glUniform2fv(uid, 1, v:tobytes())

        elseif utype == 'vec3' then
            gl.glUniform3fv(uid, 1, v:tobytes())

        elseif utype == 'vec4' then
            gl.glUniform4fv(uid, 1, v:tobytes())

        elseif utype == 'color' then
            gl.glUniform4fv(uid, 1, v:tobytes())

        elseif utype == 'matrix' or utype == 'cdata' then
            gl.glUniformMatrix4fv(uid, 1, gl.GL_TRUE, v:tobytes())

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
        log(self.name.." : unknown uniform '"..k.."'")
    end
end

function Shader:initUniforms()
    self.uniformsLocations = {}
    self.uniformsGlslTypes = {}
    self.uniformsTypes = {}

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
        self.uniformsGlslTypes[ffi.string(uniformName)] = type_ptr[0]
    end
end
