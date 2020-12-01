function setup()
    initMenu('applications')
end

function initUI()
    app.ui = UIScene(Layout.grid, 4)
    app.ui.alignment = 'h-center,v-center'
end

function initMenu(path)
    if app.currentPath then
        local ui = app.ui

        initUI()
        app.ui:add(
            Button('..',
                function (btn)
                    app.ui = ui
                end))
    else
        initUI()
    end

    app.currentPath = path

    local apps = applicationManager:dirApps(path) + applicationManager:dirFiles(path)
    for i,appPath in ipairs(apps) do
        local appName, appDirectory = splitPath(appPath)
        app.ui:add(
            Button(appName,
                function (btn)
                    applicationManager:loadApp(appPath)
                end)
            :attribs{bgColor = rgb(0, 123, 255)})
    end

    local directories = applicationManager:dirDirectories(path)
    for i,appPath in ipairs(directories) do
        if not isApp(appPath) then
            local j = appPath:findLast('/')
            local appName = j and appPath:sub(j+1) or appPath
            app.ui:add(
                Button(appName,
                    function (btn)
                        initMenu(appPath)
                    end)
                :attribs{bgColor = rgb(125, 40, 85)})
        end
    end
end

function touched(touch)
    return app.ui:touched(touch)
end
