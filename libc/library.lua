class 'Library'

function Library.precompile(str)
    local defs = {}

    function define2const(def, value)
        defs[def] = tonumber(value)
        return 'static const int '..def..' = '..value..';\r'
    end

    str = str:gsub("#define%s+(%S+)%s+(%S+)[\r\n]", define2const)

    return str, defs
end

function Library.compileCode(code, moduleName, headers, links, options)
    local libExtension = osx and 'so' or 'dll'

    local params = {
        srcName = string.format('libc/bin/{moduleName}.c' , {moduleName=moduleName}),
        libName = string.format('libc/bin/{moduleName}.{libExtension}', {moduleName=moduleName, libExtension=libExtension})
    }

    io.write(params.srcName, code)

    return Library.compileFile(params.srcName, moduleName, headers, links, options)
end

function Library.compileFile(srcName, moduleName, headers, links, options)
    local libExtension = osx and 'so' or 'dll'

    local params = {
        srcName = srcName,
        headerName = string.format('libc/bin/{moduleName}.h', {moduleName=moduleName}),
        libName = string.format('libc/bin/{moduleName}.{libExtension}', {moduleName=moduleName, libExtension=libExtension}),
        headers = headers or '',
        links = links or '',
        options = options or ''
    }

    if windows then
        params.compiler = [[
            set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%%PATH%%
            clang.exe]]

        local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)
        io.write('make.bat', command)

        local res = os.execute('make.bat > 0')
        assert(res == 0)
    else
        params.compiler = 'gcc'

        local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)

        local res = os.execute(command)
        assert(res == 0)
    end

-- TODEL
--    command = string.format('gcc -E -M {headers} -o {headerName} {srcName}', params)
--    res = os.execute(command)
--    assert(res == 0)

    return ffi.load(params.libName)
end

function Library.compileFileCPP(srcName, moduleName, headers, links, options)
    local libExtension = osx and 'so' or 'dll'

    local params = {
        compiler = 'g++',
        srcName = srcName,
        headerName = string.format('libc/bin/{moduleName}.h', {moduleName=moduleName}),
        libName = string.format('libc/bin/{moduleName}.{libExtension}', {moduleName=moduleName, libExtension=libExtension}),
        headers = headers or '',
        links = links or '',
        options = options or ''
    }

    if windows then
        params.compiler = [[
            set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%%PATH%%
            clang++.exe]]

        local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)
        io.write('make.bat', command)

        local res = os.execute('make.bat > 0')
        assert(res == 0)
    else
        params.compiler = 'g++'

        local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)

        local res = os.execute(command)
        assert(res == 0)
    end

    --    command = string.format('g++ -E -M {options} {headers} -o {headerName} {srcName}', params)
    --    res = os.execute(command)
    --    assert(res == 0, res)

    return ffi.load(params.libName)
end

function Library.load(libName, libNamewindows, libDir)
    if osx then 
        libDir = libDir or ('/Users/Ludo/Projets/Libraries/'..libName)
    else
        libDir = libDir or ('/Windows/System32')
    end

    local libPath
    if osx then 
        libName = libName..'.framework/'..libName
        libPath = libDir..'/'..libName
    else
        libName = libNamewindows or libName
        libPath = libDir..'/'..libName
    end

    return ffi.load(libPath)
end

ffi = require 'ffi'

ffi.NULL = ffi.cast('void*', 0)

-- TODO
-- Générer les header directement
-- "gcc -F"..self.sdk.." -E     '"..stub.."' | grep -v '^#' > '"..cFile.."';"..
-- "gcc -F"..self.sdk.." -dM -E '"..stub.."'                > '"..hFile.."';")


