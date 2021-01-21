function setup()
    local tabs = Tabs('boîte à onglet')
    app.ui:add(tabs)

    for i,v in ipairs(__classes) do
        local tab = Tab(classnameof(v))
        tabs:addTab(tab)
        for k,v in pairs(v) do
            tab:add(Label(k))
        end
    end
end

function update(dt)
end
