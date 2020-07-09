function draw()
--    background(red)

    ortho()
    
    strokeWidth(10)
    
    line (100, 100, mouse.x, mouse.y)

    x1 = math.random(W)
    y1 = math.random(H)

    x2 = math.random(W)
    y2 = math.random(H)

    for i=1,100 do
        local clr = Color.random()
        
        stroke(clr)
        
        strokeWidth(math.random(20))
        
        line(x1, y1, x2, y2)

        x2, y2 = x1, y1

        x2 = math.random(W)
        y2 = math.random(H)
    end
end

function setup()
end
