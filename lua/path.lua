class('Path')

function Path.setup()
    Path.sourcePath = lfs.currentdir()
end

function validatePath(path)
    local fullPath = getFullPath(path)

    if not isDirectory(fullPath) then
        lfs.mkdir(fullPath)
    end
    return path
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

function getFontPath(fontName, ext)
    return 'res/font/'..fontName..'.'..(ext or 'ttf')
end

function getFullPath(path)
    return lfs.currentdir()..'/'..path
end

function getSavePath(path)
    return path
end

function getReadPath(path)
    return path
end
