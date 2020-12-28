-- OpenGL

gl = gl or class()

function gl.load()
    if gl.loaded then return end
    gl.loaded = true

    if osx then
        local content = [[
            #define GL3_PROTOTYPES 1
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

        save(osLibPath..'/opengl/src/stub.c', content)

        os.execute(
            "gcc -F/Library/Frameworks -E     '"..osLibPath.."/opengl/src/stub.c' | grep -v '^#' > '"..osLibPath.."/opengl/src/ffi_OpenGL.c';"..
            "gcc -F/Library/Frameworks -dM -E '"..osLibPath.."/opengl/src/stub.c'                > '"..osLibPath.."/opengl/src/ffi_OpenGL.h';")
    end

    local lib
    if osx then
        lib = 'OpenGL'
    else
        lib = 'system32/OpenGL32'
    end

    cload(gl,
        lib,
        'GL_',
        osLibPath..'/opengl/src/ffi_OpenGL.h',
        nil, --osLibPath..'/opengl/src/ffi_OpenGL.c'
        true)

    function getProcAddress(fn)
        local procAddress = sdl.SDL_GL_GetProcAddress(fn)
        assert(procAddress ~= NULL)
        return procAddress
    end

    function getProc(fn)
        _,gl.defs[fn] = pcall(ffi.cast, 'PFN'..fn:upper()..'PROC', getProcAddress(fn))
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
            'glLinkProgram',
            'glUseProgram',
            'glGetProgramiv',
            'glGetProgramInfoLog',
            'glBlendFuncSeparate',

            'glGetString',
            'glIsShader',
            'glCreateShader',
            'glShaderSource',
            'glAttachShader',

            'glBindAttribLocation',
            'glGetShaderiv',
            'glCompileShader',
            'glGetShaderInfoLog',
            'glGetUniformLocation',

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
            'glBlendEquation'
            }) do
        getProc(fn)
    end

    for k,v in pairs(gl.defs) do
        gl.defs[k] = function (...)
            local result = v(...)
            gl.exitOnError(k)
            return result
        end
    end

    gl.defs.glGetError = gl.defsLoaded.glGetError
    
    gl.defsLoaded = nil
end

local errors = {}
function gl.exitOnError(txt)
    local err = gl.glGetError()
    while err ~= gl.GL_NO_ERROR do
        local i = 2
        while true do
            local error = getFunctionLocation((i-1)..'.ERR('..string.format('0x%02X', err)..','..err..'):', i)
            if error == nil or errors[error] then
                break
            end

            errors[error] = error
            
            print(error)

            i = i + 1
        end
        err = gl.glGetError()
    end
end

function gl.init()
    -- smooth
    gl.glEnable(gl.GL_LINE_SMOOTH)
    gl.glEnable(gl.GL_POLYGON_SMOOTH)

    -- hint
    gl.glHint(gl.GL_LINE_SMOOTH_HINT, gl.GL_NICEST)
    gl.glHint(gl.GL_POLYGON_SMOOTH_HINT, gl.GL_NICEST)

    -- Disable states
    gl.glDisable(gl.GL_DITHER)
    gl.glDisable(gl.GL_STENCIL_TEST)

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

function gl.float(value)
    return ffi.new('GLfloat[1]', value or 0)
end

function gl.double(len, value)
    return ffi.new('GLdouble[?]', len or 1, value or 0)
end

function gl.uint(value)
    return ffi.new('GLuint[1]', value or 0)
end

function gl.int(len, value)
    return ffi.new('GLint[?]', len or 1, value or 0)
end

function gl.char(len)
    return ffi.new('GLchar[?]', len)
end

function gl.glBufferOffset(offset)
    return ffi.cast('char*', offset)
end

function gl.glGenBuffer()
    local id = gl.uint()
    gl.glGenBuffer = function()
        gl.glGenBuffers(1, id)
        return id[0]
    end
    return gl.glGenBuffer()
end

function gl.glGenTexture()
    local id = gl.uint()
    gl.glGenTexture = function()
        gl.glGenTextures(1, id)
        return id[0]
    end
    return gl.glGenTexture()
end

function gl.glGenRenderbuffer()
    local id = gl.uint()
    gl.glGenRenderbuffer = function ()
        gl.glGenRenderbuffers(1, id)
        return id[0]
    end
    return gl.glGenRenderbuffer()
end

function gl.glDeleteFramebuffer()
    local id = gl.uint()
    gl.glDeleteFramebuffer = function()
        gl.glDeleteFramebuffers(1, id)
        return id[0]
    end
    return gl.glDeleteFramebuffer()
end

function gl.glGenFramebuffer()
    local id = gl.uint()
    gl.glGenFramebuffer = function()
        gl.glGenFramebuffers(1, id)
        return id[0]
    end
    return gl.glGenFramebuffer()
end

function gl.glDeleteRenderbuffer(id)
    local idptr = gl.uint()
    gl.glDeleteRenderbuffer = function(id)
        idptr[0] = id
        gl.glDeleteRenderbuffers(1, idptr)
    end
    gl.glDeleteRenderbuffer(id)
end

function gl.glDeleteBuffer(id)
    local idptr = gl.uint()
    gl.glDeleteBuffer = function(id)
        idptr[0] = id
        gl.glDeleteBuffers(1, idptr)
    end
    gl.glDeleteBuffer(id)
end

function gl.glDeleteTexture(id)
    local idptr = gl.uint()
    gl.glDeleteTexture = function(id)
        idptr[0] = id
        gl.glDeleteTextures(1, idptr)
    end
    gl.glDeleteTexture(id)
end

function gl.glGenVertexArray()
    local id = gl.uint()
    gl.glGenVertexArray = function()
        gl.glGenVertexArrays(1, id)
        return id[0]
    end
    return gl.glGenVertexArray()
end

function gl.glDeleteVertexArray(id)
    local idptr = gl.uint()
    gl.glDeleteVertexArray = function(id)
        idptr[0] = id
        gl.glDeleteVertexArrays(1, idptr)
    end
    gl.glDeleteVertexArray(id)
end

function gl.glGetShaderiv(id, flag)
    local flag_v = gl.int()
    gl.glGetShaderiv = function(id, flag)
        gl.defs.glGetShaderiv(id, flag, flag_v)
        return flag_v[0]
    end
    return gl.glGetShaderiv(id, flag)
end

function gl.glGetShaderInfoLog(id)
    local len = gl.glGetShaderiv(id, gl.GL_INFO_LOG_LENGTH)
    if len == 0 then
        return 'len == 0'
    else
        local log = gl.char(len)
        gl.defs.glGetShaderInfoLog(id, len, nil, log)
        return ffi.string(log, len - 1)
    end
end

function gl.glGetProgramiv(id, flag)
    local flag_v = gl.int()
    gl.glGetProgramiv = function(id, flag)
        gl.defs.glGetProgramiv(id, flag, flag_v)
        return flag_v[0]
    end
    return gl.glGetProgramiv(id, flag)
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

local ctypes = {}

function to1(p, t, nElems, nCoords, typeCoord)
    local j = 0
    local elem = 0
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

    local norm = 1 / 255

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
        if typeOf(t[1]) == 'color' or typeOf(t[1]) == 'Color'  then
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
    if config.debugging then
        function assertBufferEqual(dataLua, dataC, n)
            local j = 0
            function assertEqual(a, b)
                b = b or dataC[j]
                --assert(ceil(a) == ceil(b), a.."=?"..b)
                j = j + 1
            end
            for i,v in ipairs(dataLua) do
                if n == 1 then
                    assertEqual(v)
                else
                    assertEqual(v.x or v.r)
                    assertEqual(v.y or v.g)
                    if n > 2 then
                        assertEqual(v.z or v.b)
                    end
                    if n > 3 then
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

function gl.glBufferSubDataMatrix(target, offset, matrixSize, data)
    gl.defs.glBufferSubData(target, offset, matrixSize, data.matrix.data)
end

function gl.glVertexAttribPointer(index, size, type, normalized, stride, pointer)
    gl.defs.glVertexAttribPointer(index, size, type, normalized, stride, gl.glBufferOffset(pointer))
end

function gl.glUniformMatrix4fv(location, count, transpose, data)
    --    local data2 = gl.new(1, 16, 'GLfloat')
    --    gl.glUniformMatrix4fv = function (location, count, transpose, data)
    --        gl.copy(data2, data, 1, 16, 'GLfloat')
    --        gl.defs.glUniformMatrix4fv(location, count, transpose, data2)
    --        return data2
    --    end
    --    gl.glUniformMatrix4fv(...)
    gl.defs.glUniformMatrix4fv(location, count, transpose, data.matrix.data)
end

function gl.glUniform1fv(...)
    local dataptr = gl.float()
    gl.glUniform1fv = function (location, count, data)
        dataptr[0] = data
        gl.defs.glUniform1fv(location, count, dataptr)
    end
    gl.glUniform1fv(...)
end

function gl.glUniform1iv(...)
    local dataptr = gl.int()
    gl.glUniform1iv = function (location, count, data)
        dataptr[0] = data
        gl.defs.glUniform1iv(location, count, dataptr)
    end
    gl.glUniform1iv(...)
end

function gl.glGetIntegers(name, len)
    local params = gl.int(32)
    gl.glGetIntegers = function (name, len)
        assert(len<=32)
        gl.defs.glGetIntegerv(name, params)
        return params
    end
    return gl.glGetIntegers(name, len)
end

function gl.glAvailableMemory()
    return 0
    -- TODO
    --return gl.glGetIntegers(gl.GL_VBO_FREE_MEMORY_ATI, 4)[0]
end

function gl.rgba(clr)
    return clr.r/255, clr.g/255, clr.b/255, clr.a/255
end

return gl
