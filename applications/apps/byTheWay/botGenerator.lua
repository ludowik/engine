BotGenerator = class('botgenerator')

function BotGenerator:init(x, y, w, h)
    self.position = vec3(x, y)
    self.size = vec2(w, h)
    
    self.time = 0
    
    self.bot = 10
end

function BotGenerator:draw()
end

function BotGenerator:update(dt)
    self.time = self.time + dt 
    if self.time >= 1 and self.bot > 0 then
        self.bot = self.bot - 1
        self.time = 0
        
        local bot = Bot(self.position.x, self.position.y)
        bot.linearVelocity = vec2(200,0)
        bots:add(bot)
    end
end

function BotGenerator:touched(touch)
end
