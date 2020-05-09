function mode()
    sdl.SDL_GL_SetSwapInterval(0)

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

local meshPoints = Mesh()
local buf = {}
function point(x, y)
    buf[1] = x 
    buf[2] = y
    points(buf)
end

function points(points)
    local n = #points / 2

    clr = stroke()
    if clr then
        meshPoints.points = points
        meshPoints:render(shaders['point'], gl.GL_POINTS)
    end
end

TEXT_NEXT_Y = 0

local meshText = Mesh()
meshText.vertices = Model.rect(0, 0, 1, 1)
function text(str, x, y)
    str = tostring(str)

    clr = stroke()
    if clr then
        local hText = ft.load_text(ft.hFont, str)
        local img = Image():makeTexture(hText)

        TEXT_NEXT_Y = y + img.surface.h

        meshText:render(shaders['text'], gl.GL_TRIANGLES, img, x, y, img.surface.w, img.surface.h)

        img:release()
        ft.release_text(hText)
    end
end
