class 'Model'

function Model.point(x, y)
    assert()
    x = x or 0
    y = y or 0
    return {
        x, y, 0
    }
end

function Model.points(points)
    assert()
    local vertices = {}

    for i=1,#points,3 do
        vertices[i+0] = points[i+0]
        vertices[i+1] = points[i+1]
        vertices[i+2] = 0
    end

    return vertices
end

function Model.rect(x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or 1
    h = h or 1

    local vertices = {
        x+0, y+0, 0,
        x+w, y+0, 0,
        x+w, y+h, 0,
        x+0, y+0, 0,
        x+w, y+h, 0,
        x+0, y+h, 0,
    }

    local texCoords = {
        0,0,
        1,0,
        1,1,
        0,0,
        1,1,
        0,1
    }
    return vertices, texCoords
end

function Model.circle(x, y, w, h)
    x = x or 0
    y = y or 0
    w = w or 1
    h = h or 1

    local vertices = Buffer()

    n = 128

    x1, y1 = math.cos(0), math.sin(0)
    x2, y2 = 0, 0

    for i=1,n+1 do
        x2 = math.cos(math.tau * i / n)
        y2 = math.sin(math.tau * i / n)

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

        return vertices
    end
end
