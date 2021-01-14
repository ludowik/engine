local grid

function setup()
    parameter.integer('len', 1, 100, 20, initShape)

    initShape()
end

local function line(x1, y1, x2, y2)
    vertex(x1, y1)
    vertex(x2, y2)
end

function initShape(l)
    l = l or len

    grid = Grid(W/len, H/len)

    for i=1,grid.w do
        for j=1,grid.h do
            grid:set(i, j, randomInt(1, 4))
        end
    end

    beginShape()
    grid:draw(
        function (i, j, value)
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
    shape = endShape(LINES)
end

function draw()
    background(51)

    noFill()
    stroke(white)

    shape:draw()
end
