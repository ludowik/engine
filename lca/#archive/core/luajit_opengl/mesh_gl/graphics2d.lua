class('graphics2d', graphics)

function graphics2d.setup()
    graphics2d:push2Global()

    graphics2d.meshLine = Model.line()
    graphics2d.meshRect, graphics2d.meshEdgesRect = Model.rect()
    graphics2d.meshEllipse, graphics2d.meshEdgesEllipse = Model.ellipse()
    graphics2d.meshSprite = Model.rect()    
    graphics2d.meshPolygon = Mesh()

    meshManager = MeshManager()
end

-- primitives
function graphics2d.point(x, y)
    local w = strokeWidth()
    x, y = center(CENTER, x, y, w, w)

    rect(x, y, w, w)    
end

function graphics2d.line(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1

    local dw = strokeWidth()
    local strokeColor = stroke()
    local mode = lineCapMode()

    if mode == PROJECT then
        local v1 = vec2(x1, y1) - vec2(dx, dy):normalize() * dw / 2
        local v2 = vec2(x2, y2) + vec2(dx, dy):normalize() * dw / 2

        x1, y1 = v1.x, v1.y
        x2, y2 = v2.x, v2.y

        dx = x2 - x1
        dy = y2 - y1
    end

    if dw > 0 and strokeColor ~= transparent then
        graphics2d.meshLine.shader = Shader.shaders['lines2d']
        graphics2d.meshLine:setColors(strokeColor)
        graphics2d.meshLine:addMesh2d(
            x1, y1, nil,
            dx, dy, nil,
            gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
    end

    if mode == ROUND then
        pushStyle()
        do
            local dx = dw/2

            fill(strokeColor)
            noStroke() 

            circleMode(CENTER)

            circle(x1, y1, dx)
            circle(x2, y2, dx)
        end
        popStyle()
    end
end

function graphics2d.lines(...)
    -- TODO
end

function graphics2d.rect(x, y, w, h)
    local mode = rectMode()
    if mode == CORNER then
        x, y = corner(mode, x, y, w, h)
    end

    local dw = strokeWidth()
    local dx = dw/2

    local strokeColor = stroke()
    local fillColor = fill()

    -- fill
    if fillColor ~= transparent then
        graphics2d.meshRect:setColors(fillColor)
        graphics2d.meshRect:addMesh2d(
            x, y, nil,
            w-dw, h-dw, nil)
    end

    -- stroke
    if dw > 0 and strokeColor ~= transparent then
        graphics2d.meshEdgesRect.shader = Shader.shaders['lines2d']
        graphics2d.meshEdgesRect:setColors(strokeColor)
        graphics2d.meshEdgesRect:addMesh2d(
            x, y, nil,
            w-dx, h-dx, nil,
            gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
    end 
end

function graphics2d.circle(x, y, r)
    ellipse(x, y, r*2, r*2, graphics.style.circleMode)
end

function graphics2d.ellipse(x, y, w, h, mode)
    h = h or w

    mode = mode or ellipseMode()
    if mode == CORNER then
        x, y = corner(mode, x, y, w, h)
    end

    local dw = strokeWidth()
    local dx = dw/2

    local strokeColor = stroke()
    local fillColor = fill()

    -- fill
    if fillColor ~= transparent then
        graphics2d.meshEllipse:setColors(fillColor)
        graphics2d.meshEllipse:addMesh2d(
            x, y, nil,
            w-dx, h-dx, nil)
    end

    -- stroke
    if dw > 0 and strokeColor ~= transparent then
        graphics2d.meshEdgesEllipse.shader = Shader.shaders['lines2d']
        graphics2d.meshEdgesEllipse:setColors(strokeColor)
        graphics2d.meshEdgesEllipse:addMesh2d(
            x, y, nil,
            w-dx, h-dx, nil,
            gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
    end        
end

function graphics2d.polyline(...)
    local vertices = vertices2vectors(...)

    local minVertex, maxVertex, size = Model.minmax(vertices)
    local w, h = size.x, size.y

    local x, y = 0, 0
    if polylineMode() == CORNER then
        x, y = corner(polylineMode(), x, y, w, h)
    end

    local dw = strokeWidth()
    local dx = dw/2

    local strokeColor = stroke()
    local fillColor = fill()

    -- stroke
    if dw > 0 and strokeColor ~= transparent then
        graphics2d.meshPolygon.vertices = vertices
        graphics2d.meshPolygon.shader = Shader.shaders['lines2d']
        graphics2d.meshPolygon:setColors(strokeColor)
        graphics2d.meshPolygon:drawMesh2d(
            0, 0, nil,
            1, 1, nil,
            gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
    end
end

function graphics2d.polygon(...)
    local vertices = vertices2vectors(...)

    local minVertex, maxVertex, size = Model.minmax(vertices)
    local w, h = size.x, size.y

    local x, y = 0, 0
    if polylineMode() == CORNER then
        x, y = corner(polylineMode(), x, y, w, h)
    end

    local dw = strokeWidth()
    local dx = dw/2

    local strokeColor = stroke()
    local fillColor = fill()

    -- fill
    if fillColor ~= transparent then
        graphics2d.meshPolygon.vertices = triangulate(vertices)
        graphics2d.meshPolygon.shader = Shader.shaders['default']
        graphics2d.meshPolygon:setColors(fillColor)
        graphics2d.meshPolygon:drawMesh2d()
    end

    -- stroke
    if dw > 0 and strokeColor ~= transparent then
        graphics2d.meshPolygon.vertices = vertices
        graphics2d.meshPolygon.shader = Shader.shaders['lines2d']
        graphics2d.meshPolygon:setColors(strokeColor)
        graphics2d.meshPolygon:drawMesh2d(
            0, 0, nil,
            1, 1, nil,
            gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
    end
end

function graphics2d.sprite(img, x, y, w, h, mode, clr, shader)
    if type(img) == 'string' then
        img = image(img)
    else
        img:update()
    end

    local width = img.width
    local height = img.height

    x = x or 0
    y = y or 0

    h = h or (w and w * height / width) or height
    w = w or width

    graphics2d.meshSprite.texture = img.image or img
    graphics2d.meshSprite.shader = Shader.shaders['default']
    graphics2d.meshSprite:setColors(clr or tint())

    mode = mode or spriteMode()

    if mode == CORNER then
        x, y = corner(mode, x, y, w, h)
    end

    graphics2d.meshSprite:addMesh2d(
        x, y, nil,
        w, h, nil)
end

-- text

function graphics2d.textSize(txt)
    local w, h = 0, 0
    local lines = tostring(txt):split('\n')
    for i,line in ipairs(lines) do
        local lw, lh = getFont():getTextSize(line)
        w = max(w, lw)
        h = h + lh
    end

    return w, h
end

graphics2d.NEXTX = 0
graphics2d.NEXTY = 0

function graphics2d.text(txt, x, y)
    x = x or 0
    y = y or 0
    txt = tostring(txt)

    local image = getFont():getText(txt)

    local width = image.width
    local height = image.height

    graphics2d.NEXTX = x + width
    graphics2d.NEXTY = y - height

    local shader = Shader.shaders['text']

    pushStyle()
    do
        blendMode(NORMAL)
        
        cullingMode('none')
        depthMode(false)

        local mode = textMode()
        if mode == CORNER then
            sprite(image, x, y+height, width, -height, mode, fill(), shader)
        else
            sprite(image, x, y, width, -height, mode, fill(), shader)
        end
    end
    popStyle()

    return width, height
end
