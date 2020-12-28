function setup()
    marge = 10

    if WIDTH < HEIGHT then
        diameter = (min(WIDTH, HEIGHT) - marge) / 7
    else
        diameter = (min(WIDTH, HEIGHT) - marge) / 11
    end
    
    radius = diameter / 2 - 2

    shapes = {}
end

function draw()
    ortho()

    background(51)
    noFill()

    for m = 1,7 do
        local x = radius + diameter * (m-1) + (WIDTH - 7 * diameter) / 2

        for n = 1,9 do
            local y = radius + diameter * (n-1) + (HEIGHT - 9 * diameter) / 2

            local shape = shapes[m..'.'..n]
            if shape == nil then
                beginShape()                
                for angle = 0, tau*n, 0.05 do                    
                    local r = radius * cos(m * angle / n)
                    vertex(
                        x + r * cos(angle),
                        y + r * sin(angle))                    
                end            
                endShape(CLOSE)

                shapes[m..'.'..n] = getShape()
            else
                polygon(shape)
            end
        end
    end
end
