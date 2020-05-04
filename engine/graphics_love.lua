function background(clr)
    love.graphics.clear(clr.r, clr.g, clr.b, clr.a)
end

function point(x, y)
    love.graphics.replaceTransform(transform)
    love.graphics.point(x, y)
end

function points(...)
    love.graphics.replaceTransform(transform)
    love.graphics.points(...)
end

function text(str, x, y)
    love.graphics.replaceTransform(transform)
    love.graphics.print(str, x, y)
end
