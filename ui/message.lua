class('Message', Application)

function Message:init()
    Application.init(self)
    menu = MenuBar()
    menu:add(Button('ok', function (btn) popApp() end))
end

function Message:draw()
    background(51)
    menu:draw()
end

function Message:touched(touch)
    menu:touched(touch)
end
