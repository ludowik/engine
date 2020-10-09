function draw()
    background(51)

    function drawBlendMode(mode, x, y, r)
        blendMode(mode)

        fill(red)
        circle(x-r/2, y-r/2, r)

        fill(green)
        circle(x+r/2, y-r/2, r)

        fill(blue)
        circle(x, y+r/2, r)
    end

    drawBlendMode(NORMAL, W/4, H/2, 100)
    drawBlendMode(ADDITIVE, W/2, H/2, 100)
    drawBlendMode(MULTIPLY, W/(4/3), H/2, 100)
end
