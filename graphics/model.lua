class 'Model'

function Model.point(x, y)
    return {
        x, y, 0
    }
end

function Model.points(points)
    local vertices = {}

    for i=1,#points,3 do
        vertices[i+0] = points[i+0]
        vertices[i+1] = points[i+1]
        vertices[i+2] = 0
    end

    return vertices
end

function Model.rect(x, y, w, h)
    return {
        x+0, y+0, 0,
        x+w, y+0, 0,
        x+w, y+h, 0,
        x+0, y+0, 0,
        x+w, y+h, 0,
        x+0, y+h, 0,
    }
end
