local Collision = class('Fizix.Collision')

Fizix.Collision = Collision

function Collision.collide(obj1, obj2)
    if obj1.shapeType == RECT or obj2.shapeType == RECT then
        return Collision.rect2rect(obj1, obj2)
    else
        return Collision.circle2circle(obj1, obj2)
    end
end

function Collision.rect2rect(obj1, obj2)
    local xl1, yb1, xr1, yt1 = obj1:getBoundingBox()
    local xl2, yb2, xr2, yt2 = obj2:getBoundingBox()
    
    if xr1 < xl2 or xl1 > xr2 or yt1 < yb2 or yb1 > yt2 then
        return false
    end
    
    return true
end

function Collision.circle2circle(obj1, obj2)
    local x1, y1, r1 = obj1:getBoundingCircle()
    local x2, y2, r2 = obj2:getBoundingCircle()
    
    if math.sqrt((x2-x1)^2+(y2-y1)^2) > r1+r2 then
        return false
    end
    
    return true
end

function distFromPoint2Segment(x, y, x1, y1, x2, y2)
    local A = x - x1
    local B = y - y1
    local C = x2 - x1
    local D = y2 - y1

    local dot = A * C + B * D
    local len_sq = C * C + D * D
    local param = -1
    if (len_sq ~= 0) then -- in case of 0 length line
        param = dot / len_sq
    end

    local xx, yy

    if (param < 0) then
        xx = x1
        yy = y1
    elseif (param > 1) then
        xx = x2
        yy = y2
    else
        xx = x1 + param * C
        yy = y1 + param * D
    end

    local dx = x - xx
    local dy = y - yy

    return sqrt(dx * dx + dy * dy)
end
