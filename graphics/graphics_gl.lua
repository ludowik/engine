function mode()
    gl.glEnable(gl.GL_DEPTH_TEST)
    gl.glDepthFunc(gl.GL_LEQUAL)

    gl.glDisable(gl.GL_CULL_FACE)

    gl.glEnable(gl.GL_BLEND)
    gl.glBlendEquation(gl.GL_FUNC_ADD)
    gl.glBlendFuncSeparate(
        gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA,
        gl.GL_ONE, gl.GL_ONE_MINUS_SRC_ALPHA)

    gl.glEnable(gl.GL_TEXTURE_2D)

end

function background(clr)
    gl.glClearColor(clr.r, clr.g, clr.b, clr.a)
    gl.glClearDepth(1)

    gl.glClear(
        gl.GL_COLOR_BUFFER_BIT +
        gl.GL_DEPTH_BUFFER_BIT)
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
