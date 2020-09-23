class('Bullet', CircleObject)

function Bullet:init(ship)
    CircleObject.init(self, 0, 0, 2)

    self:addToPhysics()

    self.body.position = (
        vec2(ship.position.x, ship.position.y)
        :add(vec2(30,0)
            :rotateInPlace(rad(ship.angle))))

    self.body.linearVelocity = vec2(300,0):rotateInPlace(rad(ship.angle))
    self.body.linearDamping = 0

    self.body.radius = 2
end

function Bullet:draw()
    fill(white)
    noStroke()

    circle(0, 0, self.body.radius)
end
