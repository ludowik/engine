class 'Graphics' : extends(Component)

local buf, meshPoints, meshLine, meshPolyline, meshPolygon, meshRect, meshEllipse, meshSprite, meshBox

function Graphics:initialize()
    meshPoints = Mesh()
    meshPoints.vertices = Buffer('vec3', {
            vec3(), vec3(), vec3(), vec3()})
    meshPoints.shader = shaders['points']

    meshLines = Mesh()
    meshLines.vertices = Buffer('vec3', {
            vec3(1, 1), vec3(1, 1),
            vec3(1, 1), vec3(1, 1),
            vec3(0, 0), vec3(0, 0),
            vec3(0, 0), vec3(0, 0)})
    meshLines.shader = shaders['lines']

    meshPolyline = Mesh()
    meshPolyline.vertices = Buffer('vec3', {
            vec3(1, 1), vec3(1, 1),
            vec3(1, 1), vec3(1, 1),
            vec3(0, 0), vec3(0, 0),
            vec3(0, 0), vec3(0, 0)})
    meshPolyline.shader = shaders['polyline']

    meshPolygon = Mesh()
    meshPolygon.vertices = Buffer('vec3', {
            vec3(1, 1), vec3(1, 1),
            vec3(1, 1), vec3(1, 1),
            vec3(0, 0), vec3(0, 0),
            vec3(0, 0), vec3(0, 0)})
    meshPolygon.shader = shaders['polygon']

    meshCircle = Mesh() -- Model.ellipse(0, 0, 1, 1)
    meshCircle.shader = shaders['circle']
    meshCircle.vertices = Buffer('vec3', {
            vec3(), vec3(), vec3(), vec3()})

    meshEllipse = Mesh() -- Model.ellipse(0, 0, 1, 1)
    meshEllipse.shader = shaders['ellipse']
    meshEllipse.vertices = Buffer('vec3', {
            vec3(), vec3(), vec3(), vec3()})

    meshSprite = Model.rect(0, 0, 1, 1)
    meshSprite.shader = shaders['sprite']

    meshText = Model.rect(0, 0, 1, 1)
    meshText.shader = shaders['text']

    meshBox = Model.box()
    meshBox.shader = shaders['box']

    meshSphere = Model.sphere()
    meshBox.shader = shaders['sphere']

    meshPyramid = Model.pyramid()
    meshBox.shader = shaders['model3d']

    meshAxesX = Model.cylinder(1, 1, 10000):center()
    meshAxesX:setColors(red)
    meshAxesX.shader = Shader('default')

    meshAxesY = Model.cylinder(1, 1, 10000):center()
    meshAxesY:setColors(green)
    meshAxesY.shader = Shader('default')

    meshAxesZ = Model.cylinder(1, 1, 10000):center()
    meshAxesZ:setColors(blue)
    meshAxesZ.shader = Shader('default')

    -- TODO : intialiser dans un contexte plus logique
    resetStyle()
end

function Graphics:release()
    -- TODO : libérer les mesh
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
    gl.glClearDepthf(1)

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

local Z
function zLevel(z)
    if z then 
        Z = z
    end
    return Z
end

function point(...)
    meshPoint = Mesh()
    meshPoint.vertices = Buffer('vec3', {vec3(), vec3(), vec3(), vec3()})
    meshPoint.shader = shaders['point']

    point = function(x, y)
        local diameter = max(strokeWidth(), 0)
        meshPoint.inst_pos = Buffer('vec3', {vec3(x,y)})
        meshPoint:render(meshPoint.shader, gl.GL_TRIANGLE_STRIP, nil, 0, 0, Z, diameter, diameter, 1)
    end

    point(...)
end

function points(vertices, ...)
    if type(vertices) == 'number' then vertices = {vertices, ...} end

    if stroke() then
        local diameter = max(strokeWidth(), 0)
        meshPoints.inst_pos = vertices
        meshPoints:render(meshPoints.shader, gl.GL_TRIANGLE_STRIP, nil, 0, 0, Z, diameter, diameter, 1, #meshPoints.inst_pos)
    end
end

function primitive(name, setup, draw)
    _G[name] = function (...)
        setup()
        _G[name] = draw
        draw(...)
    end
end

primitive('line',
    function ()
        meshLine = Mesh()
        meshLine.vertices = Buffer('vec3', {
                vec3(1, 1), vec3(1, 1),
                vec3(1, 1), vec3(1, 1),
                vec3(0, 0), vec3(0, 0),
                vec3(0, 0), vec3(0, 0)})
        meshLine.shader = shaders['line']
    end,

    function (x1, y1, x2, y2)
        meshLine:render(meshLine.shader, gl.GL_TRIANGLE_STRIP, nil, x1, y1, Z, x2-x1, y2-y1, 1)
    end)

function lines(vertices)
    meshLines.inst_pos = meshLines.inst_pos or Buffer('vec3')
    meshLines.inst_size = meshLines.inst_size or Buffer('vec3')

    meshLines.inst_pos:reset()
    meshLines.inst_size:reset()

    for i=1,#vertices,2 do
        meshLines.inst_pos:add(vertices[i])
        meshLines.inst_size:add(vertices[i+1]-vertices[i])
    end

    meshLines:render(meshLines.shader, gl.GL_TRIANGLE_STRIP, nil, 0, 0, Z, 1, 1, 1, #meshLines.inst_pos)
end

function polyline(vertices)
    meshPolyline.inst_pos = meshPolyline.inst_pos or Buffer('vec3')
    meshPolyline.inst_size = meshPolyline.inst_size or Buffer('vec3')

    meshPolyline.inst_pos:reset()
    meshPolyline.inst_size:reset()

    for i=1,#vertices-1 do
        meshPolyline.inst_pos:add(vertices[i])
        meshPolyline.inst_size:add(vertices[i+1]-vertices[i])
    end

    meshPolyline:render(meshPolyline.shader, gl.GL_TRIANGLE_STRIP, nil, 0, 0, Z, 1, 1, 1, #meshPolyline.inst_pos)
end

function polygon(vertices)
    meshPolygon.inst_pos = meshPolygon.inst_pos or Buffer('vec3')
    meshPolygon.inst_size = meshPolygon.inst_size or Buffer('vec3')

    meshPolygon.inst_pos:reset()
    meshPolygon.inst_size:reset()

    for i=1,#vertices-1 do
        meshPolygon.inst_pos:add(vertices[i])
        meshPolygon.inst_size:add(vertices[i+1]-vertices[i])
    end

    meshPolygon.inst_pos:add(vertices[#vertices])
    meshPolygon.inst_size:add(vertices[1]-vertices[#vertices])

    meshPolygon:render(meshPolygon.shader, gl.GL_TRIANGLE_STRIP, nil, 0, 0, Z, 1, 1, 1, #meshPolygon.inst_pos)
end

function rect(...)
    meshRect = Mesh()
    meshRect.shader = shaders['rect']
    meshRect.vertices = Buffer('vec3', {
            vec3(1,0), vec3(1,1),
            vec3(0,0), vec3(0,1)})

    rect = function (x, y, w, h, r, mode)
        h = h or w
        x, y = centerFromCorner(mode or rectMode(), x, y, w, h)

        if r then
            meshRect:render(meshRect.shader, gl.GL_TRIANGLE_STRIP, nil, x, y+r, Z, w, h-2*r, 1)
            meshRect:render(meshRect.shader, gl.GL_TRIANGLE_STRIP, nil, x+r, y, Z, w-2*r, h, 1)
            circle(x  +r+0.5, y  +r+0.5, r)
            circle(x+w-r-0.5, y  +r+0.5, r)
            circle(x  +r+0.5, y+h-r-0.5, r)
            circle(x+w-r-0.5, y+h-r-0.5, r)
        else
            meshRect:render(meshRect.shader, gl.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
        end
    end

    rect(...)
end

function roundrect(x, y, w, h, r, mode)
    rect(x, y, w, h, r, mode)
end

function circle(x, y, r, mode)
    local w, h = r*2, r*2
    x, y = cornerFromCenter(mode or circleMode(), x, y, w, h)

    meshCircle:render(meshCircle.shader, gl.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
end

function ellipse(x, y, w, h, mode)
    h = h or w
    x, y = cornerFromCenter(mode or ellipseMode(), x, y, w, h)

    meshEllipse:render(meshEllipse.shader, gl.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
end

function sprite(img, x, y, w, h, mode)
    if type(img) == 'string' then
        img = resourceManager:get('image', img, image)
    end

    if img and img.surface then
        w = w or img.surface.w
        h = h or img.surface.h * w / img.surface.w

        x, y = centerFromCorner(mode or spriteMode(), x, y, w, h)

        meshSprite:render(meshSprite.shader, gl.GL_TRIANGLES, img, x, y, Z, w, h, 1)
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

function textProc(draw, str, x, y)
    local w, h = 0, 0

    if draw then
        local tw, th = textProc(false, str)

        x = x or 0

        if y then
            TEXT_NEXT_Y = y - th
        else
            TEXT_NEXT_Y = TEXT_NEXT_Y - th
            y = TEXT_NEXT_Y
        end

        x, y = centerFromCorner(mode or textMode(), x, y, tw, th)

        y = y + th
    end

    local marge = 2
    local ratio = osx and 2 or 1

    local lines = str:split(NL, false)

    for i,line in ipairs(lines) do
        local img = ft:getText(line).img

        local lw, lh = img.surface.w/ratio, img.surface.h/ratio

        if draw then
            y = y - lh
            meshText:render(meshText.shader, gl.GL_TRIANGLES, img,
                x, y - marge, Z,
                lw, lh, 1)
        end

        lh = lh + marge * 2

        w = max(w, lw)
        h = h + lh
    end

    return w, h
end

function text(str, x, y)
    str = tostring(str)
    if fill() then
        return textProc(true, str, x, y)
    end
    return textProc(false, str)
end

function textSize(str)
    return textProc(false, tostring(str))
end

function plane()
end

function box(w, h, d, img)
    if type(w) == 'table' then
        img = w
    end

    w = w or 1
    h = h or w
    d = d or w

    meshBox:render(meshBox.shader, gl.GL_TRIANGLES, img, 0, 0, Z, w, h, d)
end

function sphere(w, h, d, img)
    if type(w) == 'table' then
        img = w
    end

    w = w or 1
    h = h or w
    d = d or w

    meshSphere:render(meshBox.shader, gl.GL_TRIANGLES, img, 0, 0, Z, w, h, d)
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
        meshAxesX:draw()

        rotate(-90, 1, 0, 0)
        meshAxesY:draw()

        rotate(90, 0, 1, 0)
        meshAxesZ:draw()
    end
    popMatrix()
end
