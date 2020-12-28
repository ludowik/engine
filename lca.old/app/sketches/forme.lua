function setup()
    local x, y = WIDTH/2, HEIGHT/2
    points = Table{vector(x, y)}

    function animate(n)
        local r = 50
        local a = 0
        
        for i=#points,n-1 do
            points:add(vector(points[#points]))
        end
        
        for i=1,n do
            tween(0.5, points[i],
                vector(
                    x + cos(a) * r,
                    y + sin(a) * r),
                tween.easing.linear,
                function ()
                    if i == n and n < 20 then
                        animate(n+1)
                    end
                end)
            
            a = a + 2 * pi / n
        end
    end
    
    animate(1)
end

function draw()
    background(51)
    
    stroke(white)
    noFill()
    
    if #points > 2 then
        polygon(points, true)
    end
    
    for i,pos in ipairs(points) do
        point(pos.x, pos.y)
    end   
end

