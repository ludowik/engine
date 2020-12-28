
count = 1

function draw()
    x = 100
    y = 100

    background()

    indice = count % 10
    count = count + 1

    local countAsStr = ("00000000000"..tostring(count)):right(10)

    for i=1,countAsStr:len() do
        car = countAsStr:mid(i, 1)
        w = text(tostring(car), x, y)
        x = x + w 
    end

--    text(count, x, y + 50)
--    text(countAsStr:len(), x, y + 100)
end
