function setup()
    marge = 10

    if WIDTH < HEIGHT then
        diameter = (min(WIDTH, HEIGHT) - marge) / 10
    else
        diameter = (min(WIDTH, HEIGHT) - marge) / 10
    end

    radius = diameter / 2.5
end

function draw()
    ortho()

    background(51)

    translate(W/2, H/2)

    stroke(gray)
    line(-W, 0, W, 0)
    line(0, -H, 0, H)

    stroke(white)

    fontSize(s10)
    textMode(CENTER)

    for m = 1,9 do
        local x = radius + diameter * (m-1) - (9 * diameter) / 2

        for n = 1,9 do
            local y = radius + diameter * (n-1) - (9 * diameter) / 2

            noFill()
            beginShape()
            for angle = 0, TAU * n, 0.05 do                    
                local r = radius * cos(angle * m / n)
                vertex(
                    x + r * cos(angle),
                    y + r * sin(angle))                    
            end            
            endShape(CLOSE)

            fill(white)
            text(string.format('%.2f', m/n), x, y + diameter/2)
        end
    end
end
