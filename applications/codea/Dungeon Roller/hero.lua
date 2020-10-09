Hero = class()

function Hero:init()
    -- you can accept and set parameters here
    self.position = vec2(0,0)
    self.newPos = vec2()
    self.size = 60
    self.health = 50
    self.attackPower = 1
    self.invulnDuration = 0
    self.knockVel = vec2(0,0)

    parameter.watch("HeroHealth")
end

function Hero:move(dir)
    self.newPos
    :set(self.position)
    :add(dir, 20)
    :add(self.knockVel)

    if world:isColliding(self.newPos) then
        -- hit wall
    else
        self.position, self.newPos = self.newPos, self.position
    end

    self.knockVel:mul(0.7)
end

function Hero:applyDamageFromPoint(point, damage)
    if self.invulnDuration == 0 then
        self.health = math.max(self.health - damage, 0)
        local line = (point-self.position):normalizeInPlace(20)
        self.knockVel:add(line)

        self.invulnDuration = 0.5
    end
end

function Hero:attack()
    if self.currentAttack == nil then
        sound(SOUND_HIT,123)
        --print("Attacking")
        self.currentAttack = HeroAttack(self,self.attackPower)
    end
end

function Hero:damageAtPoint(point)
    if self.currentAttack then
        dta = self.position:dist(point)
        if dta < self.currentAttack.currentSize * 0.4 then
            return dta / self.currentAttack.blastSize * 30
        end
    end

    return 0
end

function Hero:isDead()
    return false
--    return self.health == 0
end

function Hero:drawDead()
    tint(50,50,50,255)
    sprite("Planet Cute:Character Boy", self.position.x + 5, self.position.y + 25, self.size + 20)
end

function Hero:draw()
    self.invulnDuration = math.max(self.invulnDuration - 1/60, 0)

    moveVec = vec2(Gravity.x, Gravity.z) --+ vec2(0,0.6)
    self:move(moveVec)

    pushStyle()

    if self.currentAttack then
        self.currentAttack:draw()
        if self.currentAttack:isDone() then
            self.currentAttack = nil
        end
    end

    stroke(0,0,0,0)
    fill(15, 23, 65, 141)
    ellipse(self.position.x + 5, self.position.y - 5, self.size, self.size)

    tintForInvulnDuration(self.invulnDuration)
    --ellipse(self.position.x, self.position.y, self.size, self.size)
    sprite("Planet Cute:Character Boy", self.position.x + 5, self.position.y + 25, self.size + 20)

    popStyle()

    HeroHealth = self.health
end

function Hero:touched(touch)
    -- Codea does not automatically call this method
    if touch.state == ENDED then --and self.invulnDuration == 0 then
        self:attack()
    end
end
