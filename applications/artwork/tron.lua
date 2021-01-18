function setup()
    stars = {}
    for i=1,1000 do
        stars[i] = {
            angle = random(TAU),
            angularSpeed = random(-0.01, -0.1),
            
            len = 0,
            linearSpeed = random(2, 15),
            
            width = random(1,5),
            
            clr = Color.random()
        }
    end
    
    parameter.number('speed', 0, 50, 20)
end

function draw(dt)
    noStroke()

    fill(0, 0, 0, 0.05)

    rectMode(CORNER)
    rect(0, 0, WIDTH, HEIGHT)

    translate(W/2, H/2)
    
    area = Rect(-W/2, -H/2, W, H)

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

        star.angle = star.angle + star.angularSpeed * speed * DeltaTime
        star.len = star.len + star.linearSpeed * speed * DeltaTime
        
        if not area:contains(position) then
            star.len = 0
        end
    end
end
