function setup()
    size = 500

    damping = 0.9

    buf1 = Buffer('float'):resize(size*size)
    buf2 = Buffer('float'):resize(size*size)

    img = Image(size, size)
end

function update(dt)
    local r, offset, pixels

    pixels = img:getPixels()

    for x=2,size-1 do
        for y=2,size-1 do
            offset = (x-1) + (y-1) * size

            r = (
                buf1[offset-1] +
                buf1[offset+1] +
                buf1[offset-size] +
                buf1[offset+size]
                ) / 2 - buf2[offset]

            r = r * damping

            buf2[offset] = r

            pixels[offset*4+0] = r * 255            
            pixels[offset*4+1] = r * 255
            pixels[offset*4+2] = r * 255
            pixels[offset*4+3] = 255
        end
    end

    img:update(true)

    buf1, buf2 = buf2, buf1
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
    local offset = floor(touch.x + touch.y * size)
    buf1[offset] = 255
end
