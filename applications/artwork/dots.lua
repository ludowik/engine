function setup()
    xx = 0
    yy = 0

    t = 0

    angle = 0
end

function draw()
    background(51)

    blendMode(ADDITIVE)

    noStroke()

    local radius = 14
    local dx = 0

    t = t + 1

    if t > 0 then
        xx = xx + 1
        yy = yy + 1
    end

    if xx >= radius*4 then
        t = -10
        xx = 0
    end

    if yy >= radius*4 then
        t = -10
        yy = 0
    end

    for y=-radius*4,HEIGHT+radius*4,radius*4 do
        if dx == 0 then
            dx = radius*2
        else
            dx = 0
        end

        for x=-radius*4+dx,WIDTH+radius*4,radius*4 do
            fill(red)
            circle(x+xx, y, radius)

            fill(green)
            circle(x+yy/2, y+yy, radius)

            fill(blue)
            circle(x, y, radius)
        end
    end
end
