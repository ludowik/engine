
local vertices

CLOSE = 'close'

LINES = 'lines'

function beginShape()
    vertices = {}
end

function vertex(x, y)
    vertices[#vertices+1] = vec2(x, y)
end

function endShape(mode)
    if mode == CLOSE then
        vertices[#vertices+1] = vertices[1]
    end
    if mode == LINES then
        lines(vertices)
    else
        polyline(vertices)
    end
end
