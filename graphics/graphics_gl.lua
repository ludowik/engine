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

local __clr = Color()
function temp_color(r, g, b, a)
    if type(r) == 'cdata' then
        return r
    else
        __clr:set(r, g, b, a)
        return __clr
    end
end

function background(clr, ...)
    clr = temp_color(clr, ...)

    gl.glClearColor(clr.r, clr.g, clr.b, clr.a)
    gl.glClearDepth(1)

    gl.glClear(
        gl.GL_COLOR_BUFFER_BIT +
        gl.GL_DEPTH_BUFFER_BIT)
end

function point(...)
    local buf = Buffer('float')

    function point(x, y)
        buf[1] = x 
        buf[2] = y
        points(buf)
    end

    point(...)
end

function points(...)
    local meshPoints = Mesh()
    meshPoints.shader = shaders['point']

    function points(vertices)
        local n = #vertices / 2

        clr = stroke()
        if clr then
            meshPoints.points = vertices
            meshPoints:render(meshPoints.shader, gl.GL_POINTS)
        end
    end

    points(...)
end

function line(x1, y1, x2, y2)
end

function circle(...)
    local meshCircle = Mesh()
    meshCircle.vertices = Model.circle(0, 0, 1)
    meshCircle.shader = shaders['default']

    function circle(x, y, r)
        meshCircle:render(meshCircle.shader, gl.GL_TRIANGLES, nil, x, y, r, r)
    end

    circle(...)
end


function sprite(image, x, y)
    local meshSprite = Mesh()
    meshSprite.vertices, meshSprite.texCoords = Model.rect(0, 0, 1, 1)
    meshSprite.shader = shaders['sprite']

    meshSprite:render(meshSprite.shader, gl.GL_TRIANGLES, image, x, y, image.surface.w, image.surface.h)
end

function text(...)
    TEXT_NEXT_Y = 0

    local meshText = Mesh()
    meshText.vertices, meshText.texCoords = Model.rect(0, 0, 1, 1)
    meshText.shader = shaders['text']

    function text(str, x, y)
        str = tostring(str)

        clr = stroke()
        if clr then
            local txt = ft.load_text(ft.hFont, str)
            local img = Image():makeTexture(txt)

            TEXT_NEXT_Y = y + img.surface.h

            meshText:render(meshText.shader, gl.GL_TRIANGLES, img, x, y, img.surface.w, img.surface.h)

            img:release()
            ft.release_text(txt)
        end
    end

    text(...)
end
