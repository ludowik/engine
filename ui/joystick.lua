local joysticks = Table()

class('Joystick', UI)

function Joystick:init(x, y)
    UI.init(self)

    joysticks:add(self)

    self.diameterIn = ws(0.5)
    self.diameterOut = ws(0.8)

    self.scope = (self.diameterOut - self.diameterIn)

    self.direction = vec2()

    self:computeSize()
end

function Joystick:computeSize()
    self.size.x = ws(2)
    self.size.y = ws(2)
end

function Joystick:draw()
    translate(self.size.x*.5, self.size.y*.5)

    circleMode(CENTER)

    fill(0, 0, 200, 120)
    circle(0, 0, self.diameterOut)

    fill(0, 0, 200, 150)
    circle(self.direction.x, self.direction.y, self.diameterIn)
end

function Joystick:getDirection()
    return self.direction:normalize()
end

function Joystick:getAngle()
    return -deg(self.direction:angleBetween(vec2(1, 0)))
end

function Joystick:getForce()
    return self.direction:len() / self.scope
end

function Joystick:touchedBegan(touch)
end

function Joystick:touchedMoving(touch)
    self.direction.x = clamp(touch.x - self:xc(), -self.scope, self.scope)
    self.direction.y = clamp(touch.y - self:yc(), -self.scope, self.scope)

    if self.direction:len() > self.scope then
        self.direction = self.direction:normalize() * self.scope
    end

    return true
end

function Joystick:touchedEnded(touch)
    self.direction = vec2()
    self.touch = nil
end
