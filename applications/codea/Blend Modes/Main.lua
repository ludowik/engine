-- Blend Modes
function setup()
    print("This demonstrates blending modes. Blend modes determine how drawing operations blend together on-screen.")
    print()
    print("The top pair of ellipses uses normal blending.")
    print()
    print("The middle uses additive.")
    print()
    print("And the bottom uses multiplicative blending.")

    size = HEIGHT/4
end

function drawEllipsePair( x, y )
    -- Draws two ellipses, overlapping

	ellipse(x - size/6, y, size/2)
    ellipse(x + size/6, y, size/2)
end

-- This function gets called once every frame
function draw()
    -- Set a plain gray background
    background(69, 80, 96, 255)

    -- This sets the line thickness
    strokeWidth(5)

    -- This sets the outline & fill colors
    stroke(206, 179, 179, 255)
    fill(207, 52, 13, 255)

    -- We're going to draw three pairs of overlapping ellipses
    -- The first with NORMAL blend mode
    blendMode(NORMAL)
    drawEllipsePair(WIDTH/2, size*1)

    -- The second with ADDITIVE blend mode
    blendMode(ADDITIVE)
    drawEllipsePair(WIDTH/2, size*2)

    -- The last with MULTIPLY blend mode
    blendMode(MULTIPLY)
    drawEllipsePair(WIDTH/2, size*3)
end

