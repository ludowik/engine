class('Geometry')

function Geometry.line(points, x1, y1, x2, y2)
    table.insert(points, vector(x1, y1))
    table.insert(points, vector(x2, y2))
end

function Geometry.arc(points, x, y, r, a1, a2, n)
    x = x + r
    y = y + r

    a1 = a1 or 0
    a2 = a2 or pi2
    
    n = n or pi2*.05

    table.insert(points, vector(x + r * cos(a1), y + r * sin(a1)))
    for a = a1+n, a2, n do
        table.insert(points, vector(x + r * cos(a), y + r * sin(a)))
    end
    table.insert(points, vector(x + r * cos(a2), y + r * sin(a2)))
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

function enclosedAngle(v1, v2, v3)
    local a1 = math.atan2(v1.y - v2.y, v1.x - v2.x)
    local a2 = math.atan2(v3.y - v2.y, v3.x - v2.x)
    -- for clockwise order
    --local da = math.deg(a2 - a1)
    -- for counter-clockwise order
    local da = math.deg(a1 - a2)
    if da < -180 then da = da + 360 elseif da > 180 then da = da - 360 end
    return da
end

-- Determines if a vector |v| is inside a triangle described by the vectors
-- |v1|, |v2| and |v3|.
function isInsideTriangle(v, v1, v2, v3)
    local a1
    local a2
    a1 = enclosedAngle(v1, v2, v3)
    a2 = enclosedAngle(v, v2, v3)
    if a2 > a1 or a2 < 0 then return false end
    a1 = enclosedAngle(v2, v3, v1)
    a2 = enclosedAngle(v, v3, v1)
    if a2 > a1 or a2 < 0 then return false end
    a1 = enclosedAngle(v3, v1, v2)
    a2 = enclosedAngle(v, v1, v2)
    if a2 > a1 or a2 < 0 then return false end
    return true
end
