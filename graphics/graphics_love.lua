function background(clr)
    love.graphics.clear(clr.r, clr.g, clr.b, clr.a)
end

function point(x, y)
    love.graphics.replaceTransform(transform)
    love.graphics.points(x, y)
end

function points(...)
    love.graphics.replaceTransform(transform)
    love.graphics.points(...)
end

function text(str, x, y)
    local texture = love.graphics.newText(love.graphics.getFont(), str)

    love.graphics.replaceTransform(transform)
    love.graphics.draw(texture, x, y)
    
    TEXT_NEXT_Y = y + texture:getHeight()
end
