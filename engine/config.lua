function loadConfig()
    gl.majorVersion = readGlobalData('majorVersion', 2)
    engine.appName = readGlobalData('appName', 'dots')
end

function saveConfig()
    saveGlobalData('majorVersion', gl.majorVersion)
    saveGlobalData('appName', engine.appName)
end
