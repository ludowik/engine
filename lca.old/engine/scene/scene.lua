class('Scene', Node)

function Scene:init()
    Node.init(self)
end

function Scene:draw()
    if self.camera then
        perspective()

        self.camera:setViewMatrix()

        light(config.light)

        MeshAxes()
    end

    Node.draw(self)
end

class('UIScene', Scene)

function UIScene:init(layout, n)
    Scene.init(self)

    self.layoutProc = layout or Layout.row
    self.layoutParam = n
    self.layoutPosition = vector(0, HEIGHT)

    self.verticalDirection = 'down'

    self.position = vector(0, HEIGHT)
end

function UIGroup()
    todo('replace')
    return MenuBar()
end
