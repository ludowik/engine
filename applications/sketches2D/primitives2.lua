-- TODO : doublon avec primitive 

function setup()
    parameter.boolean('use_stroke', true)
    parameter.boolean('use_fill', true)
    
    parameter.number('use_strokeWidth', 0, 50, 20)
    
    parameter.number('use_angle', 0, 360, 0)
end

function draw()
    background(51)
    
    if use_stroke then
        stroke(cyan)
        strokeWidth(use_strokeWidth)
    else
        noStroke()
    end
    
    if use_fill then
        fill(lightgray)
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
    
    rotate(-use_angle)
    
    translate(400, 0)
    rotate(use_angle)
    
    tint(cyan)
    
    spriteMode(CENTER)
    sprite(image('joconde'), 0, 0)
end
