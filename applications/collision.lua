function setup()
end

function draw()
    l = Rect(100, 100, 340, 454)

    if pointOnLine(CurrentTouch, l) then
        stroke(red)
    else
        stroke(white)
    end

    line(l:x1(), l:y1(), l:x2(), l:y2())
    
    c = {x=500, y=200, r=34}
    
    if pointInCircle(CurrentTouch, c) then
        fill(red)
    else
        fill(white)
    end
    noStroke()
    
    circle(c.x, c.y, c.r)
    
    l = Rect(640, 300, 140, 154)

    if pointInRect(CurrentTouch, l) then
        fill(red)
    else
        fill(white)
    end
    noStroke()

    rect(l:x1(), l:y1(), l:w(), l:h())
end

function samePoint(a, b)
    if abs(a.x-b.x) < 1 and abs(a.y-b.y) < 1 then
        return true
    end
end

function pointOnLine(point, line)
    local a, b = line:fx()
    
    local resolution = point:clone()
    resolution.y = a * resolution.x + b 

    if samePoint(point, resolution) then
        return true
    end
    return false
end

function pointInCircle(point, circle)
    local dist = vec2(point):dist(circle)
    
    if dist <= circle.r then
        return true
    end
    return false
end

function pointInRect(point, rect)
    return rect:contains(point)
end
