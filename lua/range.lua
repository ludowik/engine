function range(n)
    local i = 0
    return function ()
        if i == n then
            return nil
        end
        i = i + 1
        return i-1
    end
end

local index = 0
for i in range(10) do
    assert(i == index)
    index = index + 1
end
