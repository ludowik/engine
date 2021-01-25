local Shader = class 'Shader'

function Shader:init(name, path)
    self.name = name
    self.path = path or 'graphics/shaders'

    self.modifications = {}

    self.attributes = {}

    self.uniformsLocations = {}
    self.uniformsGlslTypes = {}
    self.uniformsTypes = {}

    self:create()
end

function Shader:__tostring()
    return self.name
end

function Shader:create()
    self.program_id = gl.glCreateProgram()

    self.ids = {
        vertex = self:build(gl.GL_VERTEX_SHADER, self.nameVertex or self.name, 'vertex'),
        fragment = self:build(gl.GL_FRAGMENT_SHADER, self.nameFragment or self.name, 'fragment'),
    }

    gl.glLinkProgram(self.program_id)

    local status = gl.glGetProgramiv(self.program_id, gl.GL_LINK_STATUS)
    if status == gl.GL_FALSE then
        error(gl.glGetProgramInfoLog(self.program_id))
    end

    self:initAttributes()

    self:initUniforms()
end

function Shader:update()
    if (not self:check(gl.GL_VERTEX_SHADER, self.nameVertex or self.name, 'vertex') or 
        not self:check(gl.GL_FRAGMENT_SHADER, self.nameFragment or self.name, 'fragment'))
    then
        self:unuse()
        self:release()
        self:create()
        
        print('reload shader '..self.name)
    end
end

function Shader:check(shaderType, shaderName, shaderExtension)
    local path = self.path..'/'..shaderName
    if not isFile(path) then
        path = self.path..'/'..shaderName..(shaderExtension and ('.'..shaderExtension) or '')
    end
    if isFile(path) then
        local info = getInfo(path)
        if info and info.modification > self.modifications[shaderType] then
            return false
        end
        return true
    end
end

function Shader:build(shaderType, shaderName, shaderExtension)
    local path = self.path..'/'..shaderName
    if not isFile(path) then
        path = self.path..'/'..shaderName..(shaderExtension and ('.'..shaderExtension) or '')
    end
    if isFile(path) then
        local source = io.read(path)
        if source then
            source = self:complete(shaderType, source)
            return self:compile(shaderType, source, path)
        end
    end
    return -1
end

function Shader:complete(shaderType, source)
    return source
end

function Shader:compile(shaderType, source, path)
    local include

    if opengles then
        include = (
            '#version 300 es'..NL..
            '#define VERSION '..gl:getGlslVersion()..NL)
    else
        include = (
            '#version '..gl:getGlslVersion()..NL..
            '#define VERSION '..gl:getGlslVersion()..NL)
    end

    include = include..[[
    #include "_include.glsl"

    //        #include "_math.glsl"

    #include "_noise2D.glsl"
    #include "_noise3D.glsl"
    ]]

    local includes = {}

    include = include:gsub('\n[%s]*#include[%s]+"([a-zA-Z0-9%._]+)"',
        function (file, a, b, c)
            local path = 'graphics/shaders'
            includes[#includes+1] = path..'/'..file
            return NL..'#line 0 '..#includes..NL..io.read(includes[#includes])
        end)

    includes[#includes+1] = path

    source = include..NL..'#line 0 '..#includes..NL..source

    local shader_id = gl.glCreateShader(shaderType)
    assert(shader_id > 0)

    gl.glShaderSource(shader_id, source)
    gl.glCompileShader(shader_id)

    local status = gl.glGetShaderiv(shader_id, gl.GL_COMPILE_STATUS)
    if status == gl.GL_FALSE then        
        local errors = gl.glGetShaderInfoLog(shader_id)
        errors = errors:gsub('ERROR: (%d+):(%d+):',
            function (ifile, iline)
                ifile = tonumber(ifile)
                iline = tonumber(iline)
                return lfs.currentdir()..'/'..includes[ifile]..' :'..(iline+1)..':'
            end)

        print(errors)
        error()
    end

    if path then
        self.modifications[shaderType] = getInfo(path).modification
    else
        self.modifications[shaderType] = 0
    end

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

    self.attributes['indice'] = {
        attribLocation = -1,
        id = gl.glGenBuffer()
    }
end

function Shader:initUniforms()
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

function Shader:needByShader(uniforms)
    for k,v in pairs(self.uniformsLocations) do
        if uniforms[k] then
            self:send(k, uniforms[k])
        else
            --log(self.name.." : miss uniform '"..k.."'")
        end
    end
end

function Shader:pushByRender(uniforms)
    for k,v in pairs(uniforms) do
        if self.uniformsLocations[k] then
            self:send(k, v)
        else
            --log(self.name.." : unknown uniform '"..k.."'")
        end
    end
end

function Shader:sendUniforms(uniforms)
    self:needByShader(uniforms)

    --    Performance.compare('need by shader or push by renderer',
    --        function () self:needByShader(uniforms) end,
    --        function () self:pushByRender(uniforms) end)
end

function Shader:send(k, v)
    local location = self.uniformsLocations[k]

    if location then
        local uid = location.uniformLocation

        --        log(string.format('send uniform {k} with value {v}', {k=k, v=v}))

        local utype = self.uniformsTypes[k]
        if utype == nil then
            self.uniformsTypes[k] = typeof(v)
            utype = self.uniformsTypes[k]
        end

        if utype == 'matrix' then
            gl.glUniformMatrix4fv(uid, 1, gl.GL_TRUE, v:tobytes())

        elseif utype == 'vec3' then
            gl.glUniform3fv(uid, 1, v:tobytes())

        elseif utype == 'color' then
            gl.glUniform4fv(uid, 1, v:tobytes())

        elseif utype == 'vec2' then
            gl.glUniform2fv(uid, 1, v:tobytes())

        elseif utype == 'vec4' then
            gl.glUniform4fv(uid, 1, v:tobytes())

        elseif utype == 'number' then
            if self.uniformsGlslTypes[k] == gl.GL_INT then
                gl.glUniform1i(uid, v)

            elseif self.uniformsGlslTypes[k] == gl.GL_SAMPLER_2D then
                gl.glUniform1i(uid, v)

            else
                gl.glUniform1f(uid, v)
            end

        elseif utype == 'boolean' then
            if v == true then
                gl.glUniform1i(uid, 1)
            else
                gl.glUniform1i(uid, 0)
            end

        else
            error("shader : unmanaged type "..utype.." for "..k)
        end

    else
        log(self.name.." : unknown uniform '"..k.."'")
    end
end

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
