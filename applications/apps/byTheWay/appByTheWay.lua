App('AppByTheWay')

function AppByTheWay:init()
    Application.init(self)
    
    supportedOrientations(LANDSCAPE_ANY)
    
    setupTouch()
    
    touchs = Table()

    ways = Table()
    bots = Table()
    areas = Table()
    botGenerator = BotGenerator(100, 100)
    
    function test(y, d, force)      
        local area = Area(150, y - 20, 100, 40, force)
        areas:insert(area)
    end
    
    test(100, 0, vec2( 1000,0))
    test(200,10, vec2(-1000,0))
    test(300,15)
    test(400,20)
    
    areas:insert(AreaDirection(250, 380, 40, 40, vec2(1000,10000)))
    areas:insert(Area(250, 420, 40, 40, vec2(0,1000)))
    
    areas:insert(Area(250, 80, 100, 40, vec2(-1000,0)))
    
    parameter.action("restart", restart)
    parameter.boolean("running", true)
    parameter.boolean("addWayOrArea", true)
end

function AppByTheWay:touched(touch)
    touched(touch)
end

function AppByTheWay:update(dt)
    if not running then return end
    
    updateWays(dt)
    updateBots(dt)
    
    botGenerator:update(dt)
end

function AppByTheWay:draw()
    background(51)
    
    for _,points in ipairs(touchs) do
        theme("way")
        for _,f,t in points:by2() do
            line(f.x, f.y, t.x, t.y)
        end
    end

    ways:draw()
    bots:draw()
    
    areas:draw()
    
    botGenerator:draw()
end
    
function updateWays(dt)
    for i,way in ipairs(ways) do
        way:update(dt)
        if way.active == false then
            ways:remove(i)
        end
    end
    
    for i,bot in ipairs(bots) do
        for i,way in ipairs(ways) do
            bot:applyWay(way)                   
        end
    end
end

function updateBots(dt)
    for i,bot in ipairs(bots) do
        applyWay(bot)   
        bot:update(dt)
    end
    
    checkBot2Bot(bot, dt)
    
    for i,bot in ipairs(bots) do  
        checkBot2Area(bot, dt)
        checkBot2Zone(bot, dt)
    end
end

function applyWay(bot)
    for i,way in ipairs(ways) do
        bot:applyWay(way)                   
    end
end

function checkBot2Bot(bot)
    local n = #bots
    for i1 = 1,n-1 do
        local bot1 = bots[i1]
        for i2 = i1+1,n do
            local bot2 = bots[i2]
                
            local v = bot2.position - bot1.position
                
            local dist = v:len()
            local distMin = bot1.r + bot2.r
                
            if dist <= distMin then
                collide(bot1, bot2) 
            end
        end
    end
end

function checkBot2Area(bot, dt)
    for i,area in ipairs(areas) do
        if area:contains(bot.position.x, bot.position.y) then
            area:applyActionOn(bot, dt)
        end
    end
end

function checkBot2Zone(bot)
    if bot.position.x >= WIDTH or bot.position.x <= 0 then
        bot.linearVelocity.x = -bot.linearVelocity.x
        if bot.position.x <= 0 then
            bot.position.x = -bot.position.x
        else
            bot.position.x = 2 * WIDTH - bot.position.x
        end
    end
    
    if bot.position.y >= HEIGHT or bot.position.y <= 0 then
        bot.linearVelocity.y = -bot.linearVelocity.y
        if bot.position.y <= 0 then
            bot.position.y = -bot.position.y
        else
            bot.position.y = 2 * HEIGHT - bot.position.y
        end          
    end
end

function collide(bot1, bot2)
    local v = (bot2.position - bot1.position):normalize()
    
    local mt1 = massTransfer(bot1.linearVelocity,  v)
    local mt2 = massTransfer(bot2.linearVelocity, -v)
                    
    local speed1 = bot1.linearVelocity:len() * mt1
    local speed2 = bot2.linearVelocity:len() * mt2

    bot1.linearVelocity = bot1.linearVelocity * (1-mt1)
    bot2.linearVelocity = bot2.linearVelocity * (1-mt2)
    
    bot1:applyForce(-v*speed2)
    bot2:applyForce( v*speed1)
end

function massTransfer(v1, v2)
    local v = math.abs(math.deg(v1:angleBetween(v2)))
    if v < 90 then
        return 1 - v / 90
    end
    return 0
end