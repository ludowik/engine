
-- Use this function to perform your initial setup
function setup()
    print("An example that shows how to use the Gravity vector")

    -- Watch the "Gravity" variable
    parameter.watch( "Gravity" )
end

-- This function gets called once every frame
function draw()
    background(127, 127, 127, 255)

    stroke(255, 255, 255, 255)
    strokeWidth(15)

    lineCapMode(ROUND)

    pushMatrix()

    translate(WIDTH/2, HEIGHT/2)

    grav = vec2(Gravity.x * 300, Gravity.y * 300)

    --print(grav)

    line(0, 0, grav.x, grav.y)

    -- Arrowhead
    down = vec2(1, 0)
    orient = down:angleBetween(grav)

    pushMatrix()
    resetMatrix()

    translate(WIDTH/2,HEIGHT/2)
    translate(grav.x,grav.y)
    rotate(math.deg(orient))

    line(0, 0, -25, -20)
    line(0, 0, -25,  20)

    popMatrix()
    -- End Arrowhead

    popMatrix()
end
