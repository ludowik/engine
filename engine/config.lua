class 'config'

function loadConfig()
    config.glMajorVersion = readGlobalData('glMajorVersion', ios and 3 or 4)
    config.glMinorVersion = readGlobalData('glMinorVersion', ios and 0 or 1)
end

function saveConfig()
    saveGlobalData('majorVersion', config.glMajorVersion)
    saveGlobalData('minorVersion', config.glMinorVersion)
end
