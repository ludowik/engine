function setup()
    vertices = Table()
    colors = Table()
    for i=1,6 do
        vertices:add(vector.random())
        colors:add(color.random())
    end

    function nextPosition(i)
        local easing = randomInt(1, #tween.easingList)
        tween(
            random(0.8, 1.5),
            vertices[i],
            vector.random(),
            tween.easingList[easing],
            function ()
                nextPosition(i)
            end)
    end

    function nextColor(i)
        tween(random(0.8, 1.5),
            colors[i],
            color.random(),
            tween.easingList[easing],
            function ()
                nextColor(i)
            end)
    end

    for i=1,#vertices do
        nextPosition(i)
        nextColor(i)
    end
end

function draw()
    noStroke()
    fill(0, 0, 0, 0.02)
    
    rectMode(CORNER)
    rect(0, 0, WIDTH, HEIGHT)
    
    noFill()

    local function drawLines()        
        translate(3, 3)

        strokeWidth(2)

        local n = #vertices
        for i=1,n-1 do
            stroke(colors[i])
            line(vertices[i].x, vertices[i].y, vertices[i+1].x, vertices[i+1].y)
        end
        
        stroke(colors[n])
        line(vertices[n].x, vertices[n].y, vertices[1].x, vertices[1].y)
    end

    for i=1,5 do
        drawLines()
    end
end
