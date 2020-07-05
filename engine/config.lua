class 'config'

function loadConfig()
    config.glMajorVersion = readGlobalData('glMajorVersion', 4)
    config.glMinorVersion = readGlobalData('glMinorVersion', 1)
    
    engine.renderMode = readGlobalData('renderMode', 'frame')
end

function saveConfig()
    saveGlobalData('majorVersion', config.glMajorVersion)
    saveGlobalData('minorVersion', config.glMinorVersion)
    
    saveGlobalData('renderMode', engine.renderMode)
end
