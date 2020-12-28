function bitNOT(n)
    local p, c = 1, 0
    while n > 0 do
        local r = n % 2
        if r < 1 then
            c = c + p
        end
        n = ( n - r ) / 2
        p = p * 2
    end
    if c ~= 0 then
        return c
    end
end

function bitOR(a, b)
    local p, c = 1, 0
    while a + b > 0 do
        local ra, rb = a % 2 , b % 2
        if ra + rb > 0 then
            c = c + p
        end
        a = ( a - ra ) / 2
        b = ( b - rb ) / 2
        p = p * 2
    end
    if c ~= 0 then
        return c
    end
end

function bitAND(a, b)
    local p, c = 1, 0    
    while a > 0 and b > 0 do
        local ra , rb = a % 2 , b % 2
        if ra + rb > 1 then
            c = c + p
        end
        a = ( a - ra ) / 2
        b = ( b - rb ) / 2
        p = p * 2
    end
    if c ~= 0 then
        return c
    end
end
