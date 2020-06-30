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

function Model.skybox(w, h, d)
    return Model.box(w, h, d)
end

function Model.sphere(w, h, d)
    return {}
end

function Model.cylinder(w, h, d)
    return {}
end

function Model.pyramid(w, h, d)
    return {}
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

function Model.computeIndices(vertices, texCoords, normals)
    local v = {}
    local t = texCoords and {}
    local n = normals and {}

    local indices = {}

    local nb = 1

    local find

    for i=1,#vertices do

        find = false
        for j=1,#indices do
            if v[j] == vertices[i] and
            (not t or t[j] == texCoords[i]) and 
            (not n or n[j] == normals[i]) then
                find = j
                break
            end
        end

        if find then
            indices[i] = find-1
        else
            v[nb] = vertices[i]

            if texCoords then
                t[nb] = texCoords[i]
            end

            if normals then
                n[nb] = normals[i]
            end

            indices[i] = nb-1

            nb = nb + 1
        end
    end

    return v, t, n, indices
end

function Model.computeNormals(vertices, indices)
    local normals = {}

    local n = indices and #indices or #vertices

    assert(n/3 == floor(n/3))

    local v12, v13 = vec3(), vec3()
    
    local v1, v2, v3
    for i=1,n,3 do
        if indices then
            v1 = vertices[indices[i]]
            v2 = vertices[indices[i+1]]
            v3 = vertices[indices[i+2]]
        else
            v1 = vertices[i]
            v2 = vertices[i+1]
            v3 = vertices[i+2]
        end

        v12:set(v2):sub(v1)
        v13:set(v3):sub(v1)

        local normal = v12:crossInPlace(v13)

        normals[i  ] = normal
        normals[i+1] = normal
        normals[i+2] = normal
    end

    return normals
end

function Model.averageNormals(vertices, normals)
    local t = {}

    for i = 1, #normals do
        local vertex = vertices[i]
        local normal = normals[i]

        local ref = vertex.x.."."..vertex.y

        if t[ref] == nil then
            t[ref] = normal
        else
            t[ref] = t[ref] + normal
        end
    end 

    return t
end

function Model.gravityCenter(vertices)
    local v = Point()
    for i=1,#vertices do
        v = v + vertices[i]
    end

    v = v / #vertices

    for i=1,#vertices do
        vertices[i]:sub(v)
    end
end

function Model.minmax(vertices)
    local minVertex = vec3( math.MAX_INTEGER,  math.MAX_INTEGER)
    local maxVertex = vec3(-math.MAX_INTEGER, -math.MAX_INTEGER)

    for i=1,#vertices do
        local v = vertices[i]

        minVertex.x = min(minVertex.x, v.x)
        minVertex.y = min(minVertex.y, v.y)
        minVertex.z = min(minVertex.z, v.z or 0)

        maxVertex.x = max(maxVertex.x, v.x)
        maxVertex.y = max(maxVertex.y, v.y)
        maxVertex.z = max(maxVertex.z, v.z or 0)
    end

    return minVertex, maxVertex, maxVertex-minVertex
end

function Model.center(vertices)
    local minVertex, maxVertex, size = Model.minmax(vertices)

    local v = minVertex + size / 2
    for i=1,#vertices do
        vertices[i] = vertices[i] - v
    end

    return vertices 
end

function Model.normalize(vertices, norm)
    norm = norm or 1

    local minVertex, maxVertex, size = Model.minmax(vertices)

    norm = norm / ((size.x + size.y + size.z) / 3)

    for i=1,#vertices do
        vertices[i] = vertices[i] * norm
    end

    return vertices
end

function Model.transform(vertices, matrix)
    for i=1,#vertices do
        vertices[i] = matrix:mulVector(vertices[i])
    end

    return vertices
end

function Model.scale(vertices, w, h, e)
    w = w or 1
    e = e or h and 1 or w
    h = h or w

    local m = matrix()
    m = m:scale(w, h, e)

    return Model.transform(Table.clone(vertices), m)
end

function Model.translate(vertices, x, y, z)
    x = x or 0
    z = z or y and 0 or x
    y = y or x

    local m = matrix()
    m = m:translate(x, y, z)

    return Model.transform(Table.clone(vertices), m)
end

function Model.scaleAndTranslateAndRotate(vertices, x, y, z, w, h, e, ax, ay, az)
    x = x or 0
    z = z or y and 0 or x
    y = y or x

    w = w or 1
    h = h or w
    e = e or w

    ax = ax or 0
    ay = ay or 0
    az = az or 0

    local m = matrix()

    m1 = m:translate(x, y, z)

    m2 = m:rotate(ax, 1,0,0)
    m3 = m:rotate(ay, 0,1,0)
    m4 = m:rotate(az, 0,0,1)

    m5 = m:scale(w, h, e)

    return Model.transform(Table.clone(vertices), m1*m2*m5)
end

function meshAddVertex(vertices, v)
    table.insert(vertices, v)
end

function meshAddTriangle(vertices, v1, v2, v3)
    table.insert(vertices, v1)
    table.insert(vertices, v2)
    table.insert(vertices, v3)
end

function meshAddRect(vertices, v1, v2, v3, v4)
    table.insert(vertices, v1)
    table.insert(vertices, v2)
    table.insert(vertices, v3)

    table.insert(vertices, v1)
    table.insert(vertices, v3)
    table.insert(vertices, v4)
end

function meshSetTriangleColors(colors, clr)
    meshAddVertex(colors, clr)
    meshAddVertex(colors, clr)
    meshAddVertex(colors, clr)
end
