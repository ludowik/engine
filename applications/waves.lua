function setup()
    size = 100
    
    img1 = Image(size)
    img2 = Image(size)
end

function update(dt)
    local r
    for x=2,size-1 do
        for y=2,size-1 do
            r = (
                img1:get(x-1, y).r +
                img1:get(x+1, y).r +
                img1:get(x, y-1).r +
                img1:get(x, y+1).r
                ) / 2 - img2:get(x, y).r
            
            img2:set(x, y, r, r, r)
        end
    end

    img1, img2 = img2, img1
end

function draw()
    spriteMode(CORNER)
    sprite(img1)
    
    noFill()
    rect(0, 0 , size, size)
end

function touched(touch)
    img1:set(touch.x, touch.y, 1, 1, 1)
end
