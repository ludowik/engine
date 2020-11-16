class 'classItem' : extends(Object)

function classItem:init(klass, k)
    Object.init(self, klass.__className or k)

    self.klass = klass
    self.klassbases = attributeof('__bases', klass) or Table()
    self.klasschilds = Table()

    self.pos = vec3(W/2, H/2)

    self.orientation = random(TAU)
end

function classItem:draw()
    zLevel(-1)

    stroke(white)
    strokeWidth(2)

    for i,v in ipairs(self.klassbases) do
        local klass = app.scene:ui(v.__className)
        if klass then
            line(self.pos.x, self.pos.y, klass.pos.x, klass.pos.y)
        end
    end

    zLevel(0)

    fill(cyan)
    textMode(CENTER)
    text(self.label, self.pos.x, self.pos.y)
end

function setup()
    for k,v in pairs(_G) do
        if type(v) == 'table' then
            local klass = app.scene:ui(v.__className)
            if klass == nil then
                local item = classItem(v, k)
                item.pos = vec3(W/2, H/2) -- vec3.random(W, H, 0)
                app.scene:add(item)
            end
        end
    end

    for k,v in app.scene:iter() do
        for i,base in ipairs(v.klassbases) do
            local node = app.scene:ui(base.__className)
            if node then
                node.klasschilds:add(v)
            end
        end
    end
end

function enrond()
    for k,v in app.scene:iter() do
        local startAngle = random(TAU)
        for i,child in ipairs(v.klasschilds) do
            child.orientation = v.orientation + TAU / #v.klasschilds * i
            child.pos = v.pos + 150 * vec3(cos(child.orientation), sin(child.orientation))
        end
    end
end

function onsrendvisible(dt)
    for k1,v1 in app.scene:iter() do
        for k2,v2 in app.scene:iter() do
            if k1 ~= k2 then
                local distance = v1.pos:dist(v2.pos)
                local w = textSize(v1.label) + textSize(v2.label)
                if distance < w then
                    local v = v2.pos - v1.pos
                    v:normalize()
                    
                    if v:len() == 0 then
                        v = vec3.random()
                    end

                    v1.pos:add(-v * dt)
                    v2.pos:add( v * dt)
                end
            end
        end

--        for k3,v3 in ipairs(v1.klassbases) do
--            v3 = app.scene:ui(v3.__className)
--            if v3 then
--                local w = textSize(v1.klass.__className) + textSize(v3.__className)
--                local distance = v1.pos:dist(v3.pos)
--                if distance < w * 1 then
--                    local v = v3.pos - v1.pos
--                    v:normalize()

--                    v1.pos:add(-v * dt)
--                    v3.pos:add( v * dt)

--                elseif distance > w * 2 then
--                    local v = v3.pos - v1.pos
--                    v:normalize()

--                    v1.pos:add( v * dt)
--                    v3.pos:add(-v * dt)
--                end
--            end
--        end
    end
end

function update(dt)
    onsrendvisible(dt)
--    enrond()
    
    local vmin = vec3(0, 0)
    local vmax = vec3(W, H)
    
    for k,v in app.scene:iter() do
        vmin.x = min(vmin.x, v.pos.x)
        vmin.y = min(vmin.y, v.pos.y)
        
        vmax.x = max(vmax.x, v.pos.x)
        vmax.y = max(vmax.y, v.pos.y)
    end
    
    w = vmax.x - vmin.x
    h = vmax.y - vmin.y
    
    for k,v in app.scene:iter() do
        v.pos.x = (v.pos.x - vmin.x) / w * W
        v.pos.y = (v.pos.y - vmin.y) / h * H
    end
end

function draw()
    app.scene:draw()
end
