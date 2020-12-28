class('Node', Table, UI)


-- TODEL
--function Node:__newindex(key, val)
--    if type(key) == 'number' then
--        self.nodes[key] = val
--    else
--        return rawset(self, key, val)
--    end
--end

--function Node:__index(key)
--    if type(key) == 'number' then
--        return self.nodes[key]
--    else
--        return rawget(getmetatable(self), key)
--    end
--end

function Node:init()
    Table.init(self)
    UI.init(self)
    self.nodes = Table()
end

function Node:get(i)
    return self.nodes[i]
end

function Node:set(i, val)
    self.nodes[i] = val
end

function Node:clear(value)
    self:destroy()
    Table.clear(self.nodes, value)
end

function Node:remove(i)
    self.nodes:remove(i)
end

function Node:addItem(item)
    Table.addItem(self.nodes, item)
    item.parent = self

    if self.textSize then
        item.textSize = self.textSize
    end
end

function Node:forEachKey(f)
    return table.forEachKey(self.nodes, f)
end

function Node:forEach(f)
    return table.forEach(self.nodes, f)
end

function Node:update(dt)
    for i,v in ipairs(self.nodes) do
        v:update(dt)
    end
end

function Node:drawNode(v)
    v = v or self
    if v.visible == false then return end

    pushMatrix()

    if v.position then
        translate(v.position.x, v.position.y, v.position.z)
        if v.drawMode == CENTER then
            translate(v.size.x/2, v.size.y/2, v.size.z/2)
        end
    end

    if v.translation then
        translate(v.translation.x, v.translation.y, v.translation.z)
    end

    if v.scaling then
        scale(v.scaling.x, v.scaling.y, v.scaling.z)
    end

    if v.angle and v.angle ~= 0 then
        rotate(v.angle)
    end

    if v.rotation then
        rotate(v.rotation.y, 1, 0, 0)
        rotate(v.rotation.x, 0, 1, 0)
    end

    if v.drawMode == CENTER then
        translate(-v.size.x/2, -v.size.y/2)
    end

    if v.nodes then
        v:drawNodes()
        if self.camera == nil then -- 2D
            v:drawBorder()
        end
    else
        v:draw()
    end

    if v.focus then
        v:drawBorder(red)
    end

    popMatrix()
end

function Node:drawNodes()
    for i,v in ipairs(self.nodes) do
        self:drawNode(v)
    end
end

function Node:draw()
    self:drawNode()
end

function Node:computeSize()
    if self.layoutProc then
        self:layout(self.position.x, self.position.y)
    end
end

function Node:setLayoutFlow(proc, param)
    assert(proc)

    self.layoutProc = proc
    self.layoutParam = param

    return self
end

function Node:layout(x, y)
    if self.layoutProc == nil then return self end

    x = x or self.layoutPosition.x
    y = y or self.layoutPosition.y

    self:layoutProc(x, y, self.layoutParam)

    if self.alignment then
        Layout.alignment(self)
    end

    if self.verticalDirection == 'down' then
        Layout.reverse(self)
    end

    Layout.computeAbsolutePosition(self)

    return self
end

function Node:destroy()
    for i,v in ipairs(self.nodes) do
        if v.destroy then
            v:destroy()
        end
    end
end

function Node:root()
    local current = self
    while current.parent do
        current = current.parent
    end
    return current
end

function Node:touched(touch)
    local who = self:contains(touch)
    if who then
        if self:touchedAction(touch, who) then
            return true
        end
    end
    if self:touchedAction(touch, self) then
        return true
    end
end

function Node:touchedAction(touch, who)    
    if touch.state == BEGAN then
        if who and who.touchedBegan then
            who:touchedBegan(touch)
            return true
        end

    elseif touch.state == MOVING then
        if who and who.touchedMoving then
            who:touchedMoving(touch)
            return true
        end

    elseif touch.state == ENDED then
        if touch.prevState == BEGAN and who and who.touchedClick then
            who:touchedClick(touch)
            return true
        elseif who and who.touchedEnded then
            who:touchedEnded(touch)
            return true
        elseif who and who.touched and who ~= self and who ~= app then
            who:touched(touch)
            return true
        end
    end
end

function Node:wheelmoved(...)
    local who = self:contains(CurrentTouch)
    if who and who.wheelmoved then
        who:wheelmoved(...)
    end
end

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

function Node:keypressed(key)
    local who = self:getFocus()
    if who and who.keypressed then
        who:keypressed(key)
    end
end

function Node:keyreleased(key)
    local who = self:getFocus()
    if who and who.keyreleased then
        who:keyreleased(key)
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

function Node:normalize(norm)
    norm = norm or 1
end

function Node:center()
end

function Node:setColors(...)
    for i=1,#self.nodes do
        local node = self.nodes[i]
        if node.setColors then
            node:setColors(...)
        end
    end
end

function Node:setTexture(...)
    for i=1,#self.nodes do
        local node = self.nodes[i]
        if node.setTexture then
            node:setTexture(...)
        end
    end
end

function Node:computeNormals(...)
    for i=1,#self.nodes do
        local node = self.nodes[i]
        if node.computeNormals then
            node:computeNormals(...)
        end
    end
end
