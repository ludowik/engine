lfs = require 'lfs'

function getCurrentDirectory()
    return lfs.currentdir()
end

function getSaveDirectory()
    return "C:/Users/LMILHAU/AppData/Roaming/LOVE/GameEngine"
    --return lfs.currentdir()
end

function system.dir(path)
    return lfs.dir(path)
end

function system.isFileMode(path, mode)
    if not path then return false end
    return lfs.attributes(path, 'mode') == mode and true or false
end
