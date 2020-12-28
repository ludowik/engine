function setup()
    app.menu = UIScene(Layout.grid, 2)
    app.menu.alignment = 'h-center,v-center'

    app.scene = app.menu
    
    initMenu()
    
    parameter.watch('OS', 'getOS()')
    parameter.watch('Power Info', 'system.getPowerInfo()')
    
    parameter.watch('WIDTH', WIDTH)
    parameter.watch('HEIGHT', HEIGHT)
end

function initMenu(path)
    app.menu:clear()

    if path then
        app.menu:add(Button('..', function (btn) initMenu() end))
    end

    local apps = listApp(path)
    for i,appPath in ipairs(apps) do
        local appName = appPath:sub(appPath:findLast('/')+1)

        if not isApp(appPath) then
            app.menu:add(Button(appName, function (btn)
                        initMenu(appPath)
                    end):attribs{bgColor = brown})
            
        else
            app.menu:add(Button(appName, function (btn)
                        setApp(appPath)
                    end))
        end
    end
end

function touched(touch)
    app.menu:touched(touch)
end
