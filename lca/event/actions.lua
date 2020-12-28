class('keyboardActions').setup = function ()
    Keyboard.on('escape', lca.quit)

    Keyboard.on('f', function ()
            config.frameSync = not config.frameSync
            if config.frameSync then
                config.framerate = 60
            end
        end)

    Keyboard.on('r', function ()
            lca.loadApp(lca.apps:current())
        end)

    Keyboard.on('s', function ()
            lca.loadApp(lca.apps:first('apps/sandbox'))
        end)

    Keyboard.on('c', function ()
            stopLoop()
            lca.loadApp(lca.apps:first('apps/appManager'))
        end)

    Keyboard.on('b', function()
            lca.loadApp(lca.apps:previous())
        end)

    Keyboard.on('n', function()
            lca.loadApp(lca.apps:next())
        end)

    function stopLoop()
        Timer.stop('loop')
        looping = false
    end

    function loop(appPath)
        if appPath then
            lca.startAppPath = appPath
            lca.nextAppPath = lca.apps:next()
        end

        looping = true

        Timer.add('loop', config.delayBeforeLoop, function ()
                lca.nextAppPath = lca.apps:next()
                if lca.nextAppPath == lca.startAppPath then
                    lca.quit()
                end
            end)
    end

    Keyboard.on('v', function()
            if Timer.find('loop') then 
                stopLoop()
            else
                loop(config.appPath)
            end
        end)

    Keyboard.on('h', function()
            config.highDPI = not config.highDPI
            system.restartMode = 'restart'
            lca.quit('restart')
        end)

    Keyboard.on('g', function()
            collectgarbage('collect')
        end)

    Keyboard.on('l', function()
            if config.lightMode == 'on' then
                config.lightMode = 'off'
            else
                config.lightMode = 'on'
            end
        end)

    Keyboard.on('f1', function()
            if env.app then
                if env.app.help then
                    env.app:help()
                end
            end

        end)

    Keyboard.on(',', function()
            classes:reset()

            if not Profiler.running then
                Profiler.init()
                Profiler.start()
            else
                Profiler.stop()
            end
        end)

    Keyboard.on('d', function()
            Profiler.detail = not Profiler.detail
            physics.debug = Profiler.detail
        end)

    Keyboard.on('p', function()
            if config.projectionMode == 'perspective' then
                config.projectionMode = 'ortho'
            else
                config.projectionMode = 'perspective'
            end
        end)

    Keyboard.on('w', function ()
            config.wireframe = Wireframe:next(config.wireframe)
        end)

    Keyboard.on('tab', function ()
            if app then
                app.scene:nextFocus()
            end
        end)

    Keyboard.on('f11', function()
            if osx then
                os.execute('open -n -a love '..getSourcePath())
            elseif windows then
                local command = 'cmd /c ""C:/Program Files (x86)/LOVE/love.exe" "'..getSourcePath()..'""'
                os.execute(command)
            end
        end)

    Keyboard.on(KEY_FOR_ACCELEROMETER, function(_, _, isrepeat)
            if not isrepeat then
                Gravity = vec3(0, -9.8, 0)
            end
        end)

    Keyboard.onrelease(KEY_FOR_ACCELEROMETER, function()
            Gravity = vec3(0, -9.8, 0)
        end)
end
