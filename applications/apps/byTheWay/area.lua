--  area

Area = class('area')

function Area:init(x, y, w, h, force)
    self.position = vec3(x, y)
    self.size = vec2(w, h)
    
    self.force = force or vec2()
    self.id = id("area")
end

function Area:draw()
    theme("area")
    rect(self.position.x, self.position.y, self.size.x, self.size.y)
end

function Area:contains(x, y)
    if
        self.position.x <= x and x <= self.position.x + self.size.x and
        self.position.y <= y and y <= self.position.y + self.size.y
    then
        return self
    end
end

function Area:applyActionOn(bot, dt)
    bot:applyForce(self.force * dt)
end

