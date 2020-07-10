
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

class 'UI' : extends(Node)

function UI:init()
    Node.init(self)
    
    self.position = vec2()
    self.size = vec2()    
end

function UI:bind()
    return self
end

function UI:touched(touch)
end
