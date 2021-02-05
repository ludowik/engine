function setup()
    supportedOrientations(LANDSCAPE_ANY)

    fizix = Fizix()

    fizix:setArea(-5, 0, -5, 10, 10, 10)

    function addBall()
        r = 1
        ball = Object3D('ball',
            random(-0.5, 0.5),
            4,
            0, r, r, r)
        ball.color = color.random()
        fizix:add(ball, DYNAMIC, SPHERE, r)
    end

    addBall()

    parameter.action('add ball', function () addBall() end)

    app.scene.camera = Camera(0, 8, 35, 0, 0, 0)
    app.scene:add(fizix)

    fizix:draw()
end

function update(dt)
    app.scene:update(dt)

    if app.scene.camera then
        app.scene.camera:rotateY(1)
    end
end

function touched(touch)
    for _,ball in ipairs(fizix.bodies) do
        ball.force = vec3.random(5)
    end
end
