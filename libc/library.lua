class 'Library'

function Library.precompile(str)
    if str == nil then return '' end
    
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

function Library:checkState(file, lib)
    local infoFile = fs.getInfo(file)
    local infoLib = fs.getInfo(lib)

    if infoLib == nil or infoLib.modification < infoFile.modification then
        return false
    end

    return true
end

function Library.compileFile(srcName, moduleName, headers, links, options)
    local libExtension = osx and 'so' or 'dll'

    local params = {
        compiler = 'gcc',
        srcName = srcName,
        headerName = string.format('libc/bin/{moduleName}.h', {moduleName=moduleName}),
        libName = string.format('libc/bin/{moduleName}.{libExtension}', {moduleName=moduleName, libExtension=libExtension}),
        headers = headers or '',
        links = links or '',
        options = options or ''
    }

    if not Library:checkState(params.srcName, params.libName) then

        print('compile '..moduleName)

        if windows then
            params.compiler = [[
            set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%%PATH%%;
            clang.exe]]

            local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)
            io.write('libc/bin/make.bat', command)

            params.res = os.execute('"libc\\bin\\make.bat" > libc\\bin\\make.log')

        else
            local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)

            params.res = os.execute(command)
        end

        assert(params.res == 0)

    end

    if love then
        params.libName = '/Users/Ludo/Projets/Lua/Engine/'..params.libName
    end
    
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

    if not Library:checkState(params.srcName, params.libName) then

        print('compile '..moduleName)


        if windows then
            params.compiler = [[
            set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%%PATH%%;
            clang++.exe]]

            local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)
            io.write('libc/bin/make.bat', command)

            params.res = os.execute('"libc\\bin\\make.bat" > libc\\bin\\make.log')

        else
            local command = string.format('{compiler} -Wall {options} {headers} -o {libName} {srcName} {links}', params)

            params.res = os.execute(command)
        end

        assert(params.res == 0)

    end

    if love then
        params.libName = '/Users/Ludo/Projets/Lua/Engine/'..params.libName
    end

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
