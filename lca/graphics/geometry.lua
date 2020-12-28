class('Geometry')

function Geometry.line(points, x1, y1, x2, y2)
    table.insert(points, vec2(x1, y1))
    table.insert(points, vec2(x2, y2))
end

function Geometry.arc(points, x, y, r, a1, a2, n)
    x = x + r
    y = y + r

    a1 = a1 or 0
    a2 = a2 or pi2
    
    n = n or pi2*.05

    table.insert(points, vec2(x + r * cos(a1), y + r * sin(a1)))
    for a = a1+n, a2, n do
        table.insert(points, vec2(x + r * cos(a), y + r * sin(a)))
    end
    table.insert(points, vec2(x + r * cos(a2), y + r * sin(a2)))
end

function Geometry.draw(points, size, strokeColor)
    style(size, strokeColor)

    local p1 = points[1]
    
    if #points == 1 then
        circle(p1.x, p1.y, size, size, strokeColor, strokeColor, CENTER)
    else
        for i = 2, #points do
            local p2 = points[i]
            line(p1.x, p1.y, p2.x, p2.y)
            p1 = p2
        end
    end
end
