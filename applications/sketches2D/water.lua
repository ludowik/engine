function setup()
    grid = GridWater(20)

    grid:set(10, 5, 200)

    grid:line( 5, 10, 12,  7)
    grid:line(10, 10, 8, 18)
end

function update(dt)
    grid:update(dt)
end

function draw()
    grid:draw(20, 20)
end

class('GridWater', Grid)

function GridWater:init(...)
    Grid.init(self, ...)
    self.defaultValue = 0
end

function GridWater:line(x1, y1, x2, y2)
    drawing.line(self, x1, y1, x2, y2, -1)
end

function GridWater:update(dt)
    local g = Grid(self.w, self.h)
    for i=1,self.h do
        for j=1,self.w do
            g:set(i, j, self:get(i, j))
        end
    end

    for i=1,self.h do
        for j=1,self.w do

            local value = self:get(i, j) or 0
            if value > 0 then

                function updatePressure(x, y, pct)
                    pct = pct or 0.33

                    local valueNext = self:get(i+x, j+y) or 0
                    if valueNext == -1 then
                        return false
                    end

                    local delta = 0
                    if value > valueNext or valueNext < 1 then
                        delta = value * pct
                    else
                        return false
                    end

                    delta = math.min(delta, 1)

                    if j+y <= self.h and i+x >= 1 and i+x <= self.w then
                        g:set(i, j, g:get(i, j)-delta)
                        g:set(i+x, j+y, g:get(i+x, j+y)+delta)
                    end
                end

                if updatePressure( 0, 1) == false then
                    updatePressure( 1, 0)
                    updatePressure(-1, 0)
                end

            end

        end
    end

    self.cells = g.cells
end

function GridWater:draw(w, h)
    for i=1,self.h do
        for j=1,self.w do
            local value = self:get(i,j)
            if value == -1 then
                fill(51)
                rect(i*w, j*h, w, h)

            elseif value then
                fill(0, 0, value)
                rect(i*w, j*h, w, h)

                noFill()
                text(value, i*w, j*h)
            end

            noFill()
            rect(i*w, j*h, w, h)
        end
    end
end
