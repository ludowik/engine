class 'Library'

function Library.compileCode(code, moduleName)
    local params = {
        srcName = string.format('bin/{moduleName}.c' , {moduleName=moduleName}),
        libName = string.format('bin/{moduleName}.so', {moduleName=moduleName})
    }

    io.write(params.srcName, code)
    
    return Library.compileFile(params.srcName, moduleName)
end

function Library.compileFile(srcName, moduleName, headers, links)
    local params = {
        srcName = srcName,
        headerName = string.format('bin/{moduleName}.h', {moduleName=moduleName}),
        libName = string.format('bin/{moduleName}.so', {moduleName=moduleName}),
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
