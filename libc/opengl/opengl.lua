local code, defs = Library.precompile(io.read('./libc/opengl/opengl.c'))
ffi.cdef(code)

class 'OpenGL' : extends(Component)

function OpenGL:init()
    opengles = ios

    if opengles then
        config.glMajorVersion = 3
        config.glMinorVersion = 2
    else
        config.glMajorVersion = 4
        config.glMinorVersion = 1
    end
end

function OpenGL:load()
    if sdl.SDL_GL_LoadLibrary(ffi.NULL) == 1 then
        sdl.SDL_Log("SDL_GL_LoadLibrary: %s", sdl.SDL_GetError())
        error('SDL_GL_LoadLibrary')
    end

    if opengles then
        sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_ES)

    else
        if config.glMajorVersion == 4 then
            sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_CORE)

        else
            config.glMajorVersion = 3
            config.glMinorVersion = 1

            sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_PROFILE_MASK, sdl.SDL_GL_CONTEXT_PROFILE_COMPATIBILITY)
        end
    end

    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MAJOR_VERSION, config.glMajorVersion)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_CONTEXT_MINOR_VERSION, config.glMinorVersion)

    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DOUBLEBUFFER, 1)
    sdl.SDL_GL_SetAttribute(sdl.SDL_GL_DEPTH_SIZE, 24)

    self.flag = sdl.SDL_WINDOW_OPENGL
end

function OpenGL:unload()
    sdl.SDL_GL_UnloadLibrary()
end

function OpenGL:createContext(window)
    local context = sdl.SDL_GL_CreateContext(window)
    local res = sdl.SDL_GL_MakeCurrent(window, context)
    assert(res == 0)
    return context
end

function OpenGL:deleteContext(context)
    sdl.SDL_GL_DeleteContext(context)
end

function OpenGL:initialize()
    self:loadProcAdresses()

    print('GLSL '..ffi.string(self.glGetString(self.GL_SHADING_LANGUAGE_VERSION)))

    self.intptr = ffi.new('GLint[1]')
    self.idptr  = ffi.new('GLuint[1]')
    self.floatptr = ffi.new('GLfloat[4]')

    if not opengles then
        -- Smooth
        self.glEnable(self.GL_LINE_SMOOTH)
        self.glEnable(self.GL_POLYGON_SMOOTH)

        -- Hint
        self.glHint(self.GL_LINE_SMOOTH_HINT, self.GL_NICEST)
        self.glHint(self.GL_POLYGON_SMOOTH_HINT, self.GL_NICEST)

        -- Multi Sampling
        self.glEnable(self.GL_MULTISAMPLE)
    end

    -- Disable states
    self.glDisable(self.GL_DITHER)
    self.glDisable(self.GL_STENCIL_TEST)

    function self.glGetInteger(id)
        self.glGetIntegerv(id, self.intptr)
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

    function self.glDeleteFramebuffer(id)
        self.idptr[0] = id
        self.glDeleteFramebuffers(1, self.idptr)
    end

    function self.glGenRenderbuffer()
        self.glGenRenderbuffers(1, self.idptr)
        return self.idptr[0]
    end

    function self.glDeleteRenderbuffer(id)
        self.idptr[0] = id
        self.glDeleteRenderbuffers(1, self.idptr)
    end

    function self.glDrawBuffer(id)
        self.idptr[0] = id
        self.glDrawBuffers(1, self.idptr)
    end

    function self.glGetString(name)
        local str = self.defs.glGetString(name)
        if str ~= NULL then
            return ffi.string(str)
        end
        return nil
    end

    background(black)

    self:swap()
    background(black)
end

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

function OpenGL:vsync(interval)
    if interval then
        sdl.SDL_GL_SetSwapInterval(interval)
    end
    return sdl.SDL_GL_GetSwapInterval()
end

function OpenGL:swap()
    sdl.SDL_GL_SwapWindow(sdl.window)
end

function OpenGL:clear(clr)
    self.glClearColor(clr.r, clr.g, clr.b, clr.a)
    self.glClearDepthf(1)

    self.glClear(
        self.GL_COLOR_BUFFER_BIT +
        self.GL_DEPTH_BUFFER_BIT)
end

function OpenGL:blendMode(mode)
    if mode == NORMAL then
        self.glEnable(self.GL_BLEND)
        self.glBlendEquation(self.GL_FUNC_ADD)
        self.glBlendFuncSeparate(
            self.GL_SRC_ALPHA, self.GL_ONE_MINUS_SRC_ALPHA,
            self.GL_ONE, self.GL_ONE_MINUS_SRC_ALPHA)

    elseif mode == ADDITIVE then
        self.glEnable(self.GL_BLEND)
        self.glBlendEquation(self.GL_FUNC_ADD)
        self.glBlendFunc(self.GL_ONE, self.GL_ONE)

    elseif mode == MULTIPLY then
        self.glEnable(self.GL_BLEND)
        self.glBlendEquation(self.GL_FUNC_ADD)
        self.glBlendFuncSeparate(
            self.GL_DST_COLOR, self.GL_ZERO,
            self.GL_DST_ALPHA, self.GL_ZERO)

    else
        assert(false, mode)
    end
end

function OpenGL:cullingMode(culling)
    if culling then
        self.glEnable(self.GL_CULL_FACE)

        self.glFrontFace(self.GL_CCW)
        if cullingFace == 'front' then
            self.glCullFace(self.GL_FRONT)
        else
            self.glCullFace(self.GL_BACK)
        end
    else
        self.glDisable(self.GL_CULL_FACE)
    end
end

function OpenGL:depthMode(mode)
    if mode then
        self.glEnable(self.GL_DEPTH_TEST)
        self.glDepthFunc(self.GL_LEQUAL)
    else
        self.glDisable(self.GL_DEPTH_TEST)
    end
end

function OpenGL:clip(x, y, w, h)
    if x then
        self.glEnable(self.GL_SCISSOR_TEST)
        self.glScissor(x, y, w, h)
    else
        self.glDisable(self.GL_SCISSOR_TEST)
    end
end

function OpenGL:saveDefaultContext()
    self.defaultRenderBuffer = self.glGetInteger(gl.GL_RENDERBUFFER_BINDING)
    self.defaultFrameBuffer = self.glGetInteger(gl.GL_FRAMEBUFFER_BINDING)
end

function OpenGL:defaultContext()
    self.glBindFramebuffer(self.GL_FRAMEBUFFER, self.defaultFrameBuffer or 0)
    self.glBindRenderbuffer(self.GL_RENDERBUFFER, self.defaultRenderBuffer or 0)
end

function OpenGL:bind(buffer)
    self.glBindFramebuffer(self.GL_FRAMEBUFFER, buffer)
end

function OpenGL:viewport(x, y, w, h)
    self.glViewport(x, y, w, h)
end
