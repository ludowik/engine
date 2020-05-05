function background(clr)
end

function point(x, y)
    clr = stroke()
    
    Mesh():render()
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
    end
end

function text(str, x, y)
    clr = stroke()
    if crl then
    end
end
