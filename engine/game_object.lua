GameObject = Component

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

function Node:remove(i)
    self.nodes:remove(i)
end

function Node:setup()
    for i,v in self.nodes:items() do
        if v.setup then
            v:setup()
        end
    end
end

function Node:release()
    for i,v in self.nodes:items(true) do
        if v.release then
            v:release()
        end
    end
end

function Node:update(dt)
    for i,v in self.nodes:items() do
        if v.update then
            v:update(dt)
        end
    end
end

function Node:draw()
    if self.translate then
        translate(self.translate.x, self.translate.y)
    end

    for i,v in self.nodes:items() do
        if v.draw then
            v:draw()
        end
    end
end

class 'Scene' : extends(Node)

function Scene:init()
    Node.init(self)
end
