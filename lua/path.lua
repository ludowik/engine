class('Path')

function Path.setup()
    Path.sourcePath = lfs.currentdir()
end

function getFullPath(path, directory)
    if path:left(1) == '/' then 
        return path
    end
    return (directory or lfs.currentdir())..'/'..path
end

function validatePath(path, directory, absolute)
    fullPath = getFullPath(path, directory)

    if not isDirectory(fullPath) then
        if love then
            lfs.mkdir(path)
        else
            lfs.mkdir(fullPath)
        end
    end

    return absolute and fullPath or path
end

function getSourcePath()
    return Path.sourcePath
end

function getLibPath(libName, libNamewindows, libDir)
    if windows then
        local home = getHomePath()
        -- TOFIX
        Path.libraryPath = home..'/Documents/#Persos/Mes Projets Persos/Libraries'        
        Path.libraryPath = '/windows/system32'
    else
        local home = getHomePath()
        Path.libraryPath = home..'/Projets/Libraries'
    end

    local libPath

    libDir = libDir or Path.libraryPath

    if not libName then
        return libDir
    end

    if osx then
        libName = libName..'/'..libName..'.framework/'..libName
        libPath = libDir..'/'..libName
    else
        libName = libNamewindows or libName
        libPath = libDir..'/'..libName
    end

    return libPath
end

function getHomePath()
    if windows then
        return os.getenv('USERPROFILE')
    else
        return '/Users/Ludo'
--        return os.getenv('HOME')
    end
end

function getDataPath()
    return validatePath('res/data')
end

function getConfigPath()
    return validatePath('res/config')
end

function getImagePath()
    return validatePath('res/images')
end

function getModelPath()
    return validatePath('res/models')
end

DEF_FONT_PATH = 'res/fonts'
function setFontPath(fontPath)
    DEF_FONT_PATH = fontPath
end

function getFontPath(fontName, ext)
    if not fontName then return DEF_FONT_PATH end
    return DEF_FONT_PATH..'/'..fontName..'.'..(ext or 'ttf')
end

function getSavePath(path)
    if love then
        return (
            love.filesystem.getSaveDirectory()..'/'..
            love.filesystem.getIdentity()..'/'..
            path
        )
    else
        return path
    end
end

function getReadPath(path)
    if love then
        if lfs.attributes(path) then
            return path

        elseif lfs.attributes(lfs.currentdir()..'/'..path) then
            return lfs.currentdir()..'/'..path

        elseif love and lfs.attributes(getSavePath(path)) then
            return getSavePath(path)
        end
    end
    return path
end
