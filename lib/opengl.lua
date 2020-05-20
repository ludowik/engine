require 'ffi'

local code, defs = precompile(io.read('./lib/opengl.c'))
ffi.cdef(code)

local lib_path
if os.name == 'osx' then 
    lib_path = 'OpenGL.framework/OpenGL'
else
    lib_path = 'System32/OpenGL32'
end

class 'OpenGL' : extends(Component)

function OpenGL:setup()
    self.defs = {
        -- property
        'glEnable',
        'glDisable',

        'glDepthFunc',
        'glBlendEquation',
        'glBlendFunc',
        'glBlendFuncSeparate',

        -- error
        'glGetError',

        -- clear
        'glClearColor',
        'glClearDepth',
        'glClear',

        -- shader
        'glIsProgram',
        'glCreateProgram',
        'glDeleteProgram',
        'glIsShader',
        'glCreateShader',
        'glDeleteShader',
        'glShaderSource',
        'glCompileShader',
        'glAttachShader',
        'glDetachShader',
        'glGetShaderiv',
        'glGetShaderInfoLog',
        'glLinkProgram',
        'glGetProgramiv',
        'glGetProgramInfoLog',
        'glUseProgram',

        -- buffer
        'glGenBuffers',
        'glBindBuffer',
        'glDeleteBuffers',
        'glBufferData',
        'glVertexAttribPointer',
        'glEnableVertexAttribArray',
        'glDisableVertexAttribArray',
        'glDrawArrays',
        'glGetAttribLocation',
        'glGetActiveAttrib',
        'glGetUniformLocation',
        'glGetActiveUniform',
        'glGetActiveUniformName',

        -- uniform
        'glUniform1f',
        'glUniform2f',
        'glUniform3f',
        'glUniform4f',
        'glUniform1i',
        'glUniform2i',
        'glUniform3i',
        'glUniform4i',
        'glUniform1fv',
        'glUniform2fv',
        'glUniform3fv',
        'glUniform4fv',
        'glUniform1iv',
        'glUniform2iv',
        'glUniform3iv',
        'glUniform4iv',
        'glUniformMatrix2fv',
        'glUniformMatrix3fv',
        'glUniformMatrix4fv',

        -- texture
        'glGenTextures',
        'glDeleteTextures',
        'glBindTexture',
        'glActiveTexture',
        'glTexImage2D',
        'glPixelStorei',
        'glTexParameteri',
    }

    for i,v in ipairs(self.defs) do
        local f = ffi.cast('PFN_'..v, sdl.SDL_GL_GetProcAddress(v))
        self.defs[v] = f
        self[v] = function (...)
            local res = f(...)
            local err = self.defs.glGetError()
            if err ~= self.GL_NO_ERROR then
                local error_name = string.format('OpenGL Error {%s} : 0x{%x}', v, err)
                print(error_name)
                assert()
            end
            return res
        end
    end

    for k,v in pairs(defs) do
        self[k] = v
    end

    intptr = ffi.new('GLint[1]')
    idptr  = ffi.new('GLuint[1]')

    function self.glShaderSource(id, code)
        local s = ffi.new('const GLchar*[1]', {code})
        local l = ffi.new('GLint[1]', #code)

        self.defs.glShaderSource(id, 1, s, l)
    end

    function self.glGetShaderiv(id, flag)
        self.defs.glGetShaderiv(id, flag, intptr)
        return intptr[0]
    end

    function self.glGetShaderInfoLog(id)
        local len = self.glGetShaderiv(id, self.GL_INFO_LOG_LENGTH)
        if len == 0 then
            return 'len == 0'
        else
--            local log = gl.char(len)
            local log = ffi.new('GLchar[?]', len or 1)
            self.defs.glGetShaderInfoLog(id, len, nil, log)
            return ffi.string(log, len - 1):gsub('ERROR: 0', '')
        end
    end

    function self.glGetProgramiv(id, flag)
        self.defs.glGetProgramiv(id, flag, intptr)
        return intptr[0]
    end

    function self.glGetProgramInfoLog(id)
        local len = self.glGetProgramiv(id, self.GL_INFO_LOG_LENGTH)
        if len == 0 then
            return 'len == 0'
        else
--            local log = gl.char(len)
            local log = ffi.new('GLchar[?]', len or 1)
            self.defs.glGetProgramInfoLog(id, len, nil, log)
            return ffi.string(log, len - 1)
        end
    end

    function self.glGenBuffer()
        self.defs.glGenBuffers(1, idptr)
        return idptr[0]
    end

    function self.glDeleteBuffer(buffer)
        idptr[0] = buffer
        self.defs.glDeleteBuffers(1, idptr)
    end

    function self.glGenTexture()
        self.glGenTextures(1, idptr)
        return idptr[0]
    end

    function self.glDeleteTexture(id)
        idptr[0] = id
        self.glDeleteTextures(1, idptr)
    end

    background(black)
    sdl.SDL_GL_SwapWindow(sdl.window)
    background(black)

end

function OpenGL:release()
end

gl = OpenGL()
