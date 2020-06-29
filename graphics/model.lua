class 'Model'

function Model.point(x, y)
    x = x or 0
    y = y or 0

    return Buffer('float', x, y, 0)
end

function Model.points(points)
    local vertices = Buffer()

    for i=1,#points,3 do
        vertices[i+0] = points[i+0]
        vertices[i+1] = points[i+1]
        vertices[i+2] = 0
    end

    return vertices
end

function Model.line(x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or 1
    h = h or 1

    local vertices = Buffer('float', 
        x, y, 0,
        x+w, y+h, 0)

    return vertices
end

function Model.rect(x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or 1
    h = h or 1

    local vertices = Buffer('float',
        x+0, y+0, 0,
        x+w, y+0, 0,
        x+w, y+h, 0,
        x+0, y+0, 0,
        x+w, y+h, 0,
        x+0, y+h, 0)

    local texCoords = Buffer('float',
        0,0,
        1,0,
        1,1,
        0,0,
        1,1,
        0,1)

    return vertices, texCoords
end

function Model.ellipse(x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or 1
    h = h or 1

    local vertices = Buffer()

    local n = 128

    local x1, y1 = math.cos(0) / 2, math.sin(0) / 2
    local x2, y2 = 0, 0

    for i=n,0,-1 do
        x2 = math.cos(math.tau * i / n) / 2
        y2 = math.sin(math.tau * i / n) / 2

        vertices:insert(0)
        vertices:insert(0)
        vertices:insert(0)

        vertices:insert(x2)
        vertices:insert(y2)
        vertices:insert(0)

        vertices:insert(x1)
        vertices:insert(y1)
        vertices:insert(0)

        x1, y1 = x2, y2
    end

    return vertices
end

function Model.box(w, h, d)
    local f1 = {-1,-1, 1}
    local f2 = { 1,-1, 1}
    local f3 = { 1, 1, 1}
    local f4 = {-1, 1, 1}

    local b1 = {-1,-1,-1}
    local b2 = { 1,-1,-1}
    local b3 = { 1, 1,-1}
    local b4 = {-1, 1,-1}

    local vertices = {
        f1, f2, f3, f1, f3, f4, -- front
        b2, b1, b4, b2, b4, b3, -- back
        f2, b2, b3, f2, b3, f3, -- right
        b1, f1, f4, b1, f4, b4, -- left
        f4, f3, b3, f4, b3, b4, -- top
        b1, b2, f2, b1, f2, f1, -- bottom

    }

    local buf = Buffer()
    for i=1,#vertices do
        buf[#buf+1] = vertices[i][1]
        buf[#buf+1] = vertices[i][2]
        buf[#buf+1] = vertices[i][3]
    end

    local w = 1/4-1/100
    local h = 1/3-1/100
    local texCoords = Buffer('float')

    function add(coords, dx, dy)
        for i=0,5 do
            texCoords[#texCoords+1] = coords[i*2+1] + dx
            texCoords[#texCoords+1] = coords[i*2+2] + dy
        end
    end

    add({0,0, w,0, w,h, 0,0, w,h, 0,h}, 1/4, 1/3)
    add({0,0, w,0, w,h, 0,0, w,h, 0,h}, 3/4, 1/3)
    add({0,0, w,0, w,h, 0,0, w,h, 0,h}, 2/4, 1/3)
    add({0,0, w,0, w,h, 0,0, w,h, 0,h}, 0/4, 1/3)
    add({0,0, w,0, w,h, 0,0, w,h, 0,h}, 1/4, 2/3)
    add({0,0, w,0, w,h, 0,0, w,h, 0,h}, 1/4, 0/3)

    return buf, texCoords
end


function Model.triangulate(points)
    local mypoints = {}
    for i = 1, #points do
        table.insert(mypoints, vec3(points[i].x, points[i].y))
    end

    if #points == 1 then
        return {mypoints[1], mypoints[1], mypoints[1]}

    elseif #points == 2 then
        return {mypoints[1], mypoints[1], mypoints[2]}

    elseif #points == 3 then
        return mypoints
    end

    -- result
    local trivecs = {}

    local steps_without_reduction = 0
    local i = 1
    while #mypoints >= 3 and steps_without_reduction < #mypoints do
        local v2i = i % #mypoints + 1
        local v3i = (i + 1) % #mypoints + 1
        local v1 = mypoints[i]
        local v2 = mypoints[v2i]
        local v3 = mypoints[v3i]
        local da = enclosedAngle(v1, v2, v3)
        local reduce = false
        if da >= 0 then
            -- The two edges bend inwards, candidate for reduction.
            reduce = true
            -- Check that there's no other point inside.
            for ii = 1, (#mypoints - 3) do
                local mod_ii = (i + 2 + ii - 1) % #mypoints + 1
                if isInsideTriangle(mypoints[mod_ii], v1, v2, v3) then
                    reduce = false
                end
            end
        end
        if reduce then
            table.insert(trivecs, v1)
            table.insert(trivecs, v2)
            table.insert(trivecs, v3)
            table.remove(mypoints, v2i)
            steps_without_reduction = 0
        else
            i = i + 1
            steps_without_reduction = steps_without_reduction + 1
        end
        if i > #mypoints then
            i = i - #mypoints
        end
    end
    return trivecs
end

function triangulate(...)
    return Model.triangulate(...)
end

Model.random = {}

function Model.random.polygon(r, rmax)
    r = r or math.random(10, 50)

    rmax = rmax or r
    rmin = r

    local vertices = Table()

    local angle = 0
    while angle < math.pi * 2 do
        local len = math.random(rmin, rmax)

        local p = vec2(
            len * math.cos(angle),
            len * math.sin(angle))

        vertices:insert(p)

        angle = angle + math.random() * math.pi / 2
    end

    return vertices
end
