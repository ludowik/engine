class('Dialog', UIScene)

function Dialog:init(label)
    UIScene.init(self)
    
    self.label = label
    
    self.bar = UIScene()
    self.dialog = UIScene()

    self:add(self.bar)
    self:add(self.dialog)

    self.bar:addItems{
        Label(label),
        Button('OK', function ()
                local app = self.app or app
                app:popScene()
            end)
    }

    self.position = vec3(WIDTH/2, HEIGHT/2)
    
    self.alignment = 'v-center,h-center'
end

function Dialog:draw()
    resetMatrix()

    noStroke()
    
    fill(red)    
    
    rectMode(CORNER)
    rect(
        self.absolutePosition.x,
        self.absolutePosition.y,
        self.size.x,
        self.size.y)

    UIScene.draw(self)
end

function Dialog:touchedMoving(touch)
    self.position.x = self.position.x + touch.deltaX
    self.position.y = self.position.y + touch.deltaY
end

-- choice list
class('ChoiceList', Dialog)

function ChoiceList:init(label, list, onChoice)
    Dialog.init(self, label)
    
    self.dialog.list = UIScene()
    self.dialog:add(self.dialog.list)

    table.forEach(list,
        function (item, k)
            local label
            if type(item) == 'table' then
                label = item.label or item.name or item
            else
                label = item
            end

            self.dialog.list:add(
                Button(label,
                    function ()
                        onChoice(k, item)
                    end))
        end)    
end

class('ColorPicker', Dialog)

function ColorPicker:init(label, clr)
    Dialog.init(self, label)
    
    self.dialog:add(ColorPicker(clr))
end
