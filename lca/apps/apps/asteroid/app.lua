App('AppAsteroid')

function AppAsteroid:init()
    Application.init(self)

    physicsInstance = PhysicsInstance()


    self.scene = Scene()

    self.joystick1 = Joystick(ws(1), hs(1))
    self.joystick2 = Joystick(ws(9), hs(1))

    self.scene:add(self.joystick1)
    self.scene:add(self.joystick2)

    self.objectSize = 20

    self.ship = Ship()
    self.scene:add(self.ship)
    self.scene:add(self.ship.bullets)

    self.asteroids = Scene()
    self.scene:add(self.asteroids)
    for i=1,10 do
        self.asteroids:add(Asteroid())
    end

    self.score = 0

    physics.gravity(0, 0)
end

function AppAsteroid:update(dt)
    Application.update(self, dt)

    self.ship:updateKeepInArea()

    for i,bullet in ipairs(self.ship.bullets) do
        if bullet:offscreen() then
            self.ship.bullets:removeItem(bullet)
        end
        for j,asteroid in ipairs(self.asteroids) do
            if bullet:intersect(asteroid) then
                break
            end
        end
    end
end

function AppAsteroid:translate()
    translate(
        W / 2 - self.ship.body.position.x,
        H / 2 - self.ship.body.position.y)
end

function AppAsteroid:draw()
    self:translate()

    Application.draw(self)
end

function AppAsteroid:keyboard(key)
    if key == 'space' then
        self.ship.bullets:add(Bullet(self.ship))
    end
end

function AppAsteroid:collide(contact)
    if contact.state == BEGAN then
        local bullet = Fizix.Contact.get(contact, 'bullet')
        local asteroid = Fizix.Contact.get(contact, 'asteroid')

        if bullet and asteroid then
            self.score = self.score + 10

            if asteroid.radius > app.objectSize then
                local a = Asteroid(asteroid, 1)
                local b = Asteroid(asteroid, 2)

                self.asteroids:add(a, b)

                b.body.linearVelocity = -a.physics.linearVelocity
            else
                self.score = self.score + 10
            end

            self.ship.bullets:removeItem(bullet)
            bullet.body:destroy()

            self.asteroids:removeItem(asteroid)
            asteroid.body:destroy()
        end
    end
end
