class('Node', Object)

function Node:init()
    Object.init(self)
    self:clear()
end

function Node:clear()
    self.nodes = Table()
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
end

function Node:removeItem(item)
    self.nodes:removeItem(item)
end

function Node:update(dt)
    table.call(self.nodes, 'update', dt)
end

function Node:draw()
    local node
    for i=1,#self.nodes do
        node = self.nodes[i]
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
            end
            popMatrix()
        end
    end

    strokeWidth(1)
    if self.hasFocus then
        stroke(red)
    else
        stroke(white)
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

function Node:touched(touch)
    for i=1,#self.nodes do
        local node = self.nodes[i]
        if node and node.touched and node:contains(touch) then
            -- TODO : renvoyer systématiquement true
            local res = node:touched(touch)
            return true
            --            if res then
            --                return res
            --            end
        end
    end
end

function Node:wheelmoved(...)
    local who = self:contains(CurrentTouch)
    if who and who.wheelmoved then
        who:wheelmoved(...)
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

function Node:root()
    local current = self
    while current.parent do
        current = current.parent
    end
    return current
end

-- TODO : à tester
function Node:contains(...)
    if self.visible == false  then return end
    for i,v in ipairs(self.nodes) do
        if v.visible ~= false and v.contains then
            local who = v:contains(...)
            if who then
                return who
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

function Node:keyboard(key)
    local who = self:getFocus()
    if who and who.keypressed then
        who:keyboard(key)
    end
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
