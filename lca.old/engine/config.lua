function initConfig()
    config = table.load(getDataPath()..'/'..'#config') or {}
    
    local defaultValues = {
        screen = 'portrait',
        
        screenScale = 1,
        appScale = 1,
        
        framerate = 60,
        manageFramerate = true,        
        
        light = true,        
        wireFrame = false,

        logMode = true
    }
    for k,v in pairs(defaultValues) do
        config[k] = value(config[k], v)
    end
    
    local forcedValues = {
    }
    for k,v in pairs(forcedValues) do
        config[k] = v
    end
end
