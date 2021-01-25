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

        if self.parent == nil then
            Layout.computeAbsolutePosition(self)
            Layout.reverse(self)
        end
    end
end

function Scene:draw()
    pushMatrix()
    do
        if self.parent == nil then
            local camera = self.camera
            if camera then
                perspective()

                camera:setViewMatrix()

                light(true)

                MeshAxes()

                blendMode(NORMAL)
                depthMode(true)
                cullingMode(true)
            end

            if self.position then
                translate(self.position.x, self.position.y)
            end

            if self.bgColor then
                background(self.bgColor)
            end
        end

        Node.draw(self)
--        Node.drawAbsolutePosition(self)
    end
    popMatrix()
end
