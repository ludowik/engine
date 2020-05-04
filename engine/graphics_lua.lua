function background(clr)
    sdl.SDL_SetRenderDrawColor(engine.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)
    sdl.SDL_RenderClear(engine.context)
end

function point(x, y)
    clr = stroke()
    sdl.SDL_SetRenderDrawColor(engine.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)
    sdl.SDL_RenderDrawPoint(engine.context, x, y)
end

local buffer, size_buffer
function points(points)
    local n = #points / 2

    if size_buffer == nil or size_buffer < n then
        buffer = ffi.new('SDL_Point[?]', n)
        size_buffer = n
    end

    for i=0,n-1 do
        buffer[i].x = points[i*2+1]
        buffer[i].y = points[i*2+2]
    end

    clr = stroke()
    if clr then
        sdl.SDL_SetRenderDrawColor(engine.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)
        sdl.SDL_RenderDrawPoints(engine.context, buffer, n)
    end
end

function text(str, x, y)
    clr = stroke()
    if crl then
        sdl.SDL_SetRenderDrawColor(engine.context, clr.r*255, clr.g*255, clr.b*255, clr.a*255)
    end
end
