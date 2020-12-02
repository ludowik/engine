function setup()
    m = Mesh()
    m.vertices = Buffer('vec3', 
        {vec3(), vec3(), vec3(), vec3()})

    parameter.boolean('withStroke', true)
end

function draw()

    background(cyan)

    stroke(black)

    fill(gray)

    local x, y, h = 10, 0, 50

    for i=1,80,5 do
        y = 50
        
        if withStroke then
            strokeWidth(floor(i/5))
        else
            strokeWidth(0)
        end

--        y = y + h
--        point(x, y)

--        y = y + h
--        circle(x, y, i)

--        y = y + h
--        line(x+10, y+10, x+10, y+80)

--        y = y + h
--        line(x+10, y+10, x+80, y+80)

        y = y + h
        polygon {
            vec3(x+10, y+10), vec3(x+80, y+80),
            vec3(x+10, y+80), vec3(x+10, y+80)
        }

        x = x + i * 2
    end

end
