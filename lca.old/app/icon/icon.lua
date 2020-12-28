App('Icon')

ICON_SIZE = 44

function Icon:init()
    Application.init(self)

    self:load('quit')

    self.position = vector(100, 100)

    self.ratio = 3
    self.pixelSize = 4    
    self.color = white

    ui = Node()

    menu = MenuBar()
    menu:add(Button('reset', function (btn) self:reset() end))

    local function load(btn)
        self:load(btn.id)
    end
    menu:add(Button('quit', load))
    menu:add(Button('restart', load))
    menu:add(Button('menu', load))
    menu:add(Button('next', load))
    menu:add(Button('previous', load))
    menu:add(Button('play', load))

    palette = ToolBar(0, ICON_SIZE)
    for i = 0,8 do
        palette:add(ButtonColor(color(i/8), function (btn)
                    self:setColor(btn.color)
                end))
    end

    ui:add(menu, palette)
end

function Icon:reset()
    self.icon = image(ICON_SIZE*2, ICON_SIZE*2)

    setContext(self.icon)    
    do
        background(self.color)
    end
    setContext()

    self:save()
end

function Icon:setColor(color)
    self.color = color
end

function Icon:load(iconName)
    self.iconName = iconName
    self.icon = image(self.iconName, ICON_SIZE*2, ICON_SIZE*2)
end

function Icon:save()
    self.icon:save(self.iconName)
end

function Icon:draw()
    background(51)

    ui:layout()
    ui:draw()

    spriteMode(CORNER)
    sprite(self.icon, self.position.x, self.position.y + self.icon.height, ICON_SIZE, ICON_SIZE)

    local w = self.icon.width * self.ratio
    local h = self.icon.height * self.ratio

    local x = self.position.x
    local y = HEIGHT - self.position.y - h

    sprite(self.icon, x, y, w, h)

    stroke(red)
    noFill()
    
    rectMode(CORNER)
    rect(x, y, w, h)
end

function Icon:touched(touch)
    ui:touched(touch)

    local h = self.icon.height * self.ratio
    local y = HEIGHT - self.position.y - h
    touch.x = touch.x - self.position.x
    touch.y = touch.y - y
    touch = touch / self.ratio

    local i, j
    i = math.floor(touch.x / self.pixelSize) * self.pixelSize
    j = math.floor(touch.y / self.pixelSize) * self.pixelSize

    setContext(self.icon)    
    do
        noStroke()
        fill(self.color)
        
        rectMode(CORNER)
        rect(i, j, self.pixelSize, self.pixelSize)
    end
    setContext()

    self:save()
end
