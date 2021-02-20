class 'Graphics' : extends(Component)

local buf, meshPoints, meshLine, meshPolyline, meshPolygon, meshRect, meshEllipse, meshSprite, meshBox

function Graphics:initialize()
    meshPoints = Mesh()
    meshPoints.vertices = Buffer('vec3', {
            vec3(),
            vec3(),
            vec3(),
            vec3()})
    meshPoints.shader = shaders['points']

    meshLines = Mesh()
    meshLines.vertices = Buffer('vec3', {
            vec3(1, 1), vec3(1, 1),
            vec3(1, 1), vec3(1, 1),
            vec3(0, 0), vec3(0, 0),
            vec3(0, 0), vec3(0, 0)})
    meshLines.shader = shaders['lines']

    meshLines3D = Mesh()
    meshLines3D.vertices = Buffer('vec3', {
            vec3(1, 1, 1), vec3(1, 1, 1),
            vec3(1, 1, 1), vec3(1, 1, 1),
            vec3(0, 0), vec3(0, 0),
            vec3(0, 0), vec3(0, 0)})
    meshLines3D.shader = shaders['lines']

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

    meshCircle = Mesh()
    meshCircle.shader = shaders['circle']
    meshCircle.vertices = Buffer('vec3', {
            vec3(),
            vec3(),
            vec3(),
            vec3()})

    meshEllipse = Mesh()
    meshEllipse.shader = shaders['ellipse']
    meshEllipse.vertices = Buffer('vec3', {
            vec3(),
            vec3(),
            vec3(),
            vec3()})

    meshArc = Mesh()
    meshArc.shader = shaders['circle']
    meshArc.vertices = Buffer('vec3', {
            vec3(),
            vec3(),
            vec3(),
            vec3()})

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

    -- TODO : is the right place
    resetStyle()
end

function Graphics:release()
    -- TODO : release mesh
end

-- blend mode
NORMAL = 1
ADDITIVE = 2
MULTIPLY = 3

function blendMode(mode)
    if mode then
        if styles.attributes.blendMode ~= mode then
            styles.attributes.blendMode = mode
            renderer:blendMode(mode)
        end
    end
    return styles.attributes.blendMode
end

function cullingMode(culling)
    if culling ~= nil then
        styles.attributes.cullingMode = culling
        renderer:cullingMode(mode)
    end
    return styles.attributes.cullingMode
end

function depthMode(mode)
    if mode ~= nil then
        styles.attributes.depthMode = mode
        renderer:depthMode(mode)
    end
    return styles.attributes.depthMode
end

function background(clr, ...)
    clr = Color.args(clr, ...)
    renderer:clear(clr)
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

    point = function(x, y, z)
        local diameter = max(strokeWidth(), 0)
        meshPoint.inst_pos = Buffer('vec3', {vec3(x,y,z or Z)})
        meshPoint:render(meshPoint.shader, renderer.GL_TRIANGLE_STRIP, nil, 0, 0, 0, diameter, diameter, 1)
    end

    point(...)
end

function points(vertices, ...)
    if type(vertices) == 'number' then vertices = {vertices, ...} end

    if stroke() then
        local diameter = max(strokeWidth(), 0)
        meshPoints.inst_pos = vertices
        meshPoints:render(meshPoints.shader, renderer.GL_TRIANGLE_STRIP, nil, 0, 0, Z, diameter, diameter, 1, #meshPoints.inst_pos)
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
        meshLine:render(meshLine.shader, renderer.GL_TRIANGLE_STRIP, nil, x1, y1, Z, x2-x1, y2-y1, 0)
    end)

primitive('line3D',
    function ()
        meshLine3D = Mesh()
        meshLine3D.vertices = Buffer('vec3', {
                vec3(1, 1, 1), vec3(1, 1, 1),
                vec3(1, 1, 1), vec3(1, 1, 1),
                vec3(), vec3(),
                vec3(), vec3()})
        meshLine3D.shader = shaders['line']
    end,

    function (x1, y1, z1, x2, y2, z2)
        meshLine3D:render(meshLine3D.shader, renderer.GL_TRIANGLE_STRIP, nil, x1, y1, z1, x2-x1, y2-y1, z2-z1)
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

    meshLines:render(meshLines.shader, renderer.GL_TRIANGLE_STRIP, nil, 0, 0, Z, 1, 1, 1, #meshLines.inst_pos)
end

function lines3D(vertices)
    meshLines3D.inst_pos = meshLines3D.inst_pos or Buffer('vec3')
    meshLines3D.inst_size = meshLines3D.inst_size or Buffer('vec3')

    meshLines3D.inst_pos:reset()
    meshLines3D.inst_size:reset()

    for i=1,#vertices,2 do
        meshLines3D.inst_pos:add(vertices[i])
        meshLines3D.inst_size:add(vertices[i+1]-vertices[i])
    end

    meshLines3D:render(meshLines3D.shader, renderer.GL_TRIANGLE_STRIP, nil, 0, 0, 0, 1, 1, 1, #meshLines3D.inst_pos)
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

    meshPolyline:render(meshPolyline.shader, renderer.GL_TRIANGLE_STRIP, nil, 0, 0, Z, 1, 1, 1, #meshPolyline.inst_pos)
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

    meshPolygon:render(meshPolygon.shader, renderer.GL_TRIANGLE_STRIP, nil, 0, 0, Z, 1, 1, 1, #meshPolygon.inst_pos)
end

function bezier(x1, y1, x2, y2, x3, y3, x4, y4)
    local f = bezier_proc({x1,x2,x3,x4}, {y1,y2,y3,y4})
    strokeWidth(5)
    for i=0,1,0.01 do 
        point(f(i))
    end
end

--[[
    a parametric function describing the Bezier curve determined by given control points,
    which takes t from 0 to 1 and returns the x, y of the corresponding point on the Bezier curve
]]
function bezier_proc(xv, yv)
    local reductor = {__index = function(self, ind)
            return setmetatable({tree = self, level = ind}, {__index = function(curves, ind)
                        return function(t)
                            local x1, y1 = curves.tree[curves.level-1][ind](t)
                            local x2, y2 = curves.tree[curves.level-1][ind+1](t)
                            return x1 + (x2 - x1) * t, y1 + (y2 - y1) * t
                        end
                    end})
        end
    }
    local points = {}
    for i = 1, #xv do
        points[i] = function(t) return xv[i], yv[i] end
    end
    return setmetatable({points}, reductor)[#points][1]
end

function rect(...)
    meshRect = Mesh()
    meshRect.shader = shaders['rect']
    meshRect.vertices = Buffer('vec3', {
            vec3(1,0), vec3(1,1),
            vec3(0,0), vec3(0,1)})

    rect = function (x, y, w, h, r, mode)
        h = h or w
        x, y = centerFromCorner(mode or styles.attributes.rectMode, x, y, w, h)

        if r then
            meshRect:render(meshRect.shader, renderer.GL_TRIANGLE_STRIP, nil, x, y+r, Z, w, h-2*r, 1)
            meshRect:render(meshRect.shader, renderer.GL_TRIANGLE_STRIP, nil, x+r, y, Z, w-2*r, h, 1)
            circle(x  +r+0.5, y  +r+0.5, r)
            circle(x+w-r-0.5, y  +r+0.5, r)
            circle(x  +r+0.5, y+h-r-0.5, r)
            circle(x+w-r-0.5, y+h-r-0.5, r)
        else
            meshRect:render(meshRect.shader, renderer.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
        end
    end

    rect(...)
end

function roundrect(x, y, w, h, r, mode)
    rect(x, y, w, h, r, mode)
end

function circle(x, y, r, mode)
    local w, h = r*2, r*2
    x, y = cornerFromCenter(mode or styles.attributes.circleMode, x, y, w, h)

    meshCircle:render(meshCircle.shader, renderer.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
end

function ellipse(x, y, w, h, mode)
    h = h or w
    x, y = cornerFromCenter(mode or styles.attributes.ellipseMode, x, y, w, h)

    meshEllipse:render(meshEllipse.shader, renderer.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
end

function arc(x, y, r, angleMin, angleMax, mode)
    local w, h = r*2, r*2
    x, y = cornerFromCenter(mode or styles.attributes.circleMode, x, y, w, h)

    meshArc.uniforms.useAngle = 1

    meshArc.uniforms.angleMin = angleMin
    meshArc.uniforms.angleMax = angleMax

    meshArc:render(meshArc.shader, renderer.GL_TRIANGLE_STRIP, nil, x, y, Z, w, h, 1)
end

function sprite(img, x, y, w, h, mode)
    if type(img) == 'string' then
        img = resourceManager:get('image', img, image)
    end

    if img and img.surface then
        w = w or img.surface.w
        h = h or img.surface.h * w / img.surface.w

        x, y = centerFromCorner(mode or styles.attributes.spriteMode, x, y, w, h)

        meshSprite:render(meshSprite.shader, renderer.GL_TRIANGLES, img, x, y, Z, w, h, 1)
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

function text(str, x, y, mode)
    if fill() then
        return textProc(true, str, x, y, mode)
    end
    return textProc(false, str)
end

function textSize(str)
    return textProc(false, str)
end

do
    local lastRequest = {}

    local ratio = osx and 2 or 1
    local marge = 2    

    function textProc(draw, str, x, y, mode)
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

            x, y = centerFromCorner(mode or styles.attributes.textMode, x, y, tw, th)

            y = y + th

        elseif lastRequest.str == str and lastRequest.font == ft:getFont() then
            return lastRequest.w, lastRequest.h
        end

        local lines
        if lastRequest.str == str then
            lines = lastRequest.lines
        else
            lines = tostring(str):split(NL, false)
        end

        for i,line in ipairs(lines) do
            local text = ft:getText(line)
            if text then
                local img = ft:getText(line).img
                if img then
                    local lw, lh = img.surface.w/ratio, img.surface.h/ratio

                    if draw then
                        y = y - lh
                        meshText:render(meshText.shader, renderer.GL_TRIANGLES, img,
                            x, y - marge, Z,
                            lw, lh, 1)
                    end

                    lh = lh + marge * 2

                    w = max(w, lw)
                    h = h + lh
                end
            end
        end

        lastRequest.font = ft:getFont()
        lastRequest.str = str
        lastRequest.lines = lines

        lastRequest.w = w
        lastRequest.h = h

        return w, h
    end
end

-- TODO: new file 3d
function plane()
end

function xyz_whd_img(...)
    local args = {...}
    local x, y, z, w, h, d, img = 0, 0, Z, 1, 1, 1, nil

    if #args == 1 then
        if typeof(args[1]) == 'image' then
            img = args[1]
        else
            w, h, d = args[1], args[1], args[1]
        end

    elseif #args == 3 then
        w, h, d = args[1], args[2], args[3]

    elseif #args == 4 then
        if typeof(args[1]) == 'image' then
            w, h, d = args[1], args[2], args[3]
            img = args[4]
        else
            x, y, z = args[1], args[2], args[3]
            w, h, d = args[4], args[4], args[4]
        end

    elseif #args == 6 then
        x, y, z = args[1], args[2], args[3]
        w, h, d = args[4], args[5], args[6]

    elseif #args == 7 then
        x, y, z = args[1], args[2], args[3]
        w, h, d = args[4], args[5], args[6]
        img = args[7]
    end
    return x, y, z, w, h, d, img
end

function box(...)
    local x, y, z, w, h, d, img = xyz_whd_img(...)
    meshBox:render(meshBox.shader, renderer.GL_TRIANGLES, img, x, y, z, w, h, d)
end

function sphere(...)
    local x, y, z, w, h, d, img = xyz_whd_img(...)
    meshSphere:render(meshBox.shader, renderer.GL_TRIANGLES, img, x, y, z, w, h, d)
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
