class('Board2048', UI)

function Board2048:init(grid)
    UI.init(self)

    self.grid = grid
    self.position = vec3(WIDTH/2, HEIGHT*2/3)
end

function Board2048:computeSize()
    self.size.x = min(WIDTH, HEIGHT) * 0.8
    self.size.y = self.size.x
end

function Board2048:draw()
    local marge = 5
    local x, y = marge, marge

    local m, n = self.grid.w, self.grid.h

    local l = floor((self.size.x - 2*marge) / n)
    local l2 = max(1, floor(l / 2))

    rectMode(CENTER)
    
    pushMatrix()
    do
        translate(
            x + m/2 * l,
            y + n/2 * l)
        
        fill(gray)
        
        rect(0, 0,
            l*m + marge*2,
            l*n + marge*2,
            marge)
        
        
    end
    popMatrix()

    for i=1,m do
        for j=1,n do
            pushMatrix()
            do
                local cell = self.grid:cell(i, j)
                local value = cell.value

                local s = tile_colors[value]
                if s == nil then
                    s = lightgray
                else
                    s = hexa2color(s)
                end

                local scaling = cell.scaling or 1
                if scaling < 1 then
                    cell.scaling = cell.scaling + 0.1
                    cell.angle = cell.angle + PI/4
                else
                    cell.scaling = 1
                    cell.angle = 0
                end

                translate(
                    x + i * l - l2,
                    y + j * l - l2)

                scale(cell.scaling)
                rotate(cell.angle)

                style(0, transparent, s)

                rect(0, 0,
                    (l-2*marge),
                    (l-2*marge),
                    marge)

                if value ~= nil then
                    local st = tile_text_colors[value]
                    if st == nil then
                        st = tile_text_colors[1]
                    end

                    local txt = tostring(value)

                    local fontSize = 30

                    repeat
                        textStyle(fontSize, hexa2color(st), CENTER)
                        local w, h = textSize(txt)
                        fontSize = fontSize - 2
                    until w < l-2*marge or fontSize <= 20

                    textMode(CENTER)
                    text(txt, 0, 0)
                end

                if cell.new then
                    stroke(blue)
                    strokeWidth(2)

                    noFill()

                    circleMode(CENTER)
                    circle(0, 0, l2/2)
                end
            end
            popMatrix()
        end
    end
end
