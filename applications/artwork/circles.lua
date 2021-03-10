function setup()
    background(white)
end

function draw()
    noStroke()

    fill(1, 1, 1, 0.6)

    rectMode(CORNER)
    rect(0, 0, WIDTH, HEIGHT)

    noFill()

    circleMode(CENTER)

    drawCircles(1, 0.25)
    drawCircles(2, 0.2)
    drawCircles(20)
end

function drawCircles(n, a)
    local w = ceil(H / (n+1))

    for x = 0,2+n*W/H do
        for y = 0,n+1 do
            local radius = w / 2 * sin(ElapsedTime+100*noise(x, y))

            local r = 0.5+cos(rad(ElapsedTime*10*noise(x, y)))/2

            fill(1-r, 0.25, 0.5, a)
            
            strokeWidth(sin(ElapsedTime*noise(x, y))*radius)
            stroke(r, 0.5, 0.5, a)

            circle(x*w, y*w, abs(radius))
        end
    end
end
