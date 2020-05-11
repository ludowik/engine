class 'Model'

function Model.point(x, y)
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
