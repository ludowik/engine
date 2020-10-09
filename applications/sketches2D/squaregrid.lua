function setup()
    xx = 0
    yy = 0

    t = 0

    angle = 0
end

function update(dt)
    if t <= 0 then
        angle = angle + dt * 30
    else
        t = t - dt * 60
    end
    if angle >= 90 then
        angle = 0
        t = 15
    end
end

function draw()
    background()

    noStroke()
    fill(white)

    rectMode(CENTER)

    translate(0, (HEIGHT-WIDTH)/2)

    local w = 50
    for x=0,WIDTH,w do
        for y=0,WIDTH,w do
            pushMatrix()
            do
                da = angle%90
                da = abs(da-45)
                da = (da+45)/90
                translate(x, y)
                rotate(angle)
                rect(0, 0, w*da, w*da)
            end
            popMatrix()
        end
    end
end
