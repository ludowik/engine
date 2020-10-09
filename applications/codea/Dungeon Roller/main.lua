supportedOrientations(CurrentOrientation)

-- Use this function to perform your initial setup
function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(FULLSCREEN)

    parameter.watch('Gravity')

    math.randomseed(1275)

    guy = Hero()
    guy.position = vec2(WIDTH/2,HEIGHT/2)

    world = World(guy,8,9)

    guy.world = world
end

-- This function gets called once every frame
function draw()
    background(66, 40, 84, 255)

    translate((WIDTH - (9 * 101))/2, (HEIGHT - (10*90))/2)

    world:draw()

    if guy:isDead() then
        guy:drawDead()
    else
        guy:draw()
    end
end

function touched(touch)
    guy:touched(touch)
end