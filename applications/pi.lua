function setup()

    throws = 0
    inCircle = 0

    parameter.watch('4 * inCircle / throws')
    parameter.watch('throws')

    seed(os.time())

    noFill()

    stroke(white)
    strokeWidth(2)

    translate(W/2, H/2)

    radius = 250
    diameter = radius * 2

    circle(0, 0, radius)

    fill(red)

    img = Image(diameter, diameter)

    clr = color.random():alpha(.2)

end

function update(dt)
end

function draw()

    setContext(img)
    background(color(0, 0, 0, 0.01))
    setContext()

    blendMode(NORMAL)

    if random() < 0.05 then
        clr = color.random():alpha(.2)
    end

    local sqrt, random = math.sqrt, math.random

    local x, y, len

    for i=1,10^5 do

        x = random()
        y = random()

        len = (
            (x*2-1)^2 +
            (y*2-1)^2)

        throws = throws + 1

        if len <= 1 then
            inCircle = inCircle + 1
            img:set(x*diameter, y*diameter, clr)
        else
            img:set(x*diameter, y*diameter, blue)
        end
    end    

    translate(W/2, H/2)

    spriteMode(CENTER)
    sprite(img, 0, 0)

end
