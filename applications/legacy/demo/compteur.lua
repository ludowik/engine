
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
<<<<<<< HEAD
        x = x + w 
=======
        x = x + W
>>>>>>> 1d13a5feaa5b73b80a35dec879405e9543da2a96
    end

--    text(count, x, y + 50)
--    text(countAsStr:len(), x, y + 100)
end
