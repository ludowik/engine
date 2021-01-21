class('Tabs', UI)

function Tabs:init(label)
    UI.init(self, 'tabs'..label)

    self.buttons = UIScene(Layout.row)
    self.tabs = UIScene(Layout.topleft)

--    self:add(self.buttons)
--    self:add(self.tabs)

    self.buttons.parent = self
    self.tabs.parent = self

    self.layoutFlow = Layout.column
end

function Tabs:add(...)
    self:addTabs({...})
    return self
end

function Tabs:addTabs(tabs)
    for i=1,#tabs do
        local tab = tabs[i]
        if classnameof(tab) == 'tab' then
            local button = Button(tab.label)
            button.tab = tab
            button.click = function (button)
                self.currentTab.visible = false
                self.currentTab = button.tab
                button.tab.visible = true
            end

            self.buttons:add(button)
            self.tabs:add(tab)

            if self.currentTab == nil then
                self.currentTab = tab
                tab.visible = true
            else
                tab.visible = false
            end
        end
    end
    return self
end

function Tabs:draw()
    self.buttons:draw()
    if self.currentTab then
        self.currentTab:draw()
    end
end

function Tabs:inRect(position)
    local over = self.buttons:inRect(position)
    if over then
        return over
    end

    return self.currentTab:inRect(position)
end

class('Tab', UIScene)

function Tab:init(label)
    UIScene.init(self, label, Layout.column)
end
