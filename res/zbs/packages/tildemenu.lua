local G = ...
local menuid

local id = G.ID("tilde.tilde")
return {
    name = "Tilde plugin",
    description = "Allows to enter tilde (~) on keyboards that may not have it",
    author = "Paul Kulchenko",
    version = 0.1,

    onRegister = function(self)
        local menu = ide:GetMenuBar():GetMenu(ide:GetMenuBar():FindMenu(TR("&Edit")))
        menuid = menu:Append(id, "Tilde\tAlt-'")
        ide:GetMainFrame():Connect(id, wx.wxEVT_COMMAND_MENU_SELECTED,
            function ()
                ide:GetEditor():AddText("~")
            end)
    end,

    onUnRegister = function(self)
        local menu = ide:GetMenuBar():GetMenu(ide:GetMenuBar():FindMenu(TR("&Edit")))
        ide:GetMainFrame():Disconnect(id, wx.wxID_ANY, wx.wxEVT_COMMAND_MENU_SELECTED)
        if menuid then
            menu:Destroy(menuid)
        end
    end,
}
