class 'Toothpick'

len = 67

function Toothpick:init(x, y, angle, from)
    self.x = x
    self.y = y

    local rx = round(cos(angle), 2)
    local ry = round(sin(angle), 2)

    if abs(rx) < 0.1 or abs(ry) < 0.1 then
        self.len = len
    else
        self.len = sqrt(len^2/2)
    end

    if from == 'a' then
        self.xa = x
        self.ya = y

        self.xb = x + rx * self.len / 2
        self.yb = y + ry * self.len / 2

    elseif from == 'b' then
        self.xa = x - rx * self.len / 2
        self.ya = y - ry * self.len / 2

        self.xb = x
        self.yb = y

    else
        self.xa = x - rx * self.len / 2
        self.ya = y - ry * self.len / 2

        self.xb = x + rx * self.len / 2
        self.yb = y + ry * self.len / 2
    end

    self.angle = angle

    self.new = true
end

function Toothpick:line(buf)
    buf:add(vec3(self.xa, self.ya))
    buf:add(vec3(self.xb, self.yb))
end

function Toothpick:draw()
    strokeWidth(2)

    if self.new then
        stroke(blue)
    else
        stroke(black)
    end

    line(self.xa, self.ya, self.xb, self.yb)
end

function Toothpick:contact(x, y)
    local dist = distFromPoint2Segment(x, y, self.xa, self.ya, self.xb, self.yb)
    if dist <= 1 then
        return true
    end
end

function setup()
    Toothpicks = Table()

    minY = -H/2
    maxY =  H/2

    noLoop()
end

function touched(touch)
    if touch.state == ENDED then
        redraw()
    end
end

function update(dt)
    if #Toothpicks == 0 then
        Toothpicks:add(Toothpick(0, 0, PI4, nil))
        return
    end

    Toothpicks:forEach(
        function (t)
            minY = min(minY, t.y)
            maxY = max(maxY, t.y)

            if t.new then
                t.inContactA = false
                t.inContactB = false

                Toothpicks:forEach(
                    function (other)
                        if t ~= other then
                            if other:contact(t.xa, t.ya) then
                                t.inContactA = true
                            end
                            if other:contact(t.xb, t.yb) then
                                t.inContactB = true
                            end
                        end
                    end)
            end
        end)

    Toothpicks:forEach(
        function (t)
            if t.new then
                t.new = false

                if not t.inContactA then
                    Toothpicks:add(Toothpick(t.xa, t.ya, t.angle + PI + PI4, 'a'))
                    Toothpicks:add(Toothpick(t.xa, t.ya, t.angle + PI - PI4, 'a'))
                    t.inContactA = true
                end
                if not t.inContactB then
                    Toothpicks:add(Toothpick(t.xb, t.yb, t.angle + PI + PI4, 'b'))
                    Toothpicks:add(Toothpick(t.xb, t.yb, t.angle + PI - PI4, 'b'))
                    t.inContactB = true
                end
            end
        end)
end

function draw()
    background(white)

    translate(W/2, H/2)

    ratio = H / (maxY - minY)
    scale(ratio, ratio)

    buf_new = buf_new or Buffer('vec3')
    buf_new:reset()

    buf_old = buf_old or Buffer('vec3')
    buf_old:reset()

    Toothpicks:forEach(
        function (t)
            if t.new then
                t:line(buf_new)
            else
                t:line(buf_old)
            end
        end
    )

    strokeWidth(2)
    
    stroke(black)
    lines(buf_old)
    
    stroke(blue)
    lines(buf_new)
end

