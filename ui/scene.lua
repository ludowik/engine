class('UIScene', Scene, UI)

function UIScene:init(...)
    local label, layoutFlow, varargs = args(...):get(
        {'string', ''},
        {'function', Layout.column})

    --UI.init(self, label)
    Scene.init(self, label)

    self:setLayoutFlow(layoutFlow, unpack(varargs))
end
