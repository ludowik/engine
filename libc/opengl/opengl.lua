local code, defs = Library.precompile(io.read('./libc/opengl/opengl.c'))
ffi.cdef(code)

class 'OpenGL' : extends(Component)

function OpenGL:loadProcAdresses()
    self.defs = {
        -- error
        'glGetError',

        -- property
        'glEnable',
        'glDisable',
        'glHint',

        -- viewport
        'glViewport',

        -- clear
        'glClearColor',
        'glClearDepth',
        'glClear',

        -- blend
        'glBlendEquation',
        'glBlendFunc',
        'glBlendFuncSeparate',

        -- culling
        'glCullFace',
        'glFrontFace',

        -- depth
        'glDepthFunc',

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

        -- vao
        'glIsVertexArray',
        'glGenVertexArrays',
        'glDeleteVertexArrays',
        'glBindVertexArray',

        -- buffer
        'glGenBuffers',
        'glBindBuffer',
        'glDeleteBuffers',
        'glBufferData',

        -- attribute
        'glVertexAttribPointer',
        'glEnableVertexAttribArray',
        'glDisableVertexAttribArray',
        'glGetAttribLocation',
        'glGetActiveAttrib',

        -- uniform
        'glGetUniformLocation',
        'glGetActiveUniform',
        'glGetActiveUniformName',

        -- draw
        'glPolygonMode',
        'glDrawArrays',

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
        'glIsTexture',
        'glGenTextures',
        'glDeleteTextures',
        'glBindTexture',
        'glActiveTexture',
        'glTexImage2D',
        'glPixelStorei',
        'glTexParameteri',
        'glGetTexImage',

        -- frame & render buffers
        'glGenFramebuffers',
        'glDeleteFramebuffers',
        'glBindFramebuffer',
        'glGenRenderbuffers',
        'glDeleteRenderbuffers',
        'glBindRenderbuffer',
        'glRenderbufferStorage',
        'glFramebufferRenderbuffer',
        'glFramebufferTexture',
        'glDrawBuffer',
        'glCheckFramebufferStatus',
    }

    for i,v in ipairs(self.defs) do
        local f = ffi.cast('PFN_'..v, sdl.SDL_GL_GetProcAddress(v))
        self.defs[v] = f
        self[v] = function (...)
            local res = f(...)
            local err = self.defs.glGetError()
            if err ~= self.GL_NO_ERROR then
                for k,v in pairs(self) do
                    if v == err then
                        errAsString = k
                        break
                    end
                end
                local error_name = string.format('OpenGL Error %s : 0x%x %s', v, err, errAsString)
                assert(false, error_name)
            end
            return res
        end
    end

    for k,v in pairs(defs) do
        self[k] = v
    end
end

function OpenGL:initialize()
    self:loadProcAdresses()

    intptr = ffi.new('GLint[1]')
    idptr  = ffi.new('GLuint[1]')

    -- Smooth
    self.glEnable(gl.GL_LINE_SMOOTH)
    self.glEnable(gl.GL_POLYGON_SMOOTH)

    -- Hint
    self.glHint(gl.GL_LINE_SMOOTH_HINT, gl.GL_NICEST)
    self.glHint(gl.GL_POLYGON_SMOOTH_HINT, gl.GL_NICEST)

    -- Multi Sampling
    self.glEnable(gl.GL_MULTISAMPLE)

    -- Disable states
    self.glDisable(gl.GL_DITHER)
    self.glDisable(gl.GL_STENCIL_TEST)

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
        len = len > 0 and len or 128

        local log = ffi.new('GLchar[?]', len or 1)
        self.defs.glGetShaderInfoLog(id, len, nil, log)

        return ffi.string(log, len - 1):gsub('ERROR: 0', '')
    end

    function self.glGetProgramiv(id, flag)
        self.defs.glGetProgramiv(id, flag, intptr)
        return intptr[0]
    end

    function self.glGetProgramInfoLog(id)
        local len = self.glGetProgramiv(id, self.GL_INFO_LOG_LENGTH)
        len = len > 0 and len or 128

        local log = ffi.new('GLchar[?]', len or 1)
        self.defs.glGetProgramInfoLog(id, len, nil, log)

        return ffi.string(log, len - 1)
    end

    function self.glGenBuffer()
        self.defs.glGenBuffers(1, idptr)
        return idptr[0]
    end

    function self.glDeleteBuffer(buffer)
        idptr[0] = buffer
        self.defs.glDeleteBuffers(1, idptr)
    end

    function self.glGenVertexArray()
        self.defs.glGenVertexArrays(1, idptr)
        return idptr[0]
    end

    function self.glDeleteVertexArray(buffer)
        idptr[0] = buffer
        self.defs.glDeleteVertexArrays(1, idptr)
    end

    function self.glGenTexture()
        self.glGenTextures(1, idptr)
        return idptr[0]
    end

    function self.glDeleteTexture(id)
        idptr[0] = id
        self.glDeleteTextures(1, idptr)
    end

    function self.glGenFramebuffer()
        self.glGenFramebuffers(1, idptr)
        return idptr[0]
    end

    function gl.glDeleteFramebuffer(id)
        idptr[0] = id
        gl.glDeleteFramebuffers(1, idptr)
    end

    function self.glGenRenderbuffer()
        self.glGenRenderbuffers(1, idptr)
        return idptr[0]
    end

    function gl.glDeleteRenderbuffer(id)
        idptr[0] = id
        gl.glDeleteRenderbuffers(1, idptr)
    end

    function gl.glGetString(name)
        local str = gl.defs.glGetString(name)
        if str ~= NULL then
            return ffi.string(str)
        end
        return nil
    end

    background(black)
    sdl.SDL_GL_SwapWindow(sdl.window)
    background(black)

end

function OpenGL:release()
end

function OpenGL:getOpenGLVersion()
    return config.glMajorVersion * 100 + config.glMinorVersion * 10
end

function OpenGL:getGlslVersion()
    local glVersion = self:getOpenGLVersion()
    if glVersion == 200 then
        return 110
    elseif glVersion == 210 then
        return 120
    elseif glVersion == 300 then
        return 130
    elseif glVersion == 310 then
        return 140
    elseif glVersion == 320 then
        return 150
    end
    return glVersion
end
