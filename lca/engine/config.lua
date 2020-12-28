class('Config')

-- TODO : écrire le fichier config au même endroit dans les 2 modes

function Config.setup()
end

function Config.load()
    config = table.load(getConfigPath()..'/'..'config') or {}

    config.fullScreen = value(config.fullScreen, false)

    config.highDPI = value(config.highDPI, false)

    config.frameSync = false
    config.framerate = config.framerate or 60

    config.frameBeforeLoop = 1
    config.delayBeforeLoop = config.frameBeforeLoop/60

    config.lightMode = 'on'

    config.wireframe = 'fill'

    config.volume = 0.05

    config.drawInfo = true
    
    config.forceCompilation = false
    config.noOptimization = true
end

function Config.save()
    table.save(config, getConfigPath()..'/'..'config')
end

Config.load()
