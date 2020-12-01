local code, defs = Library.precompile(io.read('./libc/opengl/opengl.c'))
ffi.cdef(code)

class 'OpenGL' : extends(Component)

function OpenGL:loadProcAdresses()
    self.defs = {
        -- error
        'glGetError',

        -- property
        'glGetString',
        'glGetIntegerv',
        'glEnable',
        'glDisable',
        'glHint',

        -- viewport
        'glViewport',

        -- clear
        'glClearColor',
        'glClearDepth',
        'glClearDepthf',
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
        'glVertexAttribDivisor',
        'glEnableVertexAttribArray',
        'glDisableVertexAttribArray',
        'glGetAttribLocation',
        'glGetActiveAttrib',

        -- uniform
        'glGetUniformLocation',
        'glGetActiveUniform',
        'glGetActiveUniformName',

        -- draw
        'glLineWidth',
        'glPointSize',
        'glPolygonMode',
        'glDrawArrays',
        'glDrawArraysInstanced',
        'glDrawElements',
        'glDrawElementsInstanced',
        'glScissor',

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
        'glTexSubImage2D',
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
        'glFramebufferTexture1D',
        'glFramebufferTexture2D',
        'glFramebufferTexture3D',
        'glFramebufferTexture',
        'glDrawBuffer',
        'glDrawBuffers',
        'glCheckFramebufferStatus',
    }

    for i,v in ipairs(self.defs) do
        local procAddr = sdl.SDL_GL_GetProcAddress(v)
        local f = ffi.cast('PFN_'..v, procAddr)

        self.defs[v] = f
        self[v] = function (...)
            local res = f(...)
            local err = self.defs.glGetError()
            if err ~= self.GL_NO_ERROR then
                for k,v in pairs(self) do
                    if v == err then
                        errCode = k
                        break
                    end
                end
                local errDescription = string.format('OpenGL Error %s : 0x%x %s', v, err, errCode)
                assert(false, errDescription)
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

    print('Supported '..ffi.string(gl.glGetString(gl.GL_SHADING_LANGUAGE_VERSION)))

    self.intptr = ffi.new('GLint[1]')
    self.idptr  = ffi.new('GLuint[1]')
    self.floatptr = ffi.new('GLfloat[4]')

    if not opengles then
        -- Smooth
        self.glEnable(gl.GL_LINE_SMOOTH)
        self.glEnable(gl.GL_POLYGON_SMOOTH)

        -- Hint
        self.glHint(gl.GL_LINE_SMOOTH_HINT, gl.GL_NICEST)
        self.glHint(gl.GL_POLYGON_SMOOTH_HINT, gl.GL_NICEST)

        -- Multi Sampling
        self.glEnable(gl.GL_MULTISAMPLE)
    end

    -- Disable states
    self.glDisable(gl.GL_DITHER)
    self.glDisable(gl.GL_STENCIL_TEST)

    function self.glGetInteger(id)
        gl.glGetIntegerv(id, self.intptr)
        return self.intptr[0]
    end

    function self.glShaderSource(id, code)
        local s = ffi.new('const GLchar*[1]', {code})
        local l = ffi.new('GLint[1]', #code)

        self.defs.glShaderSource(id, 1, s, l)
    end

    function self.glGetShaderiv(id, flag)
        self.defs.glGetShaderiv(id, flag, self.intptr)
        return self.intptr[0]
    end

    function self.glGetShaderInfoLog(id)
        local len = self.glGetShaderiv(id, self.GL_INFO_LOG_LENGTH)
        len = len > 0 and len or 128

        local info = ffi.new('GLchar[?]', len or 1)
        self.defs.glGetShaderInfoLog(id, len, nil, info)

        return ffi.string(info, len - 1):gsub('ERROR: 0', '')
    end

    function self.glGetProgramiv(id, flag)
        self.defs.glGetProgramiv(id, flag, self.intptr)
        return self.intptr[0]
    end

    function self.glGetProgramInfoLog(id)
        local len = self.glGetProgramiv(id, self.GL_INFO_LOG_LENGTH)
        len = len > 0 and len or 128

        local info = ffi.new('GLchar[?]', len or 1)
        self.defs.glGetProgramInfoLog(id, len, nil, info)

        return ffi.string(info, len - 1)
    end

    function self.glGenBuffer()
        self.defs.glGenBuffers(1, self.idptr)
        return self.idptr[0]
    end

    function self.glDeleteBuffer(buffer)
        self.idptr[0] = buffer
        self.defs.glDeleteBuffers(1, self.idptr)
    end

    function self.glGenVertexArray()
        self.defs.glGenVertexArrays(1, self.idptr)
        return self.idptr[0]
    end

    function self.glDeleteVertexArray(buffer)
        self.idptr[0] = buffer
        self.defs.glDeleteVertexArrays(1, self.idptr)
    end

    function self.glGenTexture()
        self.glGenTextures(1, self.idptr)
        return self.idptr[0]
    end

    function self.glDeleteTexture(id)
        self.idptr[0] = id
        self.glDeleteTextures(1, self.idptr)
    end

    function self.glGenFramebuffer()
        self.glGenFramebuffers(1, self.idptr)
        return self.idptr[0]
    end

    function gl.glDeleteFramebuffer(id)
        self.idptr[0] = id
        gl.glDeleteFramebuffers(1, self.idptr)
    end

    function self.glGenRenderbuffer()
        self.glGenRenderbuffers(1, self.idptr)
        return self.idptr[0]
    end

    function gl.glDeleteRenderbuffer(id)
        self.idptr[0] = id
        gl.glDeleteRenderbuffers(1, self.idptr)
    end

    function gl.glDrawBuffer(id)
        self.idptr[0] = id
        gl.glDrawBuffers(1, self.idptr)
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
    if opengles then
        return 300
    end
    
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
