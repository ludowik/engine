function setup()
    numbers = {}

    for i=1,10 do
        numbers[i] = 0
    end
end

function update(dt)
    local i = random.range(10)
    numbers[i] = numbers[i] + 1
end

function draw()
    background()

    for i=1,10 do
        rect(100+i*20, 0, 10, numbers[i])
    end
end
