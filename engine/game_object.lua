class 'GameObject'

function GameObject:init()
end

function GameObject:update(dt)
end

function GameObject:draw()
end

class 'Node' : extends(GameObject)

function Node:init()
    GameObject.init(self)
    self.nodes = Array()
end

function Node:len()
    return #self.nodes
end

function Node:add(object)
    self.nodes:add(object)
end

function Node:update(dt)
    for i,v in self.nodes:items() do
        v:update(dt)
    end
end

function Node:draw()
    if self.translate then
        translate(self.translate.x, self.translate.y)
    end
    
    for i,v in self.nodes:items() do
        v:draw()
    end
end

class 'Scene' : extends(Node)

function Scene:init()
    Node.init(self)
end
