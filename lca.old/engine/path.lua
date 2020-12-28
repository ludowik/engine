function validatePath(path)
    if not isDirectory(path) then
        fs.createDirectory(path)
    end
    return path
end

function getDataPath()
    local dataPath = ''
    dataPath = dataPath..'data'
    return validatePath(dataPath)
end

function getImagePath()
    return validatePath('res/images')
end

function getModelPath()
    return validatePath('res/models')
end
