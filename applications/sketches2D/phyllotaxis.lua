function setup()    
    parameter.integer('c', 2, 20, 8, reset)

    reset()
end

function reset()
    resetDrawing = true
end

function draw()
    if resetDrawing then
        resetDrawing = false
        background(51)
        n = 0
    end
    
    local a = n * 137.5
    local r = c * math.sqrt(n)

    local x = r * math.cos(math.rad(a)) + W/2
    local y = r * math.sin(math.rad(a)) + H/2

    strokeWidth(c)
    
    stroke(hsl((a-r)%255, 255, 128))

    point(x, y)

    n = n + 1
end
