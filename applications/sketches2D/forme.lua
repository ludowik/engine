function setup()
    local x, y = WIDTH/2, HEIGHT/2

    vertices = Buffer('vec3', {vec3(x, y)})

    N = 100

    function animate(n)
        local r = 360
        local a = 0

        for i=#vertices,n-1 do
            vertices:add(vertices[#vertices]:clone())
        end

        for i=1,n do
            tween(0.2, vertices[i],
                vec3(
                    x + cos(a) * r,
                    y + sin(a) * r
                ),
                tween.easing.linear,
                function ()
                    if i == n and n < N then
                        tween.stopAll()
                        animate(n+1)
                    end
                end)

            a = a + 2 * PI / n
        end
    end

    animate(1)
end

function draw()
    background(51)

    stroke(white)
    strokeWidth(0.5)

    noFill()

    if #vertices > 2 then
        polyline(vertices)
    end

    stroke(red)
    strokeWidth(5)

    points(vertices)
end
