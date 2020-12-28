class('Scene', Node)

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
    if self.layoutFlow then
        if self.parent == nil then
            self.position:init()
            self.absolutePosition:init()

            Node.computeNavigation(self, self, self)
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
