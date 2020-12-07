local vertices

CLOSE = 'close'

LINES = 'lines'

function beginShape()
    vertices = Buffer('vec3')
end

function vertex(x, y)
    vertices[#vertices+1] = vec3(x, y, 0)
end

function endShape(mode)
    if mode == LINES then
        lines(vertices)
    elseif mode == CLOSE then
        polygon(vertices)
    else
        polyline(vertices)
    end

    return vertices
end
