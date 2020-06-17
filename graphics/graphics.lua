class 'Graphics' : extends(Component)

local buf, meshPoints, meshLine, meshPolyline, meshPolygon, meshRect, meshEllipse, meshSprite, meshBox

function Graphics:setup()
    buf = Buffer('float')

    meshPoints = Mesh()
    meshPoints.shader = shaders['point']

    meshLine = Mesh()
    meshLine.shader = shaders['line']

    meshPolyline = Mesh()
    meshPolyline.shader = shaders['polyline']

    meshPolygon = Mesh()
    meshPolygon.shader = shaders['polygon']

    meshRect = Mesh()
    meshRect.vertices = Model.rect(0, 0, 1, 1)
    meshRect.shader = shaders['rect']

    meshEllipse = Mesh()
    meshEllipse.vertices = Model.ellipse(0, 0, 1, 1)
    meshEllipse.shader = shaders['ellipse']

    meshSprite = Mesh()
    meshSprite.vertices, meshSprite.texCoords = Model.rect(0, 0, 1, 1)
    meshSprite.shader = shaders['sprite']

    TEXT_NEXT_Y = 0

    meshText = Mesh()
    meshText.vertices, meshText.texCoords = Model.rect(0, 0, 1, 1)
    meshText.shader = shaders['text']

    meshBox = Mesh()
    meshBox.vertices, meshBox.texCoords = Model.box()
    meshBox.shader = shaders['box']
end

function Graphics:release()
end

function mode()
    sdl.SDL_GL_SetSwapInterval(0)

    blendMode(NORMAL)

    depthMode(false)

    cullingMode(true)
end

local currentBlendMode

NORMAL = 1
ADDITIVE = 2
MULTIPLY = 3

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

local currentCullingMode
function cullingMode(culling)
    if culling ~= nil then
        currentCullingMode = culling

        if culling then
            gl.glEnable(gl.GL_CULL_FACE)

            gl.glFrontFace(gl.GL_CCW)
            if cullingFace == 'front' then
                gl.glCullFace(gl.GL_FRONT)
            else
                gl.glCullFace(gl.GL_BACK)
            end
        else
            gl.glDisable(gl.GL_CULL_FACE)
        end
    end
    return currentCullingMode
end

local currentDepthMode
function depthMode(mode)
    if mode ~= nil then
        currentDepthMode = mode

        if mode then
            gl.glEnable(gl.GL_DEPTH_TEST)
            gl.glDepthFunc(gl.GL_LEQUAL)
        else
            gl.glDisable(gl.GL_DEPTH_TEST)
        end
    end
    return currentDepthMode
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

function point(x, y)
    buf[1] = x 
    buf[2] = y
    points(buf)
end

function points(vertices)
    clr = stroke()
    if clr then
        meshPoints.points = vertices
        meshPoints:render(meshPoints.shader, gl.GL_POINTS)
    end
end

function line(x1, y1, x2, y2)
    buf[1] = x1
    buf[2] = y1
    buf[3] = x2
    buf[4] = y2

    lines(buf)
end

function lines(vertices)
    clr = stroke()
    if clr then
        meshLine.points = vertices
        meshLine:render(meshLine.shader, gl.GL_LINES)
    end
end

function polyline(vertices)
    clr = stroke()
    if clr then
        meshPolyline.points = vertices
        meshPolyline:render(meshPolyline.shader, gl.GL_LINE_STRIP)
    end
end

function polygon(vertices)
    clr = stroke()
    if clr then
        meshPolygon.points = vertices
        meshPolygon:render(meshPolygon.shader, gl.GL_LINE_LOOP)
    end
end

function rect(x, y, w, h)
    meshRect:render(meshRect.shader, gl.GL_TRIANGLES, nil, x, y, w, h)
end

function circle(x, y, r)
    ellipse(x, y, r*2, r*2)
end

function ellipse(x, y, w, h)
    h = h or w 
    meshEllipse:render(meshEllipse.shader, gl.GL_TRIANGLES, nil, x, y, w, h)
end

function sprite(img, x, y)
    meshSprite:render(meshSprite.shader, gl.GL_TRIANGLES, img, x, y, img.surface.w, img.surface.h)
end

function font(name)
end

function fontSize(size)
end

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

function textSize(str)
    str = tostring(str)

    local txt = ft.load_text(ft.hFont, str)
    local img = Image():makeTexture(txt)

    local w, h = img.surface.w, img.surface.h

    img:release()
    ft.release_text(txt)

    return w, h
end

function box(img)
    meshBox:render(meshBox.shader, gl.GL_TRIANGLES, img)
end
