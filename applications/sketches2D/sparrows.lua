class 'Sparrow'

function Sparrow:init()
    self.position = vec2.random(W, H)

    self.force = vec2.random(10)
    self.speed = vec2()
end

function setup()
    sparrows = Table()

    maxSpeed = 250

    minDist = 100
    maxDist = 150

    nSparrows = 200

    for i=1,nSparrows do
        local sparrow = Sparrow()
        sparrows:add(sparrow)
    end

    attractions = Table()

    parameter.watch('#attractions')

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

        s1.position.x = s1.position.x + dt * s1.speed.x
        s1.position.y = s1.position.y + dt * s1.speed.y

        s1.speed:mul(1 - 0.05 * dt)

        if s1.position.x < 0 or s1.position.x > WIDTH then
            s1.speed.x = -s1.speed.x
        end

        if s1.position.y < 0 or s1.position.y > HEIGHT then
            s1.speed.y = -s1.speed.y
        end

        if s1.speed:len() > maxSpeed then
            s1.speed:normalizeInPlace(maxSpeed)
        end

        for j=i+1,#sparrows do
            local s2 = sparrows[j]

            if s2 and i ~= j then
                local dist = vec2.dist(s1.position, s2.position)
                if dist < minDist then
                    local repulsion = map(dist, 0, minDist, 1, 0)
                    force = force - repulsion

                    local v = vec2.random(100) * repulsion
                    s1.force = s1.force - v
                    s2.force = s2.force + v

                elseif dist < maxDist then
                    local attraction = map(dist, minDist, maxDist, 1, 0.5)
                    force = force + attraction

                    local direction = (s2.position-s1.position):normalizeInPlace(100 * attraction)

                    s1.force:sub(direction)
                    s2.force:add(direction)
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
        circle(s1.position.x, s1.position.y, 2.5)
    end
end

function touched(touch)
    if touch.state == BEGAN then
        attraction = touch
    end
end
