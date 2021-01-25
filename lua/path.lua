class('Path')

function Path.setup()
    Path.sourcePath = lfs.currentdir()

    if windows then
        Path.libraryPath = 'C:/Users/lmilhau/Documents/#Persos/Mes Projets Persos/Libraries'
    else
        Path.libraryPath = '/Users/ludo/Projets/Libraries'
    end
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
        lfs.mkdir(fullPath)
    end

    return absolute and fullPath or path
end

function getSourcePath()
    return Path.sourcePath
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
    if ios and love then
        return love.filesystem.getSaveDirectory()..'/'..path
    else
        return path
    end
end

function getReadPath(path)
    if ios then
        if lfs.attributes(path) then
            return path

        elseif lfs.attributes(lfs.currentdir()..'/'..path) then
            return lfs.currentdir()..'/'..path

        elseif love and lfs.attributes(love.filesystem.getSaveDirectory()..'/'..path) then
            return love.filesystem.getSaveDirectory()..'/'..path
        end
    end
    return path
end
