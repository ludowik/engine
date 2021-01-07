local Collision = class('Fizix.Collision')

function Collision.collide(obj1, obj2)
    if obj1.shapeType == POLYGON and obj2.shapeType == POLYGON then
--        return Collision.rect2rect(obj1, obj2)
        return box2dIntersectBox2d(obj1:getBox2d(), obj2:getBox2d())

    elseif obj1.shapeType == POLYGON and obj2.shapeType == CIRCLE then
        return Collision.circle2rect(obj2, obj1)

    elseif obj1.shapeType == CIRCLE and obj2.shapeType == POLYGON then
        return Collision.circle2rect(obj1, obj2)

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

function Collision.circle2rect(obj1, obj2)
    local x1, y1, r1 = obj1:getBoundingCircle()
    local xl2, yb2, xr2, yt2 = obj2:getBoundingBox()

    if x1 < xl2-r1 or x1 > xr2 +r1 or y1 < yb2-r1 or y1 > yt2+r1 then
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

local function sameValue(a, b)
    return abs(a-b) < 1
end

local function samePoint(a, b)
    if sameValue(a.x, b.x) and sameValue(a.y, b.y) then
        return true
    end
    return false
end

function pointOnLine(point, line)
    local a, b = line:fx()

    if b == nil then
        if sameValue(point.x, a) then
            if (
                point.y >= min(line.position.y, line.position.y + line.size.y) and
                point.y <= max(line.position.y, line.position.y + line.size.y))
            then
                return true
            end
        end
        return false
    end

    local resolution = point:clone()
    resolution.y = a * resolution.x + b 

    if samePoint(point, resolution) then
        if (
            resolution.x >= min(line.position.x, line.position.x + line.size.x) and
            resolution.x <= max(line.position.x, line.position.x + line.size.x))
        then
            return true
        end
    end

    return false
end

assert(pointOnLine(vec2(), Rect(0, 0, 0, 100)))

function pointInCircle(point, circle)
    local dist = vec2(point):dist(circle.position)

    if dist <= circle.r then
        return true
    end
    return false
end

function pointInAABB(point, rect)
    return rect:contains(point)
end

function lineIntersectLine(l1, l2)
    local a, b = l1:fx()
    local c, d = l2:fx()

    if b == nil and d == nil then
        return sameValue(a, c)
    end

    local x, y
    if b == nil then
        x = a
        y = c*x+d
    elseif d == nil then
        x = c
        y = a*x+b
    else
        x = (d-b)/(a-c)
        y = a*x+b
        --        y = c*x+d
    end

    local point = vec3(x, y)
    if pointOnLine(point, l1) and pointOnLine(point, l2) then
        return true
    end

    return false
end

function lineIntersectCircle(line, circle)
    if pointInCircle(line.position, circle) or pointInCircle(line.position+line.size, circle) then
        return true
    end
    local ab = line.size

    local circleCenter = circle.position
    local lineStartToCircleCenter = circleCenter - line.position
    local t = lineStartToCircleCenter:dot(ab) / ab:dot(ab)

    if t >= 0 and t <= 1 then
        local closestPoint = line.position + ab * t
        return pointInCircle(closestPoint, circle)
    end

    return false
end

function lineIntersectAABB(line, rect)
    if pointInAABB(line.position, rect) or pointInAABB(line.position+line.size, rect) then
        return true
    end

    local unitVector = line.size:normalize()

    unitVector.x = unitVector.x ~= 0 and (1/unitVector.x) or 0
    unitVector.y = unitVector.y ~= 0 and (1/unitVector.y) or 0

    local leftBottom = (rect:leftBottom() - line.position) * unitVector
    local rightTop = (rect:rightTop() - line.position) * unitVector

    local tmin = max(min(leftBottom.x, rightTop.x), min(leftBottom.y, rightTop.y))
    local tmax = min(max(leftBottom.x, rightTop.x), max(leftBottom.y, rightTop.y))

    if tmax >= 0 and tmin <= tmax then    
        local t = tmin < 0 and tmax or tmin
        return t > 0 and (t * t < line.size:lenSquared())
    end

    return false
end

function rotateLine(line, center, theta)
    local localStart = vec2(line.position):rotate(theta, center)
    local localEnd = vec2(line.position + line.size):rotate(theta, center)

    local localSize = localEnd - localStart
    local localLine = Rect(localStart.x, localStart.y, localSize.x, localSize.y)

    return localLine
end

function lineIntersectBox2d(line, box)
    local localLine = rotateLine(line, box:center(), -box.rotation)
    return lineIntersectAABB(localLine, box)
end

function box2dIntersectBox2d(b1, b2)
    local line = rotateLine(Rect(b1:x1(), b1:y1(), 0, b1:h()), b1:center(), b1.rotation)
    local res = lineIntersectBox2d(line, b2)
    if res then return res end

    line = rotateLine(Rect(b1:x1(), b1:y1(), b1:w(), 0), b1:center(), b1.rotation)
    res = lineIntersectBox2d(line, b2)
    if res then return res end

    line = rotateLine(Rect(b1:x1(), b1:y2(), b1:w(), 0), b1:center(), b1.rotation)
    res = lineIntersectBox2d(line, b2)
    if res then return res end

    line = rotateLine(Rect(b1:x2(), b1:y1(), 0, b1:h()), b1:center(), b1.rotation)
    res = lineIntersectBox2d(line, b2)
    if res then return res end
end

function raycastCircle(ray, circle)
    local raycast = {}

    local rayPosition = ray.position
    local rayDirection = ray.size:normalize()

    local originToCircle = circle.position - rayPosition

    local radiusSquared = circle.r * circle.r

    local originToCircleLenSquared = originToCircle:lenSquared()

    -- project the vector from the ray origin onto the direction of the ray
    local a = originToCircle:dot(rayDirection)
    local bSquared = originToCircleLenSquared - a^2

    if radiusSquared - bSquared < 0 then
        return nil
    end

    local f = sqrt(radiusSquared - bSquared)
    local t = 0

    if originToCircleLenSquared < radiusSquared then
        -- ray starts inside the circle
        t = a + f
    else
        t = a - f
    end

    if t < 0 then
        return nil
    end

    raycast.point = rayPosition + rayDirection * t
    raycast.normal = (raycast.point - circle.position):normalize()
    raycast.t = t

    return raycast
end
