function setup()
    angle = 0
end


function update(dt)
    angle = angle +dt
end

function draw()
    background(51)

    l1 = Rect(100, 100, 340, 454)
    l2 = Rect(100, 100, 0, 454)

    lmouse = Rect(
        CurrentTouch.x-20, CurrentTouch.y-20,
        60, 40)

    function testPointOnLine(point, l)
        if lineIntersectLine(lmouse, l) or pointOnLine(point, l) then
            stroke(red)
        else
            stroke(white)
        end

        line(l:x1(), l:y1(), l:x2(), l:y2())
    end

    testPointOnLine(CurrentTouch, l1)
    testPointOnLine(CurrentTouch, l2)

    c1 = {position=vec2(500, 200), r=34}

    if lineIntersectCircle(lmouse, c1) then
        fill(blue)
    elseif pointInCircle(CurrentTouch, c1) then
        fill(red)
    else
        fill(white)
    end

    local raycast = raycastCircle(lmouse, c1)
    if raycast then
        stroke(red)
        strokeWidth(5)
        point(raycast.point)
        line(
            raycast.point.x, raycast.point.y,
            raycast.point.x + raycast.normal.x*10, raycast.point.y + raycast.normal.y*10)
    else
        noStroke()
    end

    circleMode(CENTER)
    circle(c1.position.x, c1.position.y, c1.r)

    r1 = Rect(640, 300, 140, 154)
    r1.rotation = angle

    if lineIntersectBox2d(lmouse, r1) then
        fill(blue)
    elseif pointInAABB(CurrentTouch, r1) then
        fill(red)
    else
        fill(white)
    end
    noStroke()

    pushMatrix()
    translate(r1:xc(), r1:yc())
    rotate(deg(r1.rotation))
    rectMode(CENTER)
    rect(0, 0, r1:w(), r1:h())
    popMatrix()

    -- cursor position
    stroke(blue)
    strokeWidth(2)
    point(CurrentTouch.x, CurrentTouch.y)

    line(lmouse:x1(), lmouse:y1(), lmouse:x2(), lmouse:y2())
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

function lineIntersectBox2d(line, box)
    local theta = -box.rotation
    local center = box:center()
    local localStart = vec2(line.position):rotate(theta, center)
    local localEnd = vec2(line.position + line.size):rotate(theta, center)

    local localSize = localEnd - localStart
    local localLine = Rect(localStart.x, localStart.y, localSize.x, localSize.y)

    return lineIntersectAABB(localLine, box)
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
