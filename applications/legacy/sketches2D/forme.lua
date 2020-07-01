function setup()
    local x, y = WIDTH/2, HEIGHT/2
    vertices = Table{vec2(x, y)}

    function animate(n)
        local r = 200
        local a = 0
        
        for i=#vertices,n-1 do
            vertices:add(vertices[#vertices]:clone())
        end
        
        for i=1,n do
            tween(0.5, vertices[i],
                vec2(
                    x + cos(a) * r,
                    y + sin(a) * r),
                tween.easing.linear,
                function ()
                    if i == n and n < 20 then
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
    noFill()
    
    if #vertices > 2 then
        polyline(vertices)
    end
    
    for i,pos in ipairs(vertices) do
        points(pos.x, pos.y)
    end   
end
