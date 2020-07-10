-- TODO

Keyboard.on('tab', function ()
        if app then
            app.scene:nextFocus()
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
