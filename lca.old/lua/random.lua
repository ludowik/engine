-- random
local math_random = math.random
local math_floor = math.floor

seed = math.randomseed

function random(_min, _max)
    local p = type(_min) == 'table' and _min or nil

    if p then
        return table.n(p, randomInt(table.count(p)))
    end

    local min = _max and _min or 0
    local max = _max or  _min or 1

    return math_random() * ( max - min ) + min
end

function randomInt(_min, _max)
    local min = _max and _min or 0
    local max = _max or  _min or 1
    
    return math_floor(random(min, max+0.999999999))
end

seed(tonumber(tostring(os.time()):reverse():sub(1,6)))
