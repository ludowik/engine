function setup()
    start = 0

    img = image(WIDTH, HEIGHT)
    
    parameter.number('factor', 0, 100, 50, function()
            generateImg()
        end)
end

function generateImg()
    local r
    for x=0,WIDTH do
        for y=0,HEIGHT do
            r = noise((x)/factor, (y)/factor)
            img:set(x, y, r, r, r, 1)
        end
    end
end

function update(dt)
    start = start + 2
end

function draw()
    background()
    
    spriteMode(CORNER)
    sprite(img, 0, 0)

    local y = HEIGHT / 2
    local h = 100

noFill()

    beginShape()
    for x=0,WIDTH do
        vertex(x, y+noise((start+x)/factor)*h)
    end
    endShape(false)

    stroke(red)
    line(0, y, WIDTH, y)

    stroke(blue)
    line(0, y+h, WIDTH, y+h)

    line(WIDTH /2, 0, WIDTH / 2, HEIGHT)
end
