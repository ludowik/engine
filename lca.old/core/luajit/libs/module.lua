function loadModule(name, make)
    function getLastModifiedTime(src)
        local attributes = lfs.attributes(src)
        return attributes and attributes.modification
    end

    if make then
        local currentdir = lfs.currentdir()
        lfs.chdir(osLibPath..'/'..name)

        local nameLib = name
        local pathLib
        if osx then
            pathLib = '../bin/'..osLibDir..'/'..nameLib..'.so'
        else
            pathLib = '../bin/'..osLibDir..'/'..nameLib..'.dll'
        end

        local timeSrc = getLastModifiedTime('src/'..name..'.cpp')
        local timeLib = getLastModifiedTime(pathLib)
        if timeLib and timeSrc < timeLib then
            --print(name..' is up to date')
        else
            print(name..' need to update')
            
            local result
            if osx then
                result = os.execute('make -f make/makefile.osx')
            else
                result = os.execute('make\\make.cmd')
            end
            
            assert(result == 0)
        end

        lfs.chdir(currentdir)
    end

    local ref = lua.require(osLibPath..'.'..name..'.'..name)
    if type(ref) == 'table' or type(ref) == 'userdata' or type(ref) == 'cdata' then
        return ref
    else
        return nil
    end
end
