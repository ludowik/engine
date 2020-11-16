class 'random'

function random:init(...)
    return random.random(...)
end

function random.range(min, max)
    assert(min)
    if not max then
        min, max = 1, min
    end
    if min > max then
        return 0
    end
    
    return math.floor(random.random() * max ^ 2) % (max - min + 1) + min
end

function random.random(min, max)
    if not min then
        min, max = 0, 1
    elseif not max then
        min, max = 0, min
    end

    return math.random() * (max - min) + min
end

seed = math.randomseed
seed(tonumber(tostring(os.time()):reverse():sub(1,6)))
