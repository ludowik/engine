Class('UITabs', UIScene)

function UITabs:UITabs()
    self:UIScene('tabs')

    self.buttons = UIScene():attribs{layoutFlow='row'}
    self.tabs = UIScene():attribs{layoutFlow='topleft'}

    self:add(self.buttons)
    self:add(self.tabs)

    self.layoutProc = Layout.column
end

function UITabs:add(...)
    self:addTabs({...})
    return self
end

function UITabs:addTabs(tabs)
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

function UITabs:_draw()
    self:layout()

    self.buttons:draw()
    if self.currentTab then
        self.currentTab:draw()
    end
end

function UITabs:inRect(position)
    local over = self.buttons:inRect(position)
    if over then
        return over
    end

    return self.currentTab:inRect(position)
end

Class('UITab', UIScene)

function UITab:UITab(label)
    self:UIScene(label)
end
