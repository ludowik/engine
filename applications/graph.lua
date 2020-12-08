class 'classItem' : extends(Object)

function classItem:init(k, klass)
    Object.init(self, klass.__className or k)

    self.id = id()

    self.klass = klass
    self.klassbases = attributeof('__bases', klass) or Table()

    self.klasschilds = Table()
    self.klassparents = Table()

    local hasChild = self.klassbases
    local level = 0
    while hasChild and #hasChild > 0 do
        level = level +1
        hasChild = attributeof('__bases', hasChild[1])
    end

    self.level = level

    self.position = vec2.random(W, H)

    self.orientation = random(TAU)
end

function classItem:draw()
    zLevel(-1)

    stroke(white)
    strokeWidth(2)

    for i,v in ipairs(self.klassbases) do
        local klass = app.scene:ui(v.__className)
        if klass then
            line(0, 0,
                klass.position.x - self.position.x,
                klass.position.y - self.position.y)
        end
    end

    zLevel(0)

    fill(cyan)

    textMode(CENTER)
    text(self.level, 0, 0)
end

function setup()
    for k,v in pairs(_G) do
        if type(v) == 'table' then
            local item = app.scene:ui(v.__className)
            if item == nil then
                item = classItem(k, v)

                app.scene:add(item)
            end
        end
    end

    links = {}

    for _,item in app.scene:iter() do
        for i,base in ipairs(item.klassbases) do
            local node = app.scene:ui(base.__className)
            if node then
                node.klasschilds:add(item)
                item.klassparents:add(node)
                links[item.id..'/'..node.id] = true
            end
        end
    end
end

function constraints(dt)
    for _,item in app.scene:iter() do
        item.force = vec2()
    end

    local pivot = 50
    
    local n = #app.scene.nodes

    for i=1,n-1 do
        local a = app.scene.nodes[i]

        for j=i+1,n do
            local b = app.scene.nodes[j]

            local direction = b.position - a.position
            local dist = direction:len()

            direction:normalizeInPlace()

            if dist < pivot then
                direction:mul(-math.map(dist, 0, pivot, 10, 0))
                a.force = a.force - direction
                b.force = b.force + direction

            elseif dist > pivot then                    
                if links[a.id..'/'..b.id] then
                    direction:mul(math.map(dist, pivot, 100, 0, 10))
                else
                    direction:mul(math.map(dist, pivot, 200, 0, 1))
                end
                a.force = a.force + direction
                b.force = b.force - direction
            end

        end
    end

    for _,item in app.scene:iter() do
        item.position = item.position + item.force * dt
    end
end

function rebase()
    local minx, miny, maxx, maxy = math.maxinteger, math.maxinteger, -math.maxinteger, -math.maxinteger
    for _,item in app.scene:iter() do
        minx = min(minx, item.position.x)
        miny = min(miny, item.position.y)
        maxx = max(maxx, item.position.x)
        maxy = max(maxy, item.position.y)
    end
    
    print(minx, maxx)

    local w = maxx - minx
    local h = maxy - miny

    local rx = W/w
    local ry = H/h
    
    for _,item in app.scene:iter() do
        item.position.x = (item.position.x - minx) * rx
        item.position.y = (item.position.y - miny) * ry
    end
end

function update(dt)
    constraints(dt)
    rebase()
end

function draw()
    app.scene:draw()
end
