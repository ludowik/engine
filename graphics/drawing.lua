class('drawing')

function drawing:line(x1, y1, x2, y2, ...)
    if x1 == x2 then
        for y=y1,y2,math.sign(y2-y1) do
            self:set(x1, y, ...)
        end
    elseif y1 == y2 then
        for x=x1,x2,math.sign(x2-x1) do
            self:set(x, y1, ...)
        end
    else
        local dy = (y2-y1) / math.abs(x2-x1)
        local dx = (x2-x1) / math.abs(y2-y1)
        if math.abs(dy) < math.abs(dx)  then
            local y = y1
            for x=x1,x2,math.sign(x2-x1) do
                self:set(x, math.round(y), ...)
                y = y + dy
            end
        else
            local x = x1
            for y=y1,y2,math.sign(y2-y1) do
                self:set(math.round(x), y, ...)
                x = x + dx
            end
        end
    end
end
