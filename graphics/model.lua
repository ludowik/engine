class 'Model'

function Model.point(x, y)
    return {
        x/W, y/H, 0
    }
end

function Model.points(points)
    local vertices = {}
    
    for i=1,#points,3 do
        vertices[i+0] = points[i+0] / W
        vertices[i+1] = points[i+1] / H
        vertices[i+2] = 0
    end
    
    return vertices
end
