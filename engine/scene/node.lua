class('Node', Object)

function Node:init(label)
    Object.init(self, label)
    self:clear()
end

function Node:clear()
    self.nodes = Array()
    return self
end

function Node:len()
    return #self.nodes
end

function Node:get(i)
    return self.nodes:get(i)
end

function Node:add(...)
    self:addItems{...}
    return self
end

function Node:addItems(items)
    for _,item in ipairs(items) do
        if item then
            table.insert(self.nodes, item)
            item.parent = self
        end
    end
    return self
end

function Node:remove(i)
    self.nodes:remove(i)
    return self
end

function Node:removeItem(item)
    self.nodes:removeItem(item)
end

function Node:iter()
    return ipairs(self.nodes)
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
    for i,node in self.nodes:items() do
        if node.draw then
            pushMatrix()
            do
                if node.position then
                    translate(node.position.x, node.position.y)
                    if node.drawMode == CENTER then
                        translate(node.size.x/2, node.size.y/2, node.size.z/2)
                    end
                end

                if node.translation then
                    translate(node.translation.x, node.translation.y, node.translation.z)
                end

                if node.scaling then
                    scale(node.scaling.x, node.scaling.y, node.scaling.z)
                end

                if node.angle and node.angle ~= 0 then
                    rotate(node.angle)
                end

                if node.rotation then
                    rotate(node.rotation.y, 1, 0, 0)
                    rotate(node.rotation.x, 0, 1, 0)
                end

                if node.drawMode == CENTER then
                    translate(-node.size.x/2, -node.size.y/2)
                end

                node:draw()

                if node.body and env.physics.debug then
                    node.body:draw(dt)
                end
            end
            popMatrix()
        end
    end

    strokeWidth(1)
    if self.hasFocus then
        stroke(red)
    else
        stroke(51)
    end

    noFill()

    rectMode(CORNER)
    rect(0, 0, self.size.x, self.size.y)
end

function Node:nextFocus()
    self:setFocus(self.focus and self.focus.next or self)
end

function Node:previousFocus()
    self:setFocus(self.focus and self.focus.previous or self)
end

function Node:setFocus(newFocus)
    if self.focus then
        self.focus.hasFocus = false
    end
    if newFocus then
        newFocus.hasFocus = true
    end
    self.focus = newFocus
end

function Node:getFocus()
    if self.focus then return self end
    for i,v in ipairs(self.nodes) do
        if v.getFocus then
            local who = v:getFocus()
            if who then
                return who
            end
        end
    end
end

function Node:keyboard(key, isrepeat)
    local who = self:getFocus()
    if who and who.keypressed then
        who:keyboard(key, isrepeat)
    end
end

function Node:touched(touch)
    for i=1,#self.nodes do
        local node = self.nodes[i]
        if node and node.touched and node:contains(touch) then
            node:touched(touch)
            return true
            --            local res = node:touched(touch)
            --            if res then
            --                return res
            --            end
        end
    end
end

function Node:wheelmoved(mouse)
    local who = self:contains(mouse)
    if who and who.wheelmoved then
        return who:wheelmoved(mouse)
    end
end

function Node:setLayoutFlow(layoutFlow, layoutParam)
    self.layoutFlow = layoutFlow
    self.layoutParam = layoutParam
    return self
end

function Node:setAlignment(alignment)
    self.alignment = alignment
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

function Node:root()
    local current = self
    while current.parent do
        current = current.parent
    end
    return current
end

function Node:contains(...)
    if self.visible == false then return end

    for i,v in ipairs(self.nodes) do
        if v.visible ~= false and v.contains then
            local res = v:contains(...)
            if res then
                return v
            end
        end
    end
end

function Node:ui(label, level)
    level = level or 0
    for i=1,#self.nodes do
        local node = self.nodes[i]
        if node.label == label then
            return node
        end
        if node.ui then
            local subView = node:ui(label, level+1)
            if subView then
                return subView
            end
        end
    end
end

function Node:computeNavigation(previousUpNode, nextUpNode)
    previousUpNode.next = self.nodes[1]
    nextUpNode.previous = self.nodes[#self.nodes]

    for i=1,#self.nodes do
        local currentNode = self.nodes[i]
        local nextNode = self.nodes[i+1] or nextUpNode

        currentNode.previous, previousUpNode = previousUpNode, currentNode

        if currentNode.nodes and #currentNode.nodes > 0 then
            currentNode:computeNavigation(currentNode, nextNode)
        else
            currentNode.next = nextNode
        end
    end
end
