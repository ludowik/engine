local grid

function setup()
    grid = Grid(100, 100)

    for i=1,grid.w do
        for j=1,grid.h do
            grid:set(i, j, randomInt(1, 4))
        end
    end
end

function draw()
    local l = 10
    noFill()

    stroke(white)

    local function line(x1, y1, x2, y2)
        vertex(x1, y1)
        vertex(x2, y2)
    end

    beginShape()
    grid:draw(function (i, j, value)
            if value == 1 then
                line(i*l, j*l, (i+1)*l, j*l)
            elseif value == 2 then
                line(i*l, j*l, i*l, (j+1)*l)
            elseif value == 3 then
                line(i*l, j*l, (i-1)*l, j*l)
            elseif value == 4 then
                line(i*l, j*l, i*l, (j-1)*l)
            else
                assert()
            end
        end)
    endShape(LINES)
end
