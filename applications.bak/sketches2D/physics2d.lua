local physics
function setup()
    physics = Physics2d(0, -10)
    
    local marge = 25

    physics:setArea(marge, marge, WIDTH-marge*2, HEIGHT-marge*2)

    function addBall()
        r = 10
        ball = Object(150, 250, r, r)
        physics:add(ball, DYNAMIC, CIRCLE)
    end
    
    addBall()

    local y = 100 + 10
    local size = 20
    physics:addItems({
            Object(200, y, size,  size),
            Object(200+size, y, size,  size),
            Object(200+2*size, y, size,  size),
            Object(200+size/2, y+size, size,  size),
            Object(200+size+size/2, y+size, size,  size),
            Object(200+size, y+2*size, size,  size),
            }, DYNAMIC, RECT)

    parameter.action('add ball', function () addBall() end)
    
--    app.scene:add(physics)
end

function touched(touch)
    local direction = vec2(touch.x, touch.y) - ball.position
    direction = direction:normalize() * WIDTH/50

    ball.body:applyLinearImpulse(direction)
end
