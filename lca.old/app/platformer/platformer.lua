function setup()
    N = 10

    player = {
        X = N/2,
        Y = N/2
    }
    
    delay = 0.5

    angle = 0

    tex = image('documents:skyDome')

    moves = Table()
    moving = false
end

function update(dt)
    angle = angle + 1

    if #moves > 0 and moving == false then
        moving = true
        
        function endMoving()
            moving = false
        end
        
        local key = moves:dequeue()
        if key == 'right' then
            tween(delay, player, {X=player.X+1, Y=player.Y}, tween.easing.linear, endMoving)
        elseif key == 'left' then
            tween(delay, player, {X=player.X-1, Y=player.Y}, tween.easing.linear, endMoving)
        elseif key == 'down' then
            tween(delay, player, {X=player.X, Y=player.Y+1}, tween.easing.linear, endMoving)
        elseif key == 'up' then
            tween(delay, player, {X=player.X, Y=player.Y-1}, tween.easing.linear, endMoving)
        end
    end
end

function draw()
    background()

    light(true)

    isometric(50)
--    perspective()

--    camera(
--        player.X, 0.4, player.Y,
--        player.X+1, 0.4, player.Y)

    translate(-N/2, 0, -N/2)

    pushMatrix()
    for x = 1,N do
        translate(1, 0, 0)
        pushMatrix()
        for y = 1,N do
            translate(0, 0, 1)
            stroke(black)
            box(0.95, 0.5, 0.95)
        end
        popMatrix()
    end
    popMatrix()

    fill(red)

    translate(player.X, 0.4, player.Y)

    rotate(angle, 0, 1)
    sphere(0.2, 0.2, 0.2, tex)
end

function keypressed(key)
    if key == 'right' then
        moves:queue(key)
    elseif key == 'left' then
        moves:queue(key)
    elseif key == 'down' then
        moves:queue(key)
    elseif key == 'up' then
        moves:queue(key)
    end
end
