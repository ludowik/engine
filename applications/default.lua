function setup()
<<<<<<< HEAD
    local pixelSize = 8

    img = image(
        floor(W/pixelSize),
        floor(H/pixelSize))

    img2 = image(
        floor(W/pixelSize),
        floor(H/pixelSize))

    setContext(img)
    background(0, 0, 0, 1)

    local pixels = img:getPixels()
    local pixels2 = img2:getPixels()

    local i = 0
    for x=0,img.width-1 do
        for y=0,img.height-1 do
            pixels[i] = random(255)
            pixels[i+1] = random(255)
            pixels[i+2] = random(255)
            pixels[i+3] = 255
            pixels2[i] = pixels[i]
            pixels2[i+1] = pixels[i+1]
            pixels2[i+2] = pixels[i+2]
            pixels2[i+3] = 255
            i = i + 4
        end
    end

    img:update(true)

    setContext(img2)
    spriteMode(CORNER)
    sprite(img)
    img2:update(true)

    config.interpolate = false
    parameter.boolean('config.interpolate', false)
end

function update()
    local pixels = img:getPixels()
    local pixels2 = img2:getPixels()

    local i, r, d = 0, 0
    for x=0,img.width-1 do
        for y=0,img.height-1 do
            r = pixels[i]

            d = randomInt(0, r)            
            d = d - ((pixels2[i]+d) - min(255, (pixels2[i]+d)))

            pixels2[i] = pixels2[i] - d
            pixels2[(i+img.width)%img.width] = pixels2[(i+img.width)%img.width] + d

            i = i + 4
        end
    end

    img2:update(true)

    img, img2 = img2, img
end

function draw()
    scale(W/img.width)

    spriteMode(CORNER)
    sprite(img)
end
=======
    
end
>>>>>>> 6898a62866b2a3ab3743e1720f5b598410b510ed
