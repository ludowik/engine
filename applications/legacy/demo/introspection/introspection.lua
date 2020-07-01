function setup()
    initUI()
end

function initUI()
    app.ui:setLayoutFlow(Layout.row)

    function addGroup(filterType)
        local group = UIScene(Layout.column)
        app.ui:add(group)
        local typeFilter = 'number'
        for k,v in pairs(_G) do
            if typeof(v) == filterType then
                if tostring(k):lower() ~= tostring(v):lower() then
                    group:add(
                        Label(k),
                        Label(tostring(v)))
                end
            end
        end
    end

    addGroup('boolean')
    addGroup('number')
    addGroup('string')
    addGroup('table')
    addGroup('function')
end

function update(dt)
end

