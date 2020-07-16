class 'Scene' : extends(Node)

function Scene:init()
    Node.init(self)
end

function Scene:draw()
    pushMatrix()
    do
        if self.camera then
            perspective()
            self.camera:setViewMatrix()    
            light(config.light)
            MeshAxes()
            depthMode(true)
            cullingMode(true)
            blendMode(NORMAL)
        end

        if self.parent == nil then
            if self.position then
                translate(self.position.x, self.position.y)
            end
        end

        Node.draw(self)

        if self.label ~= "" then
            UI.drawLabel(self)
        end
    end
    popMatrix()
end

function Scene:layout()
    if self.parent == nil then
        Node.computeNavigation(self, self, self)
    end
    
    if self.layoutFlow then
        if self.parent == nil then
            self.position:set()
            self.absolutePosition:set()
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
