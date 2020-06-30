
class 'UI' : extends(Node)

function UI:layout()
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

class 'CheckBox' : extends(UI)

class 'ColorPicker' : extends(UI)

class 'Editor' : extends(UI)

class 'UIScene' : extends(Scene)

function UIScene:setLayoutFlow()
end

function UIScene:clear()
end

Layout = {
    'row'
}

class 'Dashboard'
