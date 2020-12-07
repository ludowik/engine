class('Dialog', UIScene)

function Dialog:init(label)
    UIScene.init(self)

--    self.label = label

    self.bar = UIScene()
    self.scene = UIScene()

    self:add(self.bar, self.scene)

    self.bar:add(
        Label(label),
        Button('OK', function ()
                local app = self.app or env.app
                app:popScene()
            end))

    self.position = vec3(screen.W/2, screen.H/2)

    self.alignment = 'v-center,h-center'

    self.bgColor = brown
end

function Dialog:draw()
    resetMatrix()

    noStroke()

    fill(self:getBgColor())

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

    self.scene.list = UIScene()
    self.scene:add(self.scene.list)

    table.forEach(list,
        function (item, k)
            local label
            if type(item) == 'table' then
                label = item.label or item.name or item
            else
                label = item
            end

            self.scene.list:add(
                Button(label,
                    function ()
                        onChoice(k, item)
                    end))
        end)
end
