class 'config'

function loadConfig()
    config.glMajorVersion = readGlobalData('glMajorVersion', 4)
    config.glMinorVersion = readGlobalData('glMinorVersion', 1)
end

function saveConfig()
    saveGlobalData('majorVersion', config.glMajorVersion)
    saveGlobalData('minorVersion', config.glMinorVersion)
end
