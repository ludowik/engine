-- TODO Améliorer la physique des spheres

function setup()
    supportedOrientations(LANDSCAPE_ANY)
    
    physics = Physics3d(0, -10)
    physics.debug = true
    
    physics:setArea(-5, 0, -5, 10, 10, 10)
    
    function addBall()
        r = 1
        ball = Object3d(
            random(-0.5, 0.5),
            4,
            0, r, r, r)
        ball.color = color.random()
        physics:addItem(ball, DYNAMIC, 'sphere')
    end
    
    addBall()

    parameter.action('add ball', function () addBall() end)

    app.scene.camera = camera(0, 8, 35, 0, 0, 0)
    app.scene:add(physics)
end

function update(dt)
    app.scene:update(dt)
    app.scene.camera:rotateY(1)
end

function touched(touch)
    for _,ball in ipairs(physics.bodies) do
        ball.force = vector.random(5)
    end
end
