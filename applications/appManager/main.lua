function setup()
    initMenu('applications')
end

function initUI()
    app.previousUI = app.ui
    
    app.ui = UIScene(Layout.grid, 4)
    app.ui.alignment = 'h-center,v-center'
end

function initMenu(path)
    initUI()

    if app.currentPath then
        app.previousPath = app.currentPath

        app.ui:add(
            Button('..',
                function (btn)
                    app.ui = app.previousUI
                end))

    end

    app.currentPath = path

    local apps = applicationManager:dirApps(path) -- + applicationManager:dirFiles(path)
    for i,appPath in ipairs(apps) do
        local appDirectory, appName = splitPath(appPath)
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

function keyboard(key)
    if key == 'a' then
        if app.previousUI then
            app.ui = app.previousUI
            return true
        end
    end
end