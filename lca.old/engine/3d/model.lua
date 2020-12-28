class('Model')

function Model.setup()
    local v = 0.5

    local p1 = vector(-v, -v, 0)
    local p2 = vector( v, -v, 0)
    local p3 = vector( v,  v, 0)
    local p4 = vector(-v,  v, 0)

    local f1 = p1 + vector(0, 0, v)
    local f2 = p2 + vector(0, 0, v)
    local f3 = p3 + vector(0, 0, v)
    local f4 = p4 + vector(0, 0, v)

    local u5 = vector(v, v, 1)

    local b1 = p1 + vector(0, 0, -v)
    local b2 = p2 + vector(0, 0, -v)
    local b3 = p3 + vector(0, 0, -v)
    local b4 = p4 + vector(0, 0, -v)

    -- face
    vertices_face = {
        p1,p2,p3,p1,p3,p4
    }

    vertices_face_edge = {
        p1,p2,p3,p4,p1
    }

    texCoords_face = {
        vector(0,0),
        vector(1,0),
        vector(1,1),
        vector(0,0),
        vector(1,1),
        vector(0,1)
    }

    texCoords_face_top2bottom = {
        vector(0,1),
        vector(1,1),
        vector(1,0),
        vector(0,1),
        vector(1,0),
        vector(0,0)
    }

    -- box
    vertices_box = {
        b1,f1,f4,b1,f4,b4, -- left
        f1,f2,f3,f1,f3,f4, -- front
        f2,b2,b3,f2,b3,f3, -- right
        b2,b1,b4,b2,b4,b3, -- back
        f4,f3,b3,f4,b3,b4, -- top
        b1,b2,f2,b1,f2,f1  -- bottom
    }

    vertices_box_edge = {
        f1,f2,f2,f3,f3,f4,f4,f1, -- front
        b2,b1,b1,b4,b4,b3,b3,b2, -- back
        f1,b1,f2,b2,f3,b3,f4,b4  -- sides
    }

    texCoords_box = {}

    local function transformCoords(x, y, w, h)
        w = w or 1/4
        h = h or 1/3

        local t = vector(x, y)
        return function (_, _, v)
            return vector(
                v.x * w + x,
                v.y * h + y)
        end
    end

    Table.addItems(texCoords_box, Table.map(texCoords_face, transformCoords(0/4,1/3)))
    Table.addItems(texCoords_box, Table.map(texCoords_face, transformCoords(1/4,1/3)))
    Table.addItems(texCoords_box, Table.map(texCoords_face, transformCoords(2/4,1/3)))
    Table.addItems(texCoords_box, Table.map(texCoords_face, transformCoords(3/4,1/3)))
    Table.addItems(texCoords_box, Table.map(texCoords_face, transformCoords(1/4,2/3)))
    Table.addItems(texCoords_box, Table.map(texCoords_face, transformCoords(1/4,0/3)))

    texCoords_box2 = {}
    Table.addItems(texCoords_box2, texCoords_face)
    Table.addItems(texCoords_box2, texCoords_face)
    Table.addItems(texCoords_box2, texCoords_face)
    Table.addItems(texCoords_box2, texCoords_face)
    Table.addItems(texCoords_box2, texCoords_face)
    Table.addItems(texCoords_box2, texCoords_face)

    -- triangle
    texCoords_triangle = {
        vector(0,0),
        vector(1,0),
        vector(0.5,1)
    }

    -- pyramid
    vertices_pyramid = {
        f1,f2,u5, -- front
        f2,b2,u5, -- right
        b2,b1,u5, -- back
        b1,f1,u5, -- left
        f2,f1,b1,f2,b1,b2  -- down
    }

    -- tetrahedron
    vertices_tetra = {
        f1,f3,b4,
        f1,b2,f3,
        b2,b4,f3,
        b2,f1,b4
    }
end

function Model.mesh(vertices, texCoords, normals)
    local m = Mesh()

    m.vertices = vertices or m.vertices
    m.texCoords = texCoords or m.texCoords
    m.normals = normals or m.normals

    if m.normals == nil then
        m.normals = Model.computeNormals(m.vertices)
    end

    return m
end

function Model.add(m1, m2)
    m1.vertices = Table.__add(m1.vertices, m2.vertices)
    m1.texCoords = Table.__add(m1.texCoords, m2.texCoords)
    m1.normals = Table.__add(m1.normals, m2.normals)
end

function Model.set(m, p)
    m.vertices = p.vertices or m.vertices
    m.texCoords = p.texCoords or m.texCoords
    m.normals = p.normals or m.normals
end

function Model.computeIndices(...)
    return ...
end

function Model.computeIndices2(vertices, texCoords, normals)
    local v = {}
    local t = {}
    local n = {}

    local indices = {}

    local j = 1

    local find

    for i=1,#vertices do

        find = false
        for j=1,#indices do
            if v[j] == vertices[i] and t[j] == texCoords[i] and n[j] == normals[i] then
                find = j
                break
            end
        end

        if find then
            indices[i] = find-1
        else
            v[j] = vertices[i]
            t[j] = texCoords[i]
            n[j] = normals[i]

            indices[i] = j-1

            j = j + 1
        end
    end

    return v, t, n, indices
end

function Model.computeNormals(vertices, indices)
    local normals = {}

    local n = indices and #indices or #vertices

    assert(n/3 == floor(n/3))

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

        local v12 = v2 - v1
        local v13 = v3 - v1

        assert(v12)
        assert(v13)

        local normal = v12:cross(v13)

        normals[i] = normal
        normals[i+1] = normal
        normals[i+2] = normal
    end

    return normals
end

function Model.computeNormalsIndices(vertices, indices)
    local normals = {}

    for i = 1, #indices, 3 do
        local normal = (vertices[indices[i+1]+1] - vertices[indices[i]+1])
        :cross(vertices[indices[i+2]+1] - vertices[indices[i]+1] )

        normals[indices[i+0]+1] = normal
        normals[indices[i+1]+1] = normal
        normals[indices[i+2]+1] = normal
    end

    return normals
end

function Model.computeNormals2(vertices, origin)
    local normals = {}

    for i = 1, #vertices do
        local normal = vertices[i] - origin
        normals[i] = normal
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
        vertices[i] = vertices[i] - v
    end
end

function Model.minmax(vertices)
    local minVertex = vector( math.maxinteger,  math.maxinteger)
    local maxVertex = vector(-math.maxinteger, -math.maxinteger)

    for i=1,#vertices do
        local v = vertices[i]

        minVertex.x = min(minVertex.x, v.x)
        minVertex.y = min(minVertex.y, v.y)
        minVertex.z = min(minVertex.z, v.z)

        maxVertex.x = max(maxVertex.x, v.x)
        maxVertex.y = max(maxVertex.y, v.y)
        maxVertex.z = max(maxVertex.z, v.z)
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
        vertices[i] = matrix * vertices[i]
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

function Model.point()
    return Model.mesh(vertices_face,
        texCoords_face,
        Model.computeNormals(vertices_face))
end

function Model.line()
    return Model.mesh({
            vector(0, 0),
            vector(0.1, 0.1),
            vector(0.9, 0.9),
            vector(1, 1)
        })
end

function Model.lines(...)
    local args = {...}

    local gl_in = args
    local gl_out = Table()

    local halfWidth = strokeWidth() / 2

    function addExtreme(p0, p1, start)
        local line = p1 - p0

        local normal = vector(-line.y, line.x):normalize()

        local a = p0 + halfWidth * normal
        local b = p0 - halfWidth * normal

        local c = p1 + halfWidth * normal
        local d = p1 - halfWidth * normal

        if start then
            gl_out:addItems({a,b})
        else
            gl_out:addItems({c,d})
        end
    end

    function addIn(p0, p1, p2, start)
        local line = p1 - p0

        local normal = vector(-line.y, line.x):normalize()

        local a = p0 + halfWidth * normal
        local b = p0 - halfWidth * normal

        local c = p1 + halfWidth * normal
        local d = p1 - halfWidth * normal

        local tangent = ((p2-p1):normalize() + (p1-p0):normalize()):normalize()

        local miter = vector(-tangent.y, tangent.x)

        local length = halfWidth / miter:dot(normal)

        c = p1 + length * miter
        d = p1 - length * miter

        if start then
            assert(false)
            gl_out:addItems({a,b})
        else
            gl_out:addItems({c,d})
        end
    end

    local n = #gl_in
    assert(n>=2)

    addExtreme(gl_in[1], gl_in[2], true)
    for i=2,n-1 do
        addIn(gl_in[i-1], gl_in[i], gl_in[i+1], false)
    end
    addExtreme(gl_in[n-1], gl_in[n], false)

    return Model.mesh(gl_out)
end

function Model.rect()
    return Model.mesh(vertices_face,
        texCoords_face,
        Model.computeNormals(vertices_face)), Model.mesh(vertices_face_edge)
end

function Model.text()
    return Model.mesh(vertices_face,
        texCoords_face_top2bottom,
        Model.computeNormals(vertices_face))
end

local cos = math.cos
local sin = math.sin

function Model.ellipse(segment, counterClockWise)
    local tau = math.pi * 2

    segments = segments or 64
    counterClockWise = counterClockWise or true

    local edges = {}
    local vertices = {}

    for i=0,segments do
        local angle = -(i / segments) * tau

        local x = math.cos(angle) * 0.5
        local y = math.sin(angle) * 0.5

        table.insert(edges, vector(x, y, 0))
    end

    for i=1,segments do
        if counterClockWise then
            table.insert(vertices, edges[i+1])
            table.insert(vertices, edges[i])
        else
            table.insert(vertices, edges[i])
            table.insert(vertices, edges[i+1])
        end
        table.insert(vertices, vector(0,0,0))    
    end

    local fillModel = Model.mesh(vertices, nil, Model.computeNormals(vertices))
    local strokeModel = Model.mesh(edges)

    return fillModel, strokeModel
end

function Model.tetrahedron()
    vertices = vertices_tetra
    vertices = Model.scaleAndTranslateAndRotate(vertices, 0, 0, 0, 1, 1, 1, 90)
    return Model.mesh(vertices,
        nil,
        Model.computeNormals(vertices_tetra))
end

local function positionAndSize(x, y, z, w, h, d, size)
    if w then
        x = x or 0
        y = y or 0
        z = z or 0

        w = w or size
        h = h or w
        d = d or w

    elseif x then
        w = x or size
        h = y or w
        d = z or w

        x = 0
        y = 0
        z = 0

    else
        x = 0
        y = 0
        z = 0

        w = 1
        h = 1
        d = 1
    end

    return x, y, z, w, h, d
end

function Model.box(x, y, z, w, h, d)
    x, y, z, w, h, d = positionAndSize(x, y, z, w, h, d, 1)

    return Model.mesh(Model.scaleAndTranslateAndRotate(vertices_box, x, y, z, w, h, d),
        texCoords_box,
        Model.computeNormals(vertices_box))
end

function Model.box2(x, y, z, w, h, d)
    x, y, z, w, h, d = positionAndSize(x, y, z, w, h, d, 1)

    return Model.mesh(Model.scaleAndTranslateAndRotate(vertices_box, x, y, z, w, h, d),
        texCoords_box2,
        Model.computeNormals(vertices_box))
end

function meshAddVertex(vertices, v)
    table.insert(vertices, v)
end

function meshAddTriangle(vertices, v1, v2, v3)
    meshAddVertex(vertices, v1)
    meshAddVertex(vertices, v2)
    meshAddVertex(vertices, v3)
end

function meshAddRect(vertices, v1, v2, v3, v4)
    meshAddTriangle(vertices, v1, v2, v3)
    meshAddTriangle(vertices, v1, v3, v4)
end

function meshSetTriangleColors(colors, clr)
    meshAddVertex(colors, clr)
    meshAddVertex(colors, clr)
    meshAddVertex(colors, clr)
end

function Model.sphere(x, y, z, w, h, d)
    x, y, z, w, h, d = positionAndSize(x, y, z, w, h, d, 1)

    local vertices = {}

    function coord(x, y, z, w, h, d, phi, theta)
        phi = rad(phi)
        theta = rad(theta)

        return
        x + w / 2 * cos(phi) * sin(theta),
        y + h / 2 * cos(phi) * cos(theta),
        z + d / 2 * sin(phi)
    end

    local delta = 1
    local faces = 0

    for theta = 0, 360-delta, delta do
        for phi = 90, 270-delta, delta do
            local xs1, ys1, zs1 = coord(x, y, z, w, h, d, phi, theta)
            local xs2, ys2, zs2 = coord(x, y, z, w, h, d, phi, theta+delta)
            local xs3, ys3, zs3 = coord(x, y, z, w, h, d, phi+delta, theta+delta)
            local xs4, ys4, zs4 = coord(x, y, z, w, h, d, phi+delta, theta)

            meshAddRect(vertices,
                vector(xs2, ys2, zs2),
                vector(xs1, ys1, zs1),
                vector(xs4, ys4, zs4),
                vector(xs3, ys3, zs3))

            faces = faces + 1
        end
    end

    local texCoords = {}
    for s = 1, faces do
        Table.addItems(texCoords, texCoords_face)
    end

    local normals = {}
    for i = 1, #vertices do
        normals[i] = vertices[i]:normalize()
    end

    return Model.mesh(vertices, texCoords, normals)
end

function Model.pyramid(w, h, d)
    w = w or 1
    h = h or w
    d = d or w

    local vertices = vertices_pyramid

    local texCoords = {}
    for s = 1,4 do
        Table.addItems(texCoords, texCoords_triangle)
    end
    Table.addItems(texCoords, texCoords_face)

    return Model.mesh(
        Model.scaleAndTranslateAndRotate(vertices, -w/2, -h/2, -d/2, w, h, d),
        texCoords)
end

function Model.cone(r, e, delta)
    r = r or 0.5
    e = e or 1

    local points = {}
    Geometry.arc(points, 0, 0, r, 0, tau, delta)

    local vertices = {}

    local vc = vector(r, r, 0.0)
    local v1 = points[1]

    for i = 2, #points do
        local v2 = points[i]
        meshAddTriangle(vertices, vc, v2, v1)
        v1 = v2
    end

    vc = vector(r, r, e)
    v1 = points[1]

    for i = 2, #points do
        local v2 = points[i]
        meshAddTriangle(vertices, vc, v1, v2)
        v1 = v2
    end

    local texCoords = {}
    for s = 1, 2*#points do
        Table.addItems(texCoords, texCoords_triangle)
    end

    return Model.mesh(
        Model.scaleAndTranslateAndRotate(vertices, -r, -r, -e/2, 1, 1, 1, -90, 0, 0),
        texCoords)
end

function Model.cylinder(r1, r2, e, delta)
    r1 = r1 or 0.5
    r2 = r2 or 0.5

    e = e or 1

    delta = delta or tau*.05

    local points1 = {}
    Geometry.arc(points1, 0, 0, r1, 0, tau, delta)
    points1 = Model.scaleAndTranslateAndRotate(points1, -r1, -r1)

    local points2 = {}
    Geometry.arc(points2, 0, 0, r2, 0, tau, delta)
    points2 = Model.scaleAndTranslateAndRotate(points2, -r2, -r2)

    local vertices = {}

    local vc = vector(0, 0, 0)
    local v1 = points1[1]

    for i = 2, #points1 do
        local v2 = points1[i]
        meshAddTriangle(vertices, vc, v2, v1)
        v1 = v2
    end

    vc = vector(0, 0, e)
    v1 = points2[1]

    for i = 2, #points2 do
        local v2 = points2[i]
        meshAddTriangle(vertices, vc, vector(v1.x, v1.y, e), vector(v2.x, v2.y, e))
        v1 = v2
    end

    v1 = points1[1]
    v4 = points2[1]

    for i = 2, #points2 do
        local v2 = points1[i]
        local v3 = points2[i]
        meshAddRect(vertices, v1, v2, vector(v3.x, v3.y, e), vector(v4.x, v4.y, e))
        v1 = v2
        v4 = v3
    end

    local texCoords = {}
    for s = 1, 2*#points1-2 do
        Table.addItems(texCoords, texCoords_triangle)
    end
    for s = 2, #points2 do
        Table.addItems(texCoords, texCoords_face)
    end

    return Model.mesh(
        vertices,
        texCoords)
end

function Model.obelix()
    local vertices = {}

    local a = Model.cylinder(1, 0.5, 2)
    local b = Model.cone(.5)

    Table.addItems(vertices, Model.scaleAndTranslateAndRotate(a.mesh.vertices))
    Table.addItems(vertices, Model.scaleAndTranslateAndRotate(b.mesh.vertices, 0, 0, 0))

    return Model.mesh(vertices, texCoords)
end

function Model.grass_band(vertices, p1, p2, w, h, angle)
    local e = sin(angle) * h

    local p3 = vector(p2.x-w*.5, p2.y+e, p2.z+h)
    local p4 = vector(p1.x+w*.5, p1.y+e, p1.z+h)

    meshAddRect(vertices, p1, p2, p3, p4)

    return p4, p3
end

function Model.grass_alea(vertices, texCoords, normals)
    local v = {}

    local w = random(0.25, 0.50)
    local h = random(7.5, 15)
    local e = random(0, h)

    local p1 = vector(-w*.5, 0, 0)
    local p2 = vector( w*.5, 0, 0)

    local n = 5

    local angle = 0

    for i = 1, n do
        p1, p2 = Model.grass_band(v, p1, p2, w*.5/n, h/n, angle)
        angle = angle + 90/n
    end

    Model.scaleAndTranslateAndRotate(v, random(0,wcell), random(0,wcell), 0, 1, 1, 1, random(0,360))

    table.addItems(vertices, v)
    table.addItems(normals, Model.computeNormals(v))
end

function Model.grass(n)
    local vertices = {}
    local texCoords = {}
    local normals = {}

    n = n or 1
    for i = 1, n do
        Model.grass_alea(vertices, texCoords, normals)
    end

    return Model.mesh(
        vertices, texCoords, normals)
end

function Model.plane()
    local face = Model.scaleAndTranslateAndRotate(vertices_face, 0, 0, 0, 1, 1, 1, 90)
    return Model.mesh(
        face,
        texCoords_face,
        Model.computeNormals(face))
end

function Model.dalle(x, y, z)
    local vertices = Table()

    local m = 0.25
    for i = 0, 4 do
        vertices:addItems(Model.scaleAndTranslateAndRotate(vertices_box, m, i*10+m, 0, 50-m*2, 10-m*2, 2.5))
        vertices:addItems(Model.scaleAndTranslateAndRotate(vertices_box, 50+m, 50+i*10+m, 0, 50-m*2, 10-m*2, 2.5))
    end

    for i = 0, 4 do
        vertices:addItems(Model.scaleAndTranslateAndRotate(vertices_box, 50+i*10+m, m, 0, 10-m*2, 50-m*2, 2.5))
        vertices:addItems(Model.scaleAndTranslateAndRotate(vertices_box, i*10+m, 50+m, 0, 10-m*2, 50-m*2, 2.5))
    end

    Model.scaleAndTranslateAndRotate(vertices, x, y, z)

    return Model.mesh(
        vertices,
        texCoords)
end

function Model.complex()
    --  local str = "10004,20004,30004,44444"
    --  local str = "30000,31111,32222,43333"
    local str = "989898989,877777778,977777779,877777778,977777779,877777778,977777779,877777778,989898989"

    local vertices = {}

    local texCoords = {}

    local x = 0
    local z = 0

    local m = Model.box()
    for h in str:gmatch(".") do
        if h == ',' then
            x = 0
            z = z + 1
        else
            for y = 0, tonumber(h)-1 do
                local verticesbox, texCoordsbox = m.vertices, m.texCoords

                Table.addItems(vertices, Model.scaleAndTranslateAndRotate(verticesbox, x, y, z))
                if texCoordsbox then
                    Table.addItems(texCoords, texCoordsbox)
                end
            end

            x = x + 1
        end
    end

    return Model.mesh(
        vertices,
        texCoords,
        Model.computeNormals(vertices))
end

function Model.teapot()
    return Model.load('teapot')
end

function Model.load(fileName)
    local m = loadObj(fileName)

    if #m.normals == 0 then
        m.normals = Model.computeNormals(m.vertices)
    end

    return m
end

function Model.skybox(w)
    w = w or 1
    h = w
    e = w

    return Model.mesh(Model.computeIndices(
            Model.scaleAndTranslateAndRotate(vertices_box, 0, 0, 0, w, h, -e),
            texCoords_box,
            Model.computeNormals(vertices_box)))
end

function Model.triangulate(points)
    local mypoints = {}
    for i = 1, #points do
        table.insert(mypoints, vector(points[i].x, points[i].y))
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

function Model.random.polygon(r)
    local vectors = {}

    r = r or 1

    local n = 8
    local a = tau / n

    for i=1,n-1 do
        local radius = randomInt(r/2, r)
        table.insert(vectors,        
            vec3(
                radius * cos(a*i),
                radius * sin(a*i)))
    end

    return vectors
end
