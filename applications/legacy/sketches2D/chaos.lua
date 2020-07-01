function setup()
    parameter.integer('configuration', 1, #confs, 1, function (i)
            newConf = i
        end)

    newConf = 1
end

function reset(i)
    background(0)

    conf = confs[i]

    vertices = Table()

    size = WIDTH / 4

    deltaAngle = TAU / conf.n

    for i = 0,conf.n-1 do
        vertices:add(vec2(
                WIDTH/2  + sin(conf.startAngle + i * deltaAngle) * size,
                HEIGHT/2 + cos(conf.startAngle + i * deltaAngle) * size))
    end

    vertices:chainIt()

    stroke(red)
    strokeWidth(10)

    vertices:draw()

    currentPoint = vec2(WIDTH/2, HEIGHT/2)
end

function anyPoint()
    return vertices:random()
end

function notPreviousOne()
    local point = previousPoint
    repeat
        randomPoint = vertices:random()
    until randomPoint ~= point 
    return randomPoint
end

function notOnePlaceAwayFromThePreviousOne()
    local point = previousPoint.previous
    repeat
        randomPoint = vertices:random()
    until randomPoint ~= point 
    return randomPoint
end

function notTwoPlaceAwayFromThePreviousOne()
    local point = previousPoint.previous.previous
    repeat
        randomPoint = vertices:random()
    until randomPoint ~= point 
    return randomPoint
end

confs = {
    {
        n = 3,
        r = 1/2,
        startAngle = 0,
        rule = anyPoint
    },
    {
        n = 4,
        r = 1/2,
        startAngle = TAU/8,
        rule = notPreviousOne
    },
    {
        n = 4,
        r = 1/2,
        startAngle = TAU/8,
        rule = notOnePlaceAwayFromThePreviousOne
    },
    {
        n = 4,
        r = 1/2,
        startAngle = TAU/8,
        rule = notTwoPlaceAwayFromThePreviousOne
    },
    {
        n = 5,
        r = 1/2,
        startAngle = 0,
        rule = notPreviousOne
    },
    {
        n = 5,
        r = 1/3,
        startAngle = 0,
        rule = anyPoint
    },
    {
        n = 5,
        r = 3/8,
        startAngle = 0,
        rule = anyPoint
    },
    {
        n = 6,
        r = 1/3,
        startAngle = 0,
        rule = anyPoint
    }
}

function draw()
    if newConf then
        reset(newConf)
        newConf = nil
    end

    stroke(white)
    strokeWidth(1)

    for i = 1,1000 do
        local vertex = conf.rule()

        currentPoint:sub(vertex):mul(conf.r):add(vertex)
        currentPoint:draw()

        previousPoint = vertex
    end
end
