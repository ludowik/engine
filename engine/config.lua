function loadConfig()
    gl.majorVersion = readGlobalData('majorVersion', 4)
    gl.minorVersion = readGlobalData('minorVersion', 1)
    
    engine.appName = readGlobalData('appName', 'default')
    
    engine.renderMode = readGlobalData('renderMode', 'frame')
end

function saveConfig()
    saveGlobalData('majorVersion', gl.majorVersion)
    saveGlobalData('minorVersion', gl.minorVersion)
    
    saveGlobalData('appName', engine.appName)
    
    saveGlobalData('renderMode', engine.renderMode)
end

class 'config'
