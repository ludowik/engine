Test1 = class()

function Test1:name()
    return "Codea Primitives in 3D"
end

function Test1:init()
    -- you can accept and set parameters here
end

function Test1:draw()
    -- Preserve existing transform and style
    pushMatrix()
    pushStyle()

    -- This sets the line thickness
    stroke(white)
    strokeWidth(5)

    smooth()
    rectMode(CENTER)

    -- Make a floor
    translate(0,-lSize/2,0)
    rotate(Angle,0,1,0)
    rotate(90,1,0,0)
    sprite("SpaceCute:Background", 0, 0, 300, 300)

    -- Rotate and translate the square
    resetMatrix()
    rotate(Angle,0,1,0)
    translate(0, 0, -100)

    fill(44, 97, 161, 255)
    rect(0, 0, lSize, lSize)

    resetMatrix()
    rotate(Angle,0,1,0)
    fill(191, 26, 26, 255)
    ellipse(0, 0, lSize*0.8)

    -- Restore transform and style
    popStyle()
    popMatrix()
end