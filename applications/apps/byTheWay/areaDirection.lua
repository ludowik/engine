AreaDirection = class('area.direction', Area)

function AreaDirection:init(x, y, w, h, force)
    Area.init(self, x, y, w, h, force)
end

function AreaDirection:applyActionOn(bot, dt)
    bot:applyDirection(self.force * dt)
end
