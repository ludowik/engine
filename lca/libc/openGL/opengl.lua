local srcPath, lib = ...
if osx then
    lib = 'OpenGL.framework/OpenGL'
else
    lib = 'system32/OpenGL32'
end

local content = [[
    #define GL3_PROTOTYPES 1

    #define GL_GLEXT_PROTOTYPES 1

    #include <openGL/gl3.h>

    #ifndef GL_VBO_FREE_MEMORY_ATI
        #define GL_VBO_FREE_MEMORY_ATI          0x87FB
        #define GL_TEXTURE_FREE_MEMORY_ATI      0x87FC
        #define GL_RENDERBUFFER_FREE_MEMORY_ATI 0x87FD
    #endif

    #define GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX          0x9047
    #define GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX    0x9048
    #define GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX  0x9049
    #define GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX            0x904A
    #define GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX            0x904B
]]

gl = Lib(srcPath, 'openGL', lib, content, 'GL', true, false)

local ctypes = {}

function gl.initializeDefs()
    function getProcAddress(fn)
        local procAddress = sdl.SDL_GL_GetProcAddress(fn)
        assert(procAddress ~= NULL)
        return procAddress
    end

    function getProc(fn)
        local _, func = pcall(ffi.cast, 'PFN'..fn:upper()..'PROC', getProcAddress(fn))
        return func
    end

    for i,fn in ipairs({
            'glEnable',
            'glDisable',

            'glFrontFace',
            'glCullFace',
            'glDepthFunc',
            'glHint',
            'glViewport',
            'glBlendFunc',
            'glClearColor',
            'glClearDepth',
            'glClear',
            'glScissor',

            'glIsProgram',
            'glCreateProgram',
            'glDeleteProgram',
            'glLinkProgram',
            'glUseProgram',
            'glGetProgramiv',
            'glGetProgramInfoLog',
            'glBlendFuncSeparate',

            'glGetString',
            'glIsShader',
            'glCreateShader',
            'glDeleteShader',
            'glShaderSource',
            'glAttachShader',
            'glDetachShader',
            'glCompileShader',            

            'glBindAttribLocation',
            'glGetShaderiv',
            'glGetShaderInfoLog',
            'glGetUniformLocation',
            'glGetAttribLocation',
            'glGetActiveUniform',

            'glIsBuffer',
            'glGenBuffers',
            'glDeleteBuffers',
            'glBindBuffer',
            'glDrawBuffer',

            'glBufferData',
            'glBufferSubData',
            'glGenFramebuffers',
            'glBindFramebuffer',

            'glGenTextures',
            'glDeleteTextures',
            'glIsTexture',
            'glActiveTexture',
            'glBindTexture',
            'glTexParameteri',
            'glTexSubImage2D',
            'glTexImage2D',
            'glGetTexImage',
            'glPixelStorei',

            'glFramebufferTexture',
            'glGenRenderbuffers',
            'glBindRenderbuffer',
            'glRenderbufferStorage',
            'glFramebufferRenderbuffer',
            'glCheckFramebufferStatus',
            'glDeleteRenderbuffers',
            'glDeleteFramebuffers',

            'glIsVertexArray',
            'glGenVertexArrays',
            'glBindVertexArray',
            'glDeleteVertexArrays',
            'glDisableVertexAttribArray',
            'glDrawElements',
            'glDrawElementsInstanced',
            'glDrawArrays',
            'glDrawArraysInstanced',
            'glDrawArraysIndirect',
            'glPolygonMode',
            'glLineWidth',

            'glVertexAttribPointer',
            'glVertexAttribDivisor',
            'glEnableVertexAttribArray',
            'glUniformMatrix4fv',
            'glUniform1i',
            'glUniform1iv',
            'glUniform1fv',
            'glUniform2fv',
            'glUniform3fv',
            'glUniform4fv',

            'glGetBooleanv',
            'glGetFloatv',
            'glGetIntegerv',
            'glBlendEquation',
            'glGenerateMipmap'
            }) do

        local func
        if osx then 
            func = gl.defsLoaded[fn] or getProc(fn)
        else
            func = getProc(fn)
        end

        gl.defs[fn] = function (...)
            local result = func(...)
            local err = gl.glGetError()
            if err ~= gl.GL_NO_ERROR then
                gl.exitOnError(fn, err)
            end
            return result
        end

    end

    gl.defs.glGetError = gl.defsLoaded.glGetError or getProc('glGetError')

    gl.defsLoaded = nil

    ctypes['void*'] = ffi.typeof('void*')
end

local errors = {}
function gl.exitOnError(fn, errorFlag)
--    local errorFlag = gl.glGetError()
    while errorFlag ~= gl.GL_NO_ERROR do
        local i = 0
        while true do
            i = i + 1

            local errorLabel = getFunctionLocation(i..'.ERR('..gl.formatError(errorFlag)..'):', i)
            if errorLabel == nil or errors[errorLabel] then
                break
            end
            errors[errorLabel] = errorLabel

            print(fn..':'..errorLabel)
        end

        errorFlag = gl.glGetError()
    end
    assert()
end

function gl.formatError(err)
    for k,v in pairs(gl) do
        if v == err then
            return k
        end
    end
    return string.format('0x%02X', err)..','..err
end

local idptr, intptr, floatptr, lengthptr, sizeptr, charptr
function gl.initialize()
    gl.initializeDefs()

    -- Smooth
    gl.glEnable(gl.GL_LINE_SMOOTH)
    gl.glEnable(gl.GL_POLYGON_SMOOTH)

    -- Hint
    gl.glHint(gl.GL_LINE_SMOOTH_HINT, gl.GL_NICEST)
    gl.glHint(gl.GL_POLYGON_SMOOTH_HINT, gl.GL_NICEST)

    -- Multi Sampling
    gl.glEnable(gl.GL_MULTISAMPLE)

    -- Disable states
    gl.glDisable(gl.GL_DITHER)
    gl.glDisable(gl.GL_STENCIL_TEST)

    idptr = gl.uint(4)
    intptr = gl.int(4)
    floatptr = gl.float(4)

    lengthptr = gl.sizei()
    sizeptr = gl.int()
    typeptr = gl.enum()
    charptr = gl.char(128)

    matrixptr = gl.new(1, 16, 'GLfloat')

    return true
end

function gl.release()
end

function gl.glSizeOfFloat()
    return ffi.sizeof('GLfloat')
end

function gl.glSizeOfShort()
    return ffi.sizeof('GLushort')
end

function gl.glSizeOfInt()
    return ffi.sizeof('GLuint')
end

function gl.float(len, value)
    return ffi.new('GLfloat[?]', len or 1, value or 0)
end

function gl.double(len, value)
    return ffi.new('GLdouble[?]', len or 1, value or 0)
end

function gl.uint(len, value)
    return ffi.new('GLuint[?]', len or 1, value or 0)
end

function gl.int(len, value)
    return ffi.new('GLint[?]', len or 1, value or 0)
end

function gl.char(len)
    return ffi.new('GLchar[?]', len or 1)
end

function gl.sizei(len)
    return ffi.new('GLsizei[?]', len or 1)
end

function gl.enum(len)
    return ffi.new('GLenum[?]', len or 1)
end

function gl.glBufferOffset(offset)
    if offset == 0 then
        return ffi.NULL
    end
    return ffi.cast(ctypes['void*'], offset)
end

function gl.glGenBuffer()
    gl.glGenBuffers(1, idptr)
    return idptr[0]
end

function gl.glGenTexture()
    gl.glGenTextures(1, idptr)
    return idptr[0]
end

function gl.glGenRenderbuffer()
    gl.glGenRenderbuffers(1, idptr)
    return idptr[0]
end

function gl.glDeleteFramebuffer()
    gl.glDeleteFramebuffers(1, idptr)
    return idptr[0]
end

function gl.glGenFramebuffer()
    gl.glGenFramebuffers(1, idptr)
    return idptr[0]
end

function gl.glDeleteRenderbuffer(id)
    idptr[0] = id
    gl.glDeleteRenderbuffers(1, idptr)
end

function gl.glDeleteBuffer(id)
    idptr[0] = id
    gl.glDeleteBuffers(1, idptr)
end

function gl.glDeleteTexture(id)
    idptr[0] = id
    gl.glDeleteTextures(1, idptr)
end

function gl.glGenVertexArray()
    gl.glGenVertexArrays(1, idptr)
    return idptr[0]
end

function gl.glDeleteVertexArray(id)
    idptr[0] = id
    gl.glDeleteVertexArrays(1, idptr)
end

function gl.glGetShaderiv(id, flag)
    gl.defs.glGetShaderiv(id, flag, intptr)
    return intptr[0]
end

function gl.glGetShaderInfoLog(id)
    local len = gl.glGetShaderiv(id, gl.GL_INFO_LOG_LENGTH)
    if len == 0 then
        return 'len == 0'
    else
        local log = gl.char(len)
        gl.defs.glGetShaderInfoLog(id, len, nil, log)
        return ffi.string(log, len - 1):replace('ERROR: 0', '')
    end
end

function gl.glGetProgramiv(id, flag)
    gl.defs.glGetProgramiv(id, flag, intptr)
    return intptr[0]
end

function gl.glGetProgramInfoLog(id)
    local len = gl.glGetProgramiv(id, gl.GL_INFO_LOG_LENGTH)
    if len == 0 then
        return 'len == 0'
    else
        local log = gl.char(len)
        gl.defs.glGetProgramInfoLog(id, len, nil, log)
        return ffi.string(log, len - 1)
    end
end

function gl.glShaderSource(id, code)
    local s = ffi.new('const GLchar*[1]', {code})
    local l = ffi.new('GLint[1]', #code)

    gl.defs.glShaderSource(id, 1, s, l)
end

function gl.glGetString(name)
    local str = gl.defs.glGetString(name)
    if str ~= NULL then
        return ffi.string(str)
    end
    return nil
end
function to1(p, t, nElems, nCoords, typeCoord)
    for i = 1, nElems do
        p[i-1] = t[i]
    end
end

function to2(p, t, nElems, nCoords, typeCoord)
    local j = 0
    local elem = 0
    for i = 1, nElems do
        elem = t[i]
        p[j] = elem.x
        p[j+1] = elem.y
        j = j + 2
    end
end

function to3(p, t, nElems, nCoords, typeCoord)
    local j = 0
    local elem = 0
    for i = 1, nElems do
        elem = t[i]
        p[j] = elem.x
        p[j+1] = elem.y
        p[j+2] = elem.z or 0
        j = j + 3
    end
end

function to4(p, t, nElems, nCoords, typeCoord)
    local j = 0
    local elem = 0
    for i = 1, nElems do
        elem = t[i]
        p[j] = elem.x
        p[j+1] = elem.y
        p[j+2] = elem.z or 0
        p[j+3] = elem.w or 0
        j = j + 4
    end
end

function toColor(p, t, nElems, nCoords, typeCoord)
    local j = 0
    local elem = 0

    local norm = 1

    for i = 1, nElems do
        elem = t[i]
        p[j] = elem.r * norm
        p[j+1] = elem.g * norm
        p[j+2] = elem.b * norm
        p[j+3] = elem.a * norm
        j = j + 4
    end
end

function to16(p, t, nElems, nCoords, typeCoord)
    for i = 1, nElems * nCoords do
        p[i-1] = t[i]
    end
end

function gl.to(t, nElems, nCoords, typeCoord)
    local p = gl.new(nElems, nCoords, typeCoord)
    return gl.copy(p, t, nElems, nCoords, typeCoord)
end

function gl.new(nElems, nCoords, typeCoord)
    local ctype = ctypes[typeCoord]
    if ctype == nil then
        ctypes[typeCoord] = ffi.typeof(typeCoord..'[?]')
        ctype = ctypes[typeCoord]
    end
    return ctype(nElems * nCoords)
end

function gl.copy(p, t, nElems, nCoords, typeCoord)
    if nCoords == 1 then
        to1(p, t, nElems, nCoords, typeCoord)
    elseif nCoords == 2 then
        to2(p, t, nElems, nCoords, typeCoord)
    elseif nCoords == 3 then
        to3(p, t, nElems, nCoords, typeCoord)
    elseif nCoords == 4 then
        if typeof(t[1]) == 'cdata' or typeof(t[1]) == 'color' then
            toColor(p, t, nElems, nCoords, typeCoord)
        else
            to4(p, t, nElems, nCoords, typeCoord)
        end
    elseif nCoords == 16 then
        to16(p, t, nElems, nCoords, typeCoord)
    end
    gl.toDebugging(p, t, nElems, nCoords, typeCoord)
    return p
end

function gl.toDebugging(p, t, nElems, nCoords, typeCoord)
    if debugging() then
        function assertBufferEqual(dataLua, dataC, nCoords)
            local j = 0
            function assertEqual(a, b)
                b = b or dataC[j]
                --assert(ceil(a) == ceil(b), a.."=?"..b)
                j = j + 1
            end
            for i=1,#dataLua do
                local v = dataLua[i]
                if nCoords == 1 then
                    assertEqual(v)
                else
                    assertEqual(v.x or v.r)
                    assertEqual(v.y or v.g)
                    if nCoords > 2 then
                        assertEqual(v.z or v.b)
                    end
                    if nCoords > 3 then
                        assertEqual(v.w or v.a)
                    end
                end
            end
        end
        assertBufferEqual(t, p, nCoords)
    end

    return p
end

function gl.glBufferSubData(target, offset, nElems, nCoords, sizeElem, typeElem, data)
    local size = nElems * nCoords * sizeElem
    data = gl.to(data, nElems, nCoords, typeElem)
    gl.defs.glBufferSubData(target, offset, size, data)
end

local useData = true
function gl.glBufferSubDataMatrix(target, offset, matrixSize, data)
    if useData and data.datamatrix then
        gl.defs.glBufferSubData(target, offset, matrixSize, data.datamatrix)
    else
        gl.copy(matrixptr, data, 16, 1, 'GLfloat')
        gl.defs.glBufferSubData(target, offset, matrixSize, matrixptr)
    end
end

function gl.glVertexAttribPointer(index, size, type, normalized, stride, pointer)
    gl.defs.glVertexAttribPointer(index, size, type, normalized, stride, gl.glBufferOffset(pointer))
end

function gl.glGetActiveUniform(program, index)
    gl.defs.glGetActiveUniform(program, index, ffi.sizeof(charptr), lengthptr, sizeptr, typeptr, charptr)
    return typeptr[0], ffi.string(charptr)
end

function gl.glUniformMatrix4fv(location, count, transpose, data)
    if useData and data.datamatrix then
        gl.defs.glUniformMatrix4fv(location, count, transpose, data.datamatrix)
    else
        gl.copy(matrixptr, data, 16, 1, 'GLfloat')
        gl.defs.glUniformMatrix4fv(location, count, transpose, matrixptr)
    end
end

function gl.glUniform1fv(location, count, data)
    floatptr[0] = data
    gl.defs.glUniform1fv(location, count, floatptr)
end

function gl.glUniform2fv(location, count, data1, data2)
    floatptr[0] = data1
    floatptr[1] = data2
    gl.defs.glUniform2fv(location, count, floatptr)
end

function gl.glUniform3fv(location, count, data1, data2, data3)
    floatptr[0] = data1
    floatptr[1] = data2
    floatptr[2] = data3
    gl.defs.glUniform3fv(location, count, floatptr)
end

function gl.glUniform4fv(location, count, data1, data2, data3, data4)
    floatptr[0] = data1
    floatptr[1] = data2
    floatptr[2] = data3
    floatptr[3] = data4
    gl.defs.glUniform4fv(location, count, floatptr)
end

function gl.glUniform1iv(location, count, data)
    intptr[0] = data
    gl.defs.glUniform1iv(location, count, intptr)
end

function gl.glGetIntegers(name, len)
    local params = gl.int(1, 32)
    gl.glGetIntegers = function (name, len)
        assert(len<=32)
        gl.defs.glGetIntegerv(name, params)
        return params
    end
    return gl.glGetIntegers(name, len)
end

function gl.glAvailableMemory()
    -- TODO
    --return gl.glGetIntegers(gl.GL_VBO_FREE_MEMORY_ATI, 4)[0]
    return 0
end

function gl.getVersion()
    return tostring(gl.getOpenGLVersion())
end

function gl.getOpenGLVersion()
    return gl.majorVersion * 100 + gl.minorVersion * 10
end

function gl.getGlslVersion()
    local glVersion = gl.getOpenGLVersion()
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

function gl.getGlslVersionDefine()
    return (
        '#version '..gl.getGlslVersion()..NL..
        '#define VERSION '..gl.getGlslVersion()..NL)
end

return gl
