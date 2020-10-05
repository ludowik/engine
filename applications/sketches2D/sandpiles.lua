function Array2(w, h, default)
    w = w or 100
    h = h or w
    default = default or 0
    
    local array = {}
    for x=1,w do
        sandpiles[w] = {}
        for y=1,h do
            sandpiles[w][y] = 0
        end
    end
    
    return array
end


function setup()
    size = 600
    img = image(size)

    sandpiles = {}
    nextpiles = {}
    for i=1,size do
        sandpiles[i] = {}
        nextpiles[i] = {}
        for j=1,size do
            sandpiles[i][j] = 0
            nextpiles[i][j] = 0
        end
    end

    sandpiles[size/2][size/2] = 1000000
end

function update()
    for i=1,200 do
        updatePiles()
    end
end

function updatePiles()
    for i=1,size do
        for j=1,size do
            nextpiles[i][j] = 0
        end
    end

    for x=1,size do
        for y=1,size do
            num = sandpiles[x][y]
            if num <= 3 then
                nextpiles[x][y] = sandpiles[x][y]
            end
        end
    end

    local num
    for x=1,size do
        for y=1,size do
            num = sandpiles[x][y]
            if num > 3 then
                nextpiles[x][y] = nextpiles[x][y] + num - 4
                if nextpiles[x+1] then
                    nextpiles[x+1][y] = nextpiles[x+1][y] + 1
                end

                if nextpiles[x-1] then
                    nextpiles[x-1][y] = nextpiles[x-1][y] + 1
                end

                if nextpiles[x][y+1] then
                    nextpiles[x][y+1] = nextpiles[x][y+1] + 1
                end

                if nextpiles[x][y-1] then
                    nextpiles[x][y-1] = nextpiles[x][y-1] + 1
                end
            end
        end
    end

    nextpiles, sandpiles = sandpiles, nextpiles
end

function draw()
    local clr = color()
    local row, num
    for x=1,size do
        row = sandpiles[x]
        for y=1,size do
            num = row[y]

            clr:set(white)
            if num == 1 then
                clr:set(red)
            elseif num == 2 then
                clr:set(green)
            elseif num == 3 then
                clr:set(blue)
            elseif num > 3 then
                clr:set(gray)
            end

            img:set(x, y, clr.r, clr.g, clr.b, 1)
        end
    end

    translate(W/2, H/2)
    sprite(img)
end
