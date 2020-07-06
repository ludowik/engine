requireLib(
    'ui',
    'layout')

class 'Bar' : extends(UI)

function Bar:action()
    return self
end

function Bar:number()
    return self
end

class 'ToolBar' : extends(Bar)
class 'MenuBar' : extends(Bar)

class 'Label' : extends(UI)

class 'Button' : extends(UI)
class 'ButtonImage' : extends(UI)
class 'ButtonColor' : extends(UI)
class 'ButtonIconFont' : extends(UI)

class 'CheckBox' : extends(UI)

class 'ColorPicker' : extends(UI)

class 'Editor' : extends(UI)

class 'UITimer' : extends(UI)

class 'UIScene' : extends(UI, Scene)

function UIScene:setLayoutFlow(layoutFlow)
    self.layoutFlow = layoutFlow
    return self
end

function UIScene:setGridSize()
    return self
end

function UIScene:clear()
    return self
end

Layout = {
    'row',
    innerMarge = 2
}

class 'Expression' : extends(UI)

class 'Dashboard'

class 'Joystick'

function Joystick:getForce()
    return 0
end
