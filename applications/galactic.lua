function setup()
    stars = {}
    for i=1,1000 do
        stars[i] = {
            angle = random(TAU),
            len = random(W/2),
            width = random(1,5),
            speed = random(-0.001, -0.01),
            clr = Color.random()
        }
    end
    
    parameter.number('speed', 0, 5, 0)
end

function draw()
    noStroke()

    fill(0, 0, 0, 0.05)

    rectMode(CORNER)
    rect(0, 0, WIDTH, HEIGHT)

    translate(W/2, H/2)

    local position = vec3()
    
    local star
    for i=1,#stars do
        star = stars[i]

        position:set(
            cos(star.angle),
            sin(star.angle))
        :normalizeInPlace(star.len)

        stroke(star.clr)
        strokeWidth(star.width)

        point(position)

        star.angle = star.angle + star.speed * speed
    end
end
