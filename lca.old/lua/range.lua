function range(min, max, step)
    step = step or 1
    
    local t = Table()
    for i=1,max-min,step do
        t[i] = min+i-1
    end
    return t
end
