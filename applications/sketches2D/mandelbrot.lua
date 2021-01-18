function setup()
    y = 1
end

function draw()
    local x1 = -2.1
    local x2 =  0.6
    
    local y1 = -1.2
    local y2 =  1.2
    
    local zoom = 100 -- pour une distance de 1 sur le plan, on a 100 pixel sur l'image
    
    local iteration_max = 50

    local image_x = (x2 - x1) * zoom
    local image_y = (y2 - y1) * zoom

    img = img or Image(image_x, image_y)
    
    for x = 1,image_x do
        -- for y = 1, image_y do
            local c_r = x / zoom + x1
            local c_i = y / zoom + y1
            
            local z_r = 0
            local z_i = 0
            
            local i = 0

            while z_r*z_r + z_i*z_i < 4 and i < iteration_max do
                local tmp = z_r
                
                z_r = z_r^2 - z_i^2 + c_r
                z_i = 2 * z_i * tmp + c_i
                
                i = i + 1
            end

            if i == iteration_max then
                img:set(x, y, black)
            else
                img:set(x, y, rgb(0, 0, i*255/iteration_max))
            end
        -- end
    end
    
    y = y % image_y + 1
    
    translate(W/2, H/2)
    
    spriteMode(CENTER)
    sprite(img) --, -x1*zoom, -y1*zoom)
end
