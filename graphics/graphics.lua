class 'Graphics' : extends(Component)

local buf, meshPoints, meshLine, meshPolyline, meshPolygon, meshRect, meshEllipse, meshSprite, meshBox

function Graphics:initialize()
    buf = Buffer('vec3')

    meshPoints = Mesh()
    meshPoints.shader = shaders['point']

    meshLine = Mesh()
    meshLine.shader = shaders['line']

    meshPolyline = Mesh()
    meshPolyline.shader = shaders['polyline']

    meshPolygon = Mesh()
    meshPolygon.shader = shaders['polygon']

    meshRect = Model.rect(0, 0, 1, 1)
    meshRect.shader = shaders['rect']

    meshRectBorder = Model.rectBorder(0, 0, 1, 1)
    meshRectBorder.shader = shaders['line']

    meshEllipse = Model.ellipse(0, 0, 1, 1)
    meshEllipse.shader = shaders['ellipse']
    
    meshEllipseBorder = Model.ellipseBorder(0, 0, 1, 1)
    meshEllipseBorder.shader = shaders['line']

    meshSprite = Model.rect(0, 0, 1, 1)
    meshSprite.shader = shaders['sprite']

    meshText = Model.rect(0, 0, 1, 1)
    meshText.shader = shaders['text']

    meshBox = Model.box()
    meshBox.shader = shaders['box']

    meshSphere = Model.sphere()

    meshPyramid = Model.pyramid()

    meshCylinder = Model.cylinder(1, 1, 10000):center()

    self:update()
end

function Graphics:release()
end

function Graphics:update()
    resetMatrix()
    resetStyle()
end

-- blend mode
NORMAL = 1
ADDITIVE = 2
MULTIPLY = 3

function blendMode(mode)
    if mode then
        if styles.blendMode ~= mode then
            styles.blendMode = mode

            if mode == NORMAL then
                gl.glEnable(gl.GL_BLEND)
                gl.glBlendEquation(gl.GL_FUNC_ADD)
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
    return styles.blendMode
end

function cullingMode(culling)
    if culling ~= nil then
        styles.cullingMode = culling

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
    return styles.cullingMode
end

function depthMode(mode)
    if mode ~= nil then
        styles.depthMode = mode

        if mode then
            gl.glEnable(gl.GL_DEPTH_TEST)
            gl.glDepthFunc(gl.GL_LEQUAL)
        else
            gl.glDisable(gl.GL_DEPTH_TEST)
        end
    end
    return styles.depthMode
end

function background(clr, ...)
    clr = Color.args(clr, ...)

    gl.glClearColor(clr.r, clr.g, clr.b, clr.a)
    gl.glClearDepth(1)

    gl.glClear(
        gl.GL_COLOR_BUFFER_BIT +
        gl.GL_DEPTH_BUFFER_BIT)
end

local function centerFromCorner(mode, x, y, w, h)
    x = x or 0
    y = y or 0
    if mode == CENTER then
        x = x - w / 2
        y = y - h / 2
    end
    return x, y
end

local function cornerFromCenter(mode, x, y, w, h)
    x = x or 0
    y = y or 0
    if mode == CORNER then
        x = x + w / 2
        y = y + h / 2
    end
    return x, y
end

function point(x, y)
    buf[1].x = x     
    buf[1].y = y
    buf[1].z = 0

    points(buf)
end

function points(vertices, ...)
    if type(vertices) == 'number' then vertices = {vertices, ...} end

    if stroke() then
        meshPoints.vertices = vertices
        meshPoints:render(meshPoints.shader, gl.GL_POINTS)
    end
end

function line(x1, y1, x2, y2)
    buf[1].x = x1
    buf[1].y = y1
    buf[1].z = 0

    buf[2].x = x2
    buf[2].y = y2
    buf[2].z = 0

    lines(buf)
end

function lines(vertices)
    if stroke() then
        meshLine.vertices = vertices
        meshLine:render(meshLine.shader, gl.GL_LINES)
    end
end

function polyline(vertices)
    if stroke() then
        meshPolyline.vertices = vertices
        meshPolyline:render(meshPolyline.shader, gl.GL_LINE_STRIP)
    end
end

function polygon(vertices)
    if stroke() then
        meshPolygon.vertices = vertices
        meshPolygon:render(meshPolygon.shader, gl.GL_LINE_LOOP)
    end
end

function rect(x, y, w, h, mode)
    h = h or w
    x, y = centerFromCorner(mode or rectMode(), x, y, w, h)
    
    if fill() then
        meshRect:render(meshRect.shader, gl.GL_TRIANGLES, nil, x, y, w, h)
    end
    if stroke() then
        meshRectBorder:render(meshRectBorder.shader, gl.GL_LINE_LOOP, nil, x, y, w, h)
    end
end

function circle(x, y, r)
    ellipse(x, y, r*2, r*2, circleMode())
end

function ellipse(x, y, w, h, mode)
    h = h or w
    x, y = cornerFromCenter(mode or ellipseMode(), x, y, w, h)
    
    if fill() then
        meshEllipse:render(meshEllipse.shader, gl.GL_TRIANGLES, nil, x, y, w, h)
    end
    if stroke() then
        meshEllipseBorder:render(meshEllipseBorder.shader, gl.GL_LINE_LOOP, nil, x, y, w, h)
    end
end

function sprite(img, x, y, mode)    
    if type(img) == 'string' then
        img = image(img)
    end
    if img and img.surface then
        x, y = centerFromCorner(mode or spriteMode(), x, y, img.surface.w, img.surface.h)
        meshSprite:render(meshSprite.shader, gl.GL_TRIANGLES, img, x, y, img.surface.w, img.surface.h)
    end
end

function spriteSize(img)
    if type(img) == 'string' then
        img = image(img)
    end
    if img and img.surface then
        return img.surface.w, img.surface.h
    end
    return 0,0
end

function font(name)
    ft:setFontName(name)
end

function fontSize(size)
    ft:setFontSize(size)
end

function text(str, x, y, mode)
    str = tostring(str)

    x = x or 0
    y = y or TEXT_NEXT_Y

    if stroke() then
        local img = ft:getText(str)

        x, y = centerFromCorner(mode or textMode(), x, y, img.surface.w, img.surface.h)
        TEXT_NEXT_Y = y - img.surface.h
        
        meshText:render(meshText.shader, gl.GL_TRIANGLES, img, x, TEXT_NEXT_Y, img.surface.w, img.surface.h)
    end
end

function textSize(str)
    str = tostring(str)

    local img = ft:getText(str)
    return img.surface.w, img.surface.h
end

function plane()
end

function box(img, x, y, z)
    if type(img) == 'number' then
        x, y, z = img, x, y
        img = nil
    end
    meshBox:render(meshBox.shader, gl.GL_TRIANGLES, img, x, y)
end

function sphere()
end

function pyramid()
end

function MeshAxes(x, y, z)
    x, y, z = xyz(x, y, z)

    pushMatrix()
    do
        translate(x, y, z)

        scale(0.01, 0.01, 0.01)

        rotate(90, 0, 1, 0)
        meshCylinder:setColors(red)
        meshCylinder:draw()

        rotate(-90, 1, 0, 0)
        meshCylinder:setColors(green)
        meshCylinder:draw()

        rotate(90, 0, 1, 0)
        meshCylinder:setColors(blue)
        meshCylinder:draw()
    end
    popMatrix()
end
