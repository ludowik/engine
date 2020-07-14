function setup()
    parameter.integer('config.framerate', 1, 200, 30)

    atlas = image('Animation:sheep')

    function loadSprites(img, ws, hs, n, x, y, ms)
        img = image(img)

        ms = ms or 0
        x = x or 0
        y = y or img.height

        animation = {
            ws = ws,
            hs = hs
        }

        local line = 1

        local index = 0
        for i=1,n do
            animation[#animation+1] = atlas:copy(x + ms + ws * index, y - line * hs, ws, hs)

            fillFromPosition(animation[#animation])

            index = index + 1
            if ms + ws * index + ws > img.width then
                line = line + 1
                index = 0
            end
        end

        return animation
    end

    animation = loadSprites(atlas, 100, 80, 6, 25, 640)

    n = 0
end

function fillFromPosition(self, x, y)
    x, y = x or 1, y or 1
    local w, h = self.width, self.height

    local fromColor = self:get(x, y)
    function propagation(x, y)
        if self:get(x, y).r > 0.9 then
            self:set(x, y, Color(0, 0, 0, 0))
            if x <= w then
                propagation(x+1, y)
            end
            if y <= h then
                propagation(x, y+1)
            end
            if x > 0 then
                propagation(x-1, y)
            end
            if y > 0 then
                propagation(x, y-1)
            end
        end
    end
    propagation(x, y)
end

function update(dt)
end

function draw(dt)
    background(51)

    local img = image(50, 100)
    setContext(img)
    line(0, 0, 50, 100)
    setContext()
    sprite(img, 0, 0)

    resetMatrix()

    rectMode(CORNER)
    spriteMode(CORNER)
    stroke(red)
    noFill()


    n = (n + DeltaTime*10)
    sprite(animation[floor(n)%#animation+1], 0, 0)

    local dx = 0
    for i=1,#animation   do
        sprite(animation[i], 200 + dx, 200)
        rect(200 + dx, 200, animation[i].width, animation[i].height)
        dx = dx + animation[i].width
    end

    --    sprite(atlas, 0, 500)
end
