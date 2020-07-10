function setup()
end

function update(dt)
end

function draw()
    tint(green)
    
    spriteMode(CENTER)
    sprite('documents:joconde', W/2, H/2, 400, 400)
    
    stroke(red)
    strokeWidth(2)
    
    line(0, H/2, W, H/2)
    line(W/2, 0, W/2, H)
    
    noFill()
    
    circleMode(CENTER)
    circle(W/2, H/2, 100)
    
    ellipseMode(CENTER)
    ellipse(W/2, H/2, 100, 50)
    
    rectMode(CENTER)
    rect(W/2, H/2, 200, 200)
    
    textMode(CENTER)
    text('HELLO', W/2, H/2)
end
