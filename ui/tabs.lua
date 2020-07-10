class('Tabs', UI)

function Tabs:init()
    UI.init(self, 'tabs')

    self.buttons = UIScene():attribs{layoutFlow='row'}
    self.tabs = UIScene():attribs{layoutFlow='topleft'}

    self:add(self.buttons)
    self:add(self.tabs)

    self.layoutProc = Layout.column
end

function Tabs:add(...)
    self:addTabs({...})
    return self
end

function Tabs:addTabs(tabs)
    for i=1,#tabs do
        local tab = tabs[i]
        if typeOf(tab) == 'UITab' then
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
        else
            UIScene.add(self, tab)
        end
    end
    return self
end

function Tabs:_draw()
    self:layout()

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
    UIScene:init(self, label)
end
