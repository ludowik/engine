class 'Random'

function Random:init(...)
    return random(...)
end

function Random.range(min, max)
    assert(min)
    if not max then
        min, max = 1, min
    end
    if min > max then
        return 0
    end

    return math.floor(random() * max ^ 2) % (max - min + 1) + min
end

function Random.random(min, max)
    if not min then
        min, max = 0, 1
    elseif not max then
        min, max = 0, min
    end

    return math.random() * (max - min) + min
end

seed = math.randomseed
seed(tonumber(tostring(os.time()):reverse():sub(1,6)))

random = Random.random
randomInt = Random.range
