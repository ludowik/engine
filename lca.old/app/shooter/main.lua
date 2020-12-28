App('Shooter')

function Shooter:init()
    Application.init(self)

    physics = Physics2d(0, 0)
    physics.debug = true

    self.player = CircleObject(WIDTH/2, HEIGHT*0.2, 10)
    self.player.className = 'player'
    self.player.cumulativeTime = 0
    self.player:addToPhysics()

    self.bullets = Node()

    self.scene:add(self.player)
    self.scene:add(self.bullets)
    self.scene:add(physics)

    parameter.watch('#app.bullets.nodes')
end

function Shooter:touched(touch)
    if touch.state == BEGAN or touch.state == MOVING  then
        self.applyDirection = true
    else
        self.applyDirection = false
    end
end

function Shooter:update(dt)
    if physics.running == false then return end
    
    Application.update(self, dt)

    if self.applyDirection then
        local pos = self.player.body.position
        local direction = CurrentTouch - pos

        local dist = direction:len()

        local speed = map(dist, 1, 100, 1, 1000)

        local linearVelocity = direction:normalize() * speed
        self.player.body.linearVelocity = linearVelocity

        line(pos.x, pos.y, CurrentTouch.x, CurrentTouch.y)
    else
        self.player.body.linearVelocity = vector()
    end

    self.player.cumulativeTime = self.player.cumulativeTime + dt

    if self.player.cumulativeTime > 0.1 then
        self.player.cumulativeTime = 0

        local pos = self.player.body.position

        local bullet = RectObject(pos.x, pos.y + 25, 4, 4)
        bullet.className = 'bullet'
        bullet:addToPhysics()
        bullet.body.bullet = true
        bullet.body.linearVelocity = vector(0, 1000)
        bullet.linearDamping = 0

        self.bullets:add(bullet)
    end

    if self.ennemies == nil then
        self.ennemies = Node()
        self.scene:add(self.ennemies)

        for i=1,10 do
            local ennemy = Ennemy()
            self.ennemies:add(ennemy)
        end

    elseif #self.ennemies.nodes == 0 then
        self.scene:removeItem(self.ennemies)
        self.ennemies = nil

    end

    for i,bullet in ipairs(self.bullets) do
        local pos = bullet.position
        if pos.y > HEIGHT + 100 then
            physics:removeItem(bullet)
            self.bullets:removeItem(bullet)
        end
    end

    if self.ennemies then
        for i,ennemy in ipairs(self.ennemies) do
            local pos = ennemy.position
            if pos.y < -100 then
                physics:removeItem(ennemy)
                self.ennemies:removeItem(ennemy)
            end
        end
    end
end

function Shooter:collide(contact)
    if contact.state == BEGAN then
        local bullet, ennemy, player = contact:get('bullet', 'ennemy', 'player')

        if bullet and ennemy then
            physics:removeItem(bullet)
            self.bullets:removeItem(bullet)

            physics:removeItem(ennemy)
            self.ennemies:removeItem(ennemy)
        end

        if player and ennemy then
            physics:pause()
        end
    end
end
