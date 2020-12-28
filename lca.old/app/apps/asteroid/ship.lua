class('Ship', PolygonObject)

function Ship:init()
    PolygonObject.init(self)

    local radius = app.objectSize * 0.75
    self.vertices = Table{vec2(radius*cos(0), radius*sin(0)),
        vec2(radius*cos(pi*1.2), radius*sin(pi*1.2)),
        vec2(radius*cos(pi*0.8), radius*sin(pi*0.8))
    }

    self.radius = radius

    self:addToPhysics()

    self.body.position = vector(WIDTH/2, HEIGHT/2)
    self.body.angle = 90
    self.body.linearDamping = 1
    self.body.angularDamping = 10
    self.body.sensor = true

    self.keepInArea = true

    self.bullets = Scene()
    self.countSinceLastBullet = 0
end

function Ship:offscreen()
    if self.body.position.x < 0 or self.body.position.x > WIDTH then
        return true
    elseif self.body.position.y < 0 or self.body.position.y > HEIGHT then
        return true
    end
    return false
end

function Ship:updateKeepInArea()
    if self:offscreen() then
        if self.body.position.x + self.radius < 0 then
            self.body.position.x = WIDTH + self.radius

        elseif self.body.position.x - self.radius > WIDTH then
            self.body.position.x = -self.radius
        end

        if self.body.position.y + self.radius < 0 then
            self.body.position.y = HEIGHT + self.radius

        elseif self.body.position.y - self.radius > HEIGHT then
            self.body.position.y = -self.radius
        end
    end
end

function Ship:update()
    PolygonObject.update(self)
    self:updateUserAction()
end

function Ship:applyForce(force)
    self.body:applyForce(
        vec2(force,0):rotate(rad(self.body.angle)))
end

function Ship:updateUserAction()
    self.countSinceLastBullet = self.countSinceLastBullet + 1

    if app.joystick1:getForce() > 0 then
        self.body.angle = app.joystick1:getAngle()
        self:applyForce(app.joystick1:getForce())
    end

    if app.joystick2:getForce() > 0 and self.countSinceLastBullet > 10 then
        self.bullets:add(Bullet(self))
        self.countSinceLastBullet = 0
    end    

    if isDown('left') then
        self.body.angle = self.body.angle + 10
    end

    if isDown('right') then
        self.body.angle = self.body.angle - 10
    end

    if isDown('up') then
        self:applyForce(1)
    end

    if isDown('down') then
        self:applyForce(-1)
    end

    self.angle = self.body.angle
end

function Ship:draw()
    local points = self.body.points

    beginShape()
    for i,point in ipairs(points) do
        vertex(point.x, point.y)
    end
    endShape(CLOSE)
end
