local joystick

function setup()
    joystick = lca.joystick.getJoysticks()[1]

    position = vec2(WIDTH/2, HEIGHT/2)

    speed = 200
    
    pivot = 0.13

    axis1 = 0
    axis2 = 0
    axis3 = 0

    axis1Min = 0
    axis1Max = 0

    axis2Min = 0
    axis2Max = 0

    axis3Min = 0
    axis3Max = 0
    
    X, Y = 0, 0

    parameter.number('speed', 0, 1000)
    parameter.number('pivot', 0, 0.2)

    parameter.watch('position')
    parameter.watch('X')
    parameter.watch('Y')

    parameter.watch('axis1')
    parameter.watch('axis2')
    parameter.watch('axis3')

    parameter.watch('axis1Min')
    parameter.watch('axis1Max')
    parameter.watch('axis2Min')
    parameter.watch('axis2Max')
    parameter.watch('axis3Min')
    parameter.watch('axis3Max')
end

function update(dt)
    if joystick then
        axis1, axis2, axis3 = joystick:getAxes()

        X = map(axis1, -0.2, 0.2, -1, 1)
        
        if axis2 > pivot then
            Y = map(axis2, pivot, max(0.2, pivot+0.1),  0, 1)
        else
            Y = map(axis2, min(-0.2, pivot-0.1), pivot, -1, 0)
        end

        axis1Min = min(axis1Min, axis1)
        axis1Max = max(axis1Max, axis1)

        axis2Min = min(axis2Min, axis2)
        axis2Max = max(axis2Max, axis2)

        axis3Min = min(axis3Min, axis3)
        axis3Max = max(axis3Max, axis3)

        position.x = position.x + X * speed * dt
        position.y = position.y - Y * speed * dt
    end
end

function draw()
    background()

    fill(white)

    circleMode(CENTER)
    circle(position.x, position.y, 50)
    
    translate(WIDTH/2, HEIGHT/2)
    line(0, 0, X*100, -Y*100)
end

function touched(touch)
    pivot = axis2
end
