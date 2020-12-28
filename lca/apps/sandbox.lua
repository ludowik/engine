class('Star')

function Star:init(x, y)
    self.position = vec2(x, y)
    self.velocity = vec2.random(1, 1):mul(100)
end

function Star:update(dt)
    self.position:add(self.velocity.x * dt, self.velocity.x * dt)
end

function Star:draw()
    point(self.position.x, self.position.y)
end

function Star:isOut()
    if self.position.x > W then
        return true
    end
end

MAX_STARS = 100000

function setup()
    db = Dashboard(classes, {'className', '__base'})

    stars = Table()
    for i=1,100 do
        stars:add(Star(random(W), random(H)))
    end
end

function update(dt)
end

function wheelmoved(id, x, y)
    db:wheelmoved(id, x, y)
end

function draw()
    background()

    for i,star in ipairs(stars) do
        star:update(DeltaTime)
        if star:isOut() then
--            stars:remove(i)
            star:init(random(W), random(H))
        end
    end
    
    fill(red)
    text(#stars, 300, 100)
    
    for i=1,MAX_STARS-#stars do
        stars:add(Star(random(W), random(H)))
    end
    
    for i,star in ipairs(stars) do
        star:draw()
    end

    db:draw()
end

class('heritagemultiple', Object, Rect)

print(classnameof(fs))

function wheelmoved(id, x, y)
    offset = offset + y * 50
end
