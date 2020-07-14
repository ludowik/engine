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

function Library.compileCode(code, moduleName)
    local params = {
        srcName = string.format('libc/bin/{moduleName}.c' , {moduleName=moduleName}),
        libName = string.format('libc/bin/{moduleName}.so', {moduleName=moduleName})
    }

    io.write(params.srcName, code)

    return Library.compileFile(params.srcName, moduleName)
end

function Library.compileFile(srcName, moduleName, headers, links)
    local params = {
        srcName = srcName,
        headerName = string.format('libc/bin/{moduleName}.h', {moduleName=moduleName}),
        libName = string.format('libc/bin/{moduleName}.so', {moduleName=moduleName}),
        headers = headers or '',
        links = links or ''
    }

    local command = string.format('gcc -Wall -shared {headers} -o {libName} {srcName} {links}', params)
    local res = os.execute(command)
    assert(res == 0)

    command = string.format('gcc -E -M {headers} -o {headerName} {srcName}', params)
    res = os.execute(command)
    assert(res == 0)

    return ffi.load(params.libName)
end

function Library.load(libName)
    local libPath
    if os.name == 'osx' then 
        libPath = libName..'.framework/'..libName
    else
        libPath = 'System32/'..libName
    end
    return ffi.load(libPath)
end

ffi = require 'ffi'

ffi.NULL = ffi.cast('void*', 0)

-- TODO
-- Générer les header directement
-- "gcc -F"..self.sdk.." -E     '"..stub.."' | grep -v '^#' > '"..cFile.."';"..
-- "gcc -F"..self.sdk.." -dM -E '"..stub.."'                > '"..hFile.."';")


