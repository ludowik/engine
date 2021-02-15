function setup()
    array = Array()
    for i=1,100 do
        array:add(Cube.random(W, W, W, 50))
    end

    parameter.number('AREA_SIZE', 100, 20000, W)
    parameter.number('CUBE_SIZE', 1, 1000, 100)
    
    camera(W/2, W/2, -W)
end

function draw()
    background()

    light(true)

    perspective()
    
    translate(-W/2, -W/2, -W/2)

    depthMode(true)
    cullingMode(true)

    q = Octree(AREA_SIZE, CUBE_SIZE)

    for i=1,#array do
        q:add(array[i])
    end

    q:draw()
end
