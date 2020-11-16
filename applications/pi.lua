function setup()

    throws = 0
    inCircle = 0

    parameter.watch('4 * inCircle / throws')
    parameter.watch('throws')

end

function update(dt)
end

function draw()

    noFill()

    stroke(white)
    strokeWidth(2)

    translate(W/2, H/2)

    local r = 250
    circle(0, 0, r)

    fill(red)

    local p = vec2()    
    for i=1,1000 do
        p:set(
            random.random() * 2 - 1,
            random.random() * 2 - 1)

        point(
            p.x * r,
            p.y * r)

        throws = throws + 1

        if p:len() < 1 then
            inCircle = inCircle + 1
        end
    end

end
