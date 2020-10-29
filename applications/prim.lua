function setup()
    m = Model.rect(0, 0, 100, 100)
    m.shader = Shader('default')
end

function draw()
    background()
    translate(W/2, H/2)

    stroke(red)
    strokeWidth(50)

    fill(blue)

--    m:draw()

    lineCapMode(ROUND)
--    line(0, 0, 100, 100)

    polyline({
            vec3(0, 0),
            vec3(100, 100)
        })
end
