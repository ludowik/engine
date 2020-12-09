class 'classItem' : extends(Object)

function classItem:init(className, classRef)
    Object.init(self, classRef.__className or className)

    self.id = id('classItem')
    self.description = className

    self.classRef = classRef
    self.klassbases = attributeof('__bases', classRef) or Table()

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

    font(DEFAULT_FONT_NAME)
    fontSize(10)

    self.size = vec2(textSize(self.description))
end

function classItem:draw()
    zLevel(-1)

    for i,v in ipairs(self.klassbases) do
        local base = app.scene:ui(v.__className)
        if base then
            local a = self.position
            local b = base.position

            local direction = b - a

            local start = direction * 0.1
            local to = direction * 0.9

            stroke(gray)
    strokeWidth(1)
            line(start.x, start.y, to.x, to.y)
            
            stroke(red)
    strokeWidth(3)
            point(to.x, to.y)
        end
    end

    zLevel(0)

    fill(cyan)

    font(DEFAULT_FONT_NAME)
    fontSize(10)

    textMode(CENTER)
    text(self.description, 0, 0)
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

    parameter.number('pivot', 1, 1000, 80)
    parameter.number('force', 1, 1000, 250)
end

function constraints(dt)
    for _,item in app.scene:iter() do
        item.force = vec2()
    end

    local n = #app.scene.nodes

    for i=1,n-1 do
        local a = app.scene.nodes[i]

        for j=i+1,n do
            local b = app.scene.nodes[j]

            local direction = b.position - a.position
            local dist = direction:len()

            direction:normalizeInPlace()

            local level = pivot + (a.level + b.level)

            if dist < level then
                direction:mul(math.map(dist, 0, level, 10, 0))
                a.force = a.force - direction
                b.force = b.force + direction

            elseif dist > level then
                if (links[a.id..'/'..b.id] or
                    links[b.id..'/'..a.id])
                then
                    direction:mul(math.map(dist, level, W, 0, 250))
                    a.force = a.force + direction
                    b.force = b.force - direction
                else
                    direction:mul(math.map(dist, level, W, 0, 10))
                    a.force = a.force + direction
                    b.force = b.force - direction
                end
            end

        end
    end

    for _,item in app.scene:iter() do
        item.position = item.position + item.force * 5 * dt
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

    local w = maxx - minx
    local h = maxy - miny

    local rx = W/w
    local ry = H/h

    for _,item in app.scene:iter() do
        item.position.x = (item.position.x - minx) * rx * 0.9 + 0.05 * W
        item.position.y = (item.position.y - miny) * ry * 0.9 + 0.05 * H
    end
end

function update(dt)
    constraints(dt)
    rebase()
end

function draw()
    depthMode(true)
    app.scene:draw()
end

function keyboard(key)
    if key == 'return' then
        for _,item in app.scene:iter() do
            item.position = vec2.random(W, H)
        end
    end
end
