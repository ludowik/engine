function mode()
    sdl.SDL_GL_SetSwapInterval(0)

    if false then
        gl.glDisable(gl.GL_DEPTH_TEST)
    else
        gl.glEnable(gl.GL_DEPTH_TEST)
        gl.glDepthFunc(gl.GL_LEQUAL)
    end

    gl.glDisable(gl.GL_CULL_FACE)

    blendMode(NORMAL)

--    gl.glEnable(gl.GL_TEXTURE_2D)
end

NORMAL = 1
ADDITIVE = 2
MULTIPLY = 3

local currentBlendMode

function blendMode(mode)
    if mode then
        if currentBlendMode ~= mode then
            currentBlendMode = mode

            if mode == NORMAL then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
--                gl.glBlendFunc(gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA)
                gl.glBlendFuncSeparate(
                    gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA, 
                    gl.GL_ONE, gl.GL_ONE_MINUS_SRC_ALPHA)

            elseif mode == ADDITIVE then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
                gl.glBlendFunc(gl.GL_ONE, gl.GL_ONE)

            elseif mode == MULTIPLY then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
                gl.glBlendFuncSeparate(
                    gl.GL_DST_COLOR, gl.GL_ZERO,
                    gl.GL_DST_ALPHA, gl.GL_ZERO)

            else
                assert(false, mode)
            end
        end
    end
    return currentBlendMode
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
        clr = stroke()
        if clr then
            meshPoints.points = vertices
            meshPoints:render(meshPoints.shader, gl.GL_POINTS)
        end
    end

    points(...)
end

function line(...)
    local buf = Buffer('float')

    function line(x1, y1, x2, y2)
        buf[1] = x1
        buf[2] = y1
        buf[3] = x2
        buf[3] = y2
        lines(buf)
    end

    line(...)
end

function lines(...)
    local meshPoints = Mesh()
    meshPoints.shader = shaders['line']

    function lines(vertices)
        clr = stroke()
        if clr then
            meshPoints.points = vertices
            meshPoints:render(meshPoints.shader, gl.GL_LINES)
        end
    end

    lines(...)
end

function polyline(...)
    local meshPolyline = Mesh()
    meshPolyline.shader = shaders['polyline']

    function polyline(vertices)
        clr = stroke()
        if clr then
            meshPolyline.points = vertices
            meshPolyline:render(meshPolyline.shader, gl.GL_LINE_STRIP)
        end
    end

    polyline(...)
end

function polygon(...)
    local meshPolygon = Mesh()
    meshPolygon.shader = shaders['polygon']

    function polygon(vertices)
        clr = stroke()
        if clr then
            meshPolygon.points = vertices
            meshPolygon:render(meshPolygon.shader, gl.GL_LINE_LOOP)
        end
    end

    polygon(...)
end

function rect(...)
    local meshRect = Mesh()
    meshRect.vertices = Model.rect(0, 0, 1, 1)
    meshRect.shader = shaders['rect']

    function rect(x, y, w, h)
        meshRect:render(meshRect.shader, gl.GL_TRIANGLES, nil, x, y, w, h)
    end

    rect(...)
end

function circle(x, y, r)
    ellipse(x, y, r*2, r*2)
end

function ellipse(...)
    local meshEllipse = Mesh()
    meshEllipse.vertices = Model.ellipse(0, 0, 1, 1)
    meshEllipse.shader = shaders['ellipse']

    function ellipse(x, y, w, h)
        h = h or w 
        meshEllipse:render(meshEllipse.shader, gl.GL_TRIANGLES, nil, x, y, w, h)
    end

    ellipse(...)
end

function sprite(...)
    local meshSprite = Mesh()
    meshSprite.vertices, meshSprite.texCoords = Model.rect(0, 0, 1, 1)
    meshSprite.shader = shaders['sprite']

    function sprite(img, x, y)
        meshSprite:render(meshSprite.shader, gl.GL_TRIANGLES, img, x, y, img.surface.w, img.surface.h)
    end

    sprite(...)
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

            TEXT_NEXT_Y = y - img.surface.h

            meshText:render(meshText.shader, gl.GL_TRIANGLES, img, x, TEXT_NEXT_Y, img.surface.w, img.surface.h)

            img:release()
            ft.release_text(txt)
        end
    end

    text(...)
end

function box(...)
    local mesh = Mesh()
    mesh.vertices, mesh.texCoords = Model.box()
    mesh.shader = shaders['box']

    function box(img)
        mesh:render(mesh.shader, gl.GL_TRIANGLES, img)
    end

    box(...)
end
