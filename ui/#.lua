
class 'UI' : extends(Node)

function UI:init()
    Node.init(self)
    
    self.position = vec2()
    self.size = vec2()    
end

function UI:layout()
    return self
end

function UI:bind()
    return self
end

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
class 'Expression' : extends(UI, Scene)

function UIScene:setLayoutFlow()
    return self
end

function UIScene:clear()
    return self
end

Layout = {
    'row',
    innerMarge = 2
}

class 'Dashboard'

class 'Joystick'

function Joystick:getForce()
    return 0
end
