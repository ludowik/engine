function setup()
    grid = Grid(100, 100)

    for i=1,grid.m do
        for j=1,grid.n do
            grid:set(i, j, randomInt(1, 4))
        end
    end
end

function draw()
    local l = 10
    noFill()
    
    grid:draw(function (i, j, value)
            if value == 1 then
                line(i*l, j*l, (i+1)*l, j*l)
            elseif value == 2 then
                line(i*l, j*l, i*l, (j+1)*l)
            elseif value == 3 then
                line(i*l, j*l, (i-1)*l, j*l)
            elseif value == 4 then
                line(i*l, j*l, i*l, (j-1)*l)
            end
        end)
end
