function setup()
    sparrows = Table()

    maxSpeed = 250

    minDist = 100
    maxDist = 150

    nSparrows = 200

    for i=1,nSparrows do
        local sparrow = vec2.random()
        sparrows:add(sparrow)

        sparrow.force = vec2()
        sparrow.speed = vec2()
    end

    attractions = Table()
    parameter.watch('#attractions')
end

do
    local xc, yc = 0, 0
    function moveTo(x, y)
        xc, yc = x, y
    end
    function lineTo(x, y)
        line(xc, yc, x, y)
        xc, yc = x, y
    end
end

function update(dt)    
    local force = 0
    for i=1,#sparrows do
        local s1 = sparrows[i]

        s1.speed.x = s1.speed.x + s1.force.x * dt
        s1.speed.y = s1.speed.y + s1.force.y * dt

        s1.force = vec2()

        s1.x = s1.x + dt * s1.speed.x
        s1.y = s1.y + dt * s1.speed.y

        s1.speed = s1.speed - s1.speed * 0.05 * dt

        if s1.x < 0 or s1.x > WIDTH then
            s1.speed.x = -s1.speed.x
        end

        if s1.y < 0 or s1.y > HEIGHT then
            s1.speed.y = -s1.speed.y
        end

        if s1.speed:len() > maxSpeed then
            s1.speed = s1.speed:normalize() * maxSpeed
        end

        for j=i+1,#sparrows+1 do
            local s2
            if j <= #sparrows then
                s2 = sparrows[j]
            else
                s2 = CurrentTouch
            end

            if s2 and i ~= j then
                local dist = vec2.dist(s1, s2)
                if false and  dist < minDist then
                    local repulsion = map(dist, 0, minDist, 1, 0)
                    force = force - repulsion

                    local v = vec2.random(100) * repulsion
                    s1.force = s1.force - v
                    s2.force = s2.force + v

                elseif dist < maxDist then
                    local attraction = map(dist, minDist, maxDist, 1, 0.5)
                    force = force + attraction

                    local direction = (s1 - s2):normalize() * 100 * attraction
                    s1.force = s1.force - direction
                    s2.force = s2.force + direction
                end
            end
        end
    end
    attractions:add(force)
end

function draw()
    background()

    do
        pushMatrix()

        stroke(white)

        translate(0, HEIGHT/2)
        moveTo(0, 0)

        local x = 0
        local start = max(1, #attractions-100)

        for i=start,#attractions do
            lineTo(x, attractions[i]/1000)
            x = x + 1
        end
        popMatrix()
    end

    for i=1,#sparrows do
        local s1 = sparrows[i]
        circle(s1.x, s1.y, 2.5)
    end
end

function touched(touch)
    if touch.state == BEGAN then
        attraction = touch
    end
end
