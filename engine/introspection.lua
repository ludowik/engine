function Engine:introspection()
    local env = _G.env
    local app = _G.env.app

    app.ui:setLayoutFlow(Layout.row)

    function addGroup(filterType)
        local group = app.ui:ui(filterType)
        if group == nil then
            group = UIScene(filterType, Layout.column)
            app.ui:add(group)
        else
            group:clear()
        end

        local typeFilter = 'number'
        
        local function addRef(k, v)
            if type(v) == filterType then
                if tostring(k):lower() ~= tostring(v):lower() then -- exclude macro
                    local ui = Expression("'"..k.." = '..tostring("..k..")")
                    ui.fontSize = 8
                    group:add(ui)
                end
            end
        end
        
        for k,v in pairs(env) do
            addRef(k, v)
        end
        
        for i,v in ipairs(env) do
            addRef(tostring(i), v)
        end
    end

    addGroup('boolean')
    addGroup('number')
    addGroup('string')
    addGroup('table')
    addGroup('function')
end
