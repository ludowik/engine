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
        65, 40)

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

    function drawRaycast(raycast)
        if raycast then
            strokeWidth(5)
            stroke(red)
            line(
                raycast.point.x, raycast.point.y,
                raycast.point.x + raycast.normal.x*10, raycast.point.y + raycast.normal.y*10)
            strokeWidth(10)
            stroke(red)
            point(raycast.point)
        end
    end
    
    drawRaycast(raycastCircle(lmouse, c1))

    circleMode(CENTER)
    circle(c1.position.x, c1.position.y, c1.r)

    r1 = Rect(640, 300, 140, 154)
    r1.rotation = angle
    
    local c1, c2, c3
    if lineIntersectBox2d(lmouse, r1) then
        c1 = blue
    elseif pointInAABB(CurrentTouch, r1) then
        c1 = red
    else
        c1 = white
    end

    r2 = Rect(830, 300, 120, 154)
    r2.rotation = -angle

    if box2dIntersectBox2d(r2, r1) then
        c2 = green
    else
        c2 = white
    end
    
    r3 = Rect(640, 600, 140, 154)
    drawRaycast(raycastBox2d(lmouse, r3))
    drawRaycast(raycastBox2d(lmouse, r2))
    
    if lineIntersectBox2d(lmouse, r3) then
        c3 = brown
    else
        c3 = white
    end

    function drawRect(r, clr)
        noStroke()
        fill(clr or white)
        pushMatrix()
        translate(r:xc(), r:yc())
        rotate(deg(r.rotation))
        rectMode(CENTER)
        rect(0, 0, r:w(), r:h())
        popMatrix()
    end

    drawRect(r1, c1)
    drawRect(r2, c2)
    drawRect(r3, c3)

    -- cursor position
    stroke(blue)
    strokeWidth(2)
    point(CurrentTouch.x, CurrentTouch.y)

    line(lmouse:x1(), lmouse:y1(), lmouse:x2(), lmouse:y2())
end
