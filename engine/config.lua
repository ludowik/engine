function loadConfig()
    gl.majorVersion = readGlobalData('majorVersion', 4)
    gl.minorVersion = readGlobalData('minorVersion', 1)
    
    engine.appName = readGlobalData('appName', 'default')
end

function saveConfig()
    saveGlobalData('majorVersion', gl.majorVersion)
    saveGlobalData('minorVersion', gl.minorVersion)
    
    saveGlobalData('appName', engine.appName)
end

class 'config'
