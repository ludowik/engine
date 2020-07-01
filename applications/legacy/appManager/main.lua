function setup()
    app.ui = UIScene(Layout.grid, 2)
    app.ui.alignment = 'h-center,v-center'

    app.index = 0

    initMenu()
end

function initMenu(path)
    app.ui:clear()

    if path then
        app.ui:add(Button('..', function (btn) initMenu() end))
    end

    local apps = engine:dirApps()
    for i,appPath in ipairs(apps) do
        local j = appPath:findLast('/')
        local appName = j and appPath:sub(j+1) or appPath

        if not isApp(appPath) then
            app.ui:add(Button(appName, function (btn)
                        initMenu(appPath)
                    end):attribs{bgColor = brown})

        else
            app.ui:add(Button(appName, function (btn)
                        lca.loadApp(lca.apps:first(appPath))
                    end))
        end
    end
end

function touched(touch)
    app.ui:touched(touch)
end
