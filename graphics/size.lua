local N = 16

local function NW()
    if W > H then
        return N
    else
        return N/16*9
    end
end

local function NH()
    if W > H then
        return N/16*9
    else
        return N
    end
end

function ws(i, n)
    i = i or 1
    n = n or NW()
    return floor( W / n * i )
end

function hs(i, n)
    i = i or 1
    n = n  or NH()
    return floor( H / n * i )
end

function size(i, j)
    return vec2(
        ws(i), 
        hs(j))
end
