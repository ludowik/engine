class 'Scene' : extends(Node)

function Scene:init(label)
    Node.init(self, label)
end

function Scene:layout()
    if self.parent == nil then
        Node.computeNavigation(self, self, self)
    end

    if self.layoutFlow then
        if self.parent == nil then
            self.position:set(0, 0, 0)
            self.absolutePosition:set(0, 0, 0)
        end

        Node.layout(self)

        if self.alignment then
            Layout.align(self)
        end

        Layout.computeAbsolutePosition(self)

        if self.parent == nil then
            Layout.reverse(self)
        end
    end
end

function Scene:draw()
    pushMatrix()
    do
        local camera = self.camera
        if camera then
            perspective()

            camera:setViewMatrix()

            light(config.light)

            MeshAxes()

            blendMode(NORMAL)
            depthMode(true)
            cullingMode(true)
        end

        if self.parent == nil then
            if self.position then
                translate(self.position.x, self.position.y)
            end
        end

        Node.draw(self)
    end
    popMatrix()
end
