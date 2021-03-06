class('ComboBox', UI)

function ComboBox:ComboBox(label)
    UI.init(self, label)

    self.uiValue = UIValue(label)
    self:add(self.uiValue:attribs{
            backgroundColor = blue * 2,
            click = function (_, ...) self.click(self, ...) end
        })

    self.uiList = UI('select a value')
    self.uiList.visible = false

    self:add(self.uiList)
end

function ComboBox:list(values, i)
    self.values = values

    local value
    if i then
        value = values[i]
    else
        value = self:getValue()
    end

    if value == nil then
        value = values[1]
    end

    self.uiValue:bind(self, 'value', value)

    if self.bind and values and i then
        self:setValue(values[i])
    end

    return self
end

function ComboBox:click()
    if self.uiList.visible then
        self.uiList.visible = false
    else
        self.uiList.visible = true

        self.uiList:clear()

        for i,value in ipairs(self.values) do
            self.uiList:add(Label(value):attribs{
                    click = function(ui)
                        self.uiList.visible = true

                        self:setValue(value)
                        self:onSelectItem(i, value)
                    end})
        end
    end
end

function ComboBox:onSelectItem(i, value)
end
