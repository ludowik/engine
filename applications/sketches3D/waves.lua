function setup()
    size = W

    buf1 = Buffer('float'):resize(size^2)
    buf2 = Buffer('float'):resize(size^2)

    damping = 0.95

    img = Image(size, size)
    img:background(black)
end

function update(dt)
    pixels = img:getPixels()

    for i=1,2 do
        step()
    end

    waterDrop(random(size), random(size), random(100, 1000))
    
    img:setPixels(pixels)
end

function step()
    local index, offset, value, brigthness

    index = getOffset(2, 2-1)

    for y=2,size-1 do        
        for x=2,size-1 do
            value = (
                buf1[index-1] +
                buf1[index+1] +
                buf1[index-size] +
                buf1[index+size]
                ) * 0.5 - buf2[index]

            value = value * damping
            
            buf2[index] = value

            brigthness = 128 + value * 128
            
            offset = (index -1) * 4
            pixels[offset  ] = brigthness
            pixels[offset+1] = brigthness
            pixels[offset+2] = brigthness

            index = index + 1
        end

        index = index + 2
    end

    buf1, buf2 = buf2, buf1
end

function getOffset(x, y)
    return round(x) + round(y) * size
end

function draw()
    background(black)

    spriteMode(CORNER)
    sprite(img)

    noFill()

    rectMode(CORNER)
    rect(0, 0 , size, size)
end

function touched(touch)
    waterDrop(touch.x, touch.y)
end

function waterDrop(x, y, h)
    local offset = getOffset(x, y)
    buf1[offset] = h
end
