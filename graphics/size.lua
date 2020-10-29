local N = 16

local function NW()
    if screen.W > screen.H then
        return N
    else
        return N/16*9
    end
end

local function NH()
    if screen.W > screen.H then
        return N/16*9
    else
        return N
    end
end

function ws(i, n)
    i = i or 1
    n = n or NW()
    return floor( screen.W / n * i )
end

function hs(i, n)
    i = i or 1
    n = n  or NH()
    return floor( screen.H / n * i )
end

function size(i, j)
    return vec2(
        ws(i), 
        hs(j))
end
