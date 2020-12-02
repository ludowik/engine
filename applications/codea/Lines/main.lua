
function setup()
    -- Expose parameters to control our line

    -- The start point
    parameter.number("x1", 0, W, 100)
    parameter.number("y1", 0, H, 100)

    -- The end point
    parameter.number("x2", 0, W, W/2)
    parameter.number("y2", 0, H, H/2)

    -- The stroke width
    parameter.number("width",1, 100, 25)

    -- The line cap type
    parameter.integer("lineCap", 0, 2, ROUND)
    parameter.boolean("smoothCap")
end

function draw()
    background(10,10,20)

    -- Set stroke and fill color to white
    fill(255,0,0)
    stroke(255)

    -- Update stroke width
    strokeWidth(width)

    if width < 3 or smoothCap == false then
        -- Disable smoothing for low widths
        noSmooth()
    else
        smooth()
    end

    stroke(blue)
    lineCapMode(PROJECT)
    line(x1, y1, x2, y2)

    stroke(white)
    lineCapMode(lineCap)
    line(x1, y1, x2, y2)
end
