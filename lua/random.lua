class 'random'

function random.range(min, max)
    assert(min)
    if not max then
        min, max = 1, min
    end
    return (random.random() * 2^8) % (max - min) + min
end

function random.random(min, max)
    if not min then
        min, max = 0, 1
    elseif not max then
        min, max = 0, min
    end

    return math.random() * (max - min) + min
end
