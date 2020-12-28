random = function (min, max)
    max, min =
    max or min or 1,
    max and min or 0

    return math.random() * (max-min) + min
end

randomInt = function (min, max)
    max, min =
    max or min or 1,
    max and min or 0
    
    return math.floor(
        random(
            math.floor(min),
            math.floor(max)+1))
end

seed = math.randomseed
seed(tonumber(tostring(os.time()):reverse():sub(1,6)))
