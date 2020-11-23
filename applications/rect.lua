function setup()
    parameter.boolean('use_stroke', true)
    parameter.boolean('use_fill')
    
    parameter.number('use_strokeWidth', 0, 50, 5)
    
    parameter.number('use_angle', 0, 360, 0)
end

function draw()
    background(51)
    
    if use_stroke then
        stroke(cyan)
    else
        noStroke()
    end
    
    strokeWidth(use_strokeWidth)

    if use_fill then
        fill(magenta)
    else
        noFill()
    end
    
    translate(200, 200)
    rotate(use_angle)
    
    rectMode(CENTER)
    rect(0, 0, 200, 300)

    rotate(-use_angle)
    translate(400, 0)
    rotate(use_angle)
    
    ellipseMode(CENTER)
    ellipse(0, 0, 200, 300)
end
