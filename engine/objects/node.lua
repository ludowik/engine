class 'Node' : extends(Object, Rect)

function Node:init()
    Object.init(self)
    Rect.init(self)
    
    self.nodes = Array()
end

function Node:len()
    return #self.nodes
end

function Node:add(object)
    self.nodes:add(object)
    return self
end

function Node:remove(i)
    self.nodes:remove(i)
    return self
end

function Node:clear()
    self.nodes = Array()
    return self
end

function Node:initialize()
    for i,v in self.nodes:items() do
        if v.initialize then
            v:initialize()
        end
    end
    return self
end

function Node:release()
    for i,v in self.nodes:items(true) do
        if v.release then
            v:release()
        end
    end
    return self
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

function Node:setLayoutFlow(layoutFlow, layoutParam)
    self.layoutFlow = layoutFlow
    self.layoutParam = layoutParam
    return self
end

function Node:layout()
    if self.layoutFlow then
        self.layoutFlow(self, self.layoutParam)
    end
end

function Node:computeSize()
    self:layout()
end
