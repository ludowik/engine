--  Way
Way = class('way')

function Way:init(touchs)
    self.active = true

    self.points = Table()
    --[[
    for _,f,t in touchs:by2() do
        self:addLine(f, t)
    end 
      ]]

    --[[
    for _,f,t,l in touchs:by3() do
        self:addLine(f, (f+l)/2)
    end
      ]]

    local n = #touchs

    local m = 4
    for i=1,n do
        local point = vec2()

        local i1 = math.max(1, i-m)
        local i2 = math.min(n, i+m)
        for j=i1,i2 do
            point = point + touchs[j]
        end

        self:addPoint(point/(i2-i1+1))
    end

    self.i = 1
    self.n = #self.points

    self.pas = math.max(1, math.floor(self.n/60))
end

function Way:addLine(f, t)
    if f.x == t.x and f.y == t.y then return end

    f = vec2(f.x, f.y)
    t = vec2(t.x, t.y)

    local direction = (t - f):normalize()

    local d = f:dist(t) - 1

    for i = 1, d, 10 do
        self:addPoint(f + direction * i)
    end
end

function Way:addPoint(p)
    self.points:insert(p)
end

function Way:draw()
    theme("way")
    for i,f,t in self.points:by2() do
        line(f.x, f.y, t.x, t.y)
    end

    local f = self.points[self.i]
    local t = self.points[self.i+1]

    theme("wayPath")
    line(f.x, f.y, t.x, t.y)

    self.i = math.fmod(self.i + 1, self.n - 1) + 1
end

function Way:update(dt)
    for i = 1,self.pas do
        -- self.points:remove(1)
    end

    if #self.points == 0 then
        self.active = false
    end
end
