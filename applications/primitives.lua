function setup()
    test = Shader('test')

    m = Mesh()

    m.vertices = Buffer('vec3', 
        {vec3(), vec3(), vec3(), vec3()})

    parameter.boolean('withStroke', true)
end

function draw()

    background(cyan)

    stroke(black)

    fill(gray)

    local x, y = 10, H/3

    for i=1,80,5 do
        y = 50
        if withStroke then
            strokeWidth(floor(i/5))
        else
            strokeWidth(0)
        end

        y = y + 100
        point(x, y)

        y = y + 100
        circle(x, y, i)

        y = y + 100
        line(x+10, y+10, x+10, y+80)

        y = y + 100
        line(x+10, y+10, x+80, y+80)

        y = y + 100
        lines{
            vec3(x+10, y+10), vec3(x+80, y+80),
            vec3(x+50, y+50), vec3(x+70, y+80),
        }

        x = x + i * 2
    end

    strokeWidth(1)
    stroke(red)
    line(0, y, W, y)

end
