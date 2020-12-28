class('graphics2d', graphics)

function graphics2d.setup()
    graphics2d:push2Global()
end

-- primitives
function graphics2d.point(x, y)
    return points(x, y)
end

function graphics2d.line(x1, y1, x2, y2)
    local m = Mesh.lineMesh
    if m == nil then
        Mesh.lineMesh = Mesh()
        m = Mesh.lineMesh

        m.vertices = {
            0, 0, 0,
            0, 0, 0,
            1, 1, 1,
            1, 1, 1}

        m.translations = {
            1,  1,
            -1, -1,
            1,  1,
            -1, -1}

        m.drawMode = gl.GL_TRIANGLE_STRIP
        m.shader = Shader.shaders['line']

        m.shader.uniforms.p1 = vec2()
        m.shader.uniforms.p2 = vec2()
    end

    local uniforms = m.shader.uniforms

    uniforms.p1:set(x1, y1)
    uniforms.p2:set(x2, y2)

    uniforms.strokeWidth = strokeWidth()
    uniforms.strokeColor = stroke()

    m:render()

    -- TODO prendre en compte le mode
    if lineCapMode == SQUARE then
    elseif lineCapMode == PROJECT then
    elseif lineCapMode == ROUND then
    end
end

function graphics2d.rect(x, y, w, h, mode)
    h = h or w
    mode = mode or rectMode()    

    local m = Mesh.rectMesh
    if m == nil then
        Mesh.rectMesh = Mesh()
        m = Mesh.rectMesh

        m.vertices = {
            0, 0, 0,
            1, 0, 0,
            1, 1, 0,
            0, 0, 0,
            1, 1, 0,
            0, 1, 0}

        m.texCoords = {
            0, 0,
            1, 0,
            1, 1,
            0, 0,
            1, 1,
            0, 1}

        m.drawMode = gl.GL_TRIANGLES
        m.shader = Shader.shaders['rect']
        m.shader.uniforms.pos = vec2()
        m.shader.uniforms.size = vec2()
    end

    m.shader.uniforms.pos:set(x, y)
    m.shader.uniforms.size:set(w, h)

    m.shader.uniforms.strokeWidth = strokeWidth()
    m.shader.uniforms.strokeColor = stroke()

    m.shader.uniforms.fillColor = fill()

    m.shader.uniforms.mode = mode == CORNER and 1 or 0

    m:render()
end

function graphics2d.arc(x, y, radius, a1, a2)
    -- TODO : tester l'utilisation de Geometry.arc
end

function graphics2d.circle(x, y, r, mode)
    ellipse(x, y, r*2, r*2, mode or circleMode())
end

function graphics2d.ellipse(x, y, w, h, mode)
    h = h or w
    mode = mode or ellipseMode()

    local m = Mesh.circleMesh
    if m == nil then
        Mesh.circleMesh = Mesh()
        m = Mesh.circleMesh

        m.vertices = {
            0, 0, 0,
            1, 0, 0,
            1, 1, 0,
            0, 0, 0,
            1, 1, 0,
            0, 1, 0}

        m.texCoords = {
            0,0,
            1,0,
            1,1,
            0,0,
            1,1,
            0,1}

        m.drawMode = gl.GL_TRIANGLES

        m.shader = Shader.shaders['circle']
        m.shader.uniforms.pos = vec2()
        m.shader.uniforms.size = vec2()
    end

    m.shader.uniforms.pos:set(x, y)
    m.shader.uniforms.size:set(w, h)

    if stroke().a == 0 then
        m.shader.uniforms.strokeWidth = 0
    else
        m.shader.uniforms.strokeWidth = strokeWidth()
    end

    m.shader.uniforms.strokeColor = stroke()
    m.shader.uniforms.fillColor = fill()

    m.shader.uniforms.mode = mode == CORNER and 1 or 0

    m:render()
end

function graphics2d.lines(...)
    -- TODO : dessiner des lignes avec l'épaisseur demandé
    local m = Mesh.linesMesh
    if m == nil then
        Mesh.linesMesh = Mesh()
        m = Mesh.linesMesh

        m.drawMode = gl.GL_LINES
        m.shader = Shader.shaders['basic']
    end

    drawVertices(m, false, ...)
end

function graphics2d.polyline(...)
    graphics2d.polylineProc(false, ...)
end

function graphics2d.polylineProc(close, ...)
    -- TODO : dessiner des polyline avec l'épaisseur demandé
    local m = Mesh.polylineMesh
    if m == nil then
        Mesh.polylineMesh = Mesh()
        m = Mesh.polylineMesh

        m.drawMode = gl.GL_LINE_STRIP
        m.shader = Shader.shaders['basic']
    end

    drawVertices(m, close, ...)
end

function graphics2d.drawVertices(m, close, ...)
    local points = {...}
    if type(points[1]) == 'table' then
        points = points[1]
        m.vertices = Array()
        for i=1,#points do
            m.vertices:add(points[i])
        end
        if close then
            m.vertices:add(points[1])
        end

    else
        assert()
        m.vertices = Array()
        for i=1,#points,2 do
            m.vertices:add(points[i])
            m.vertices:add(points[i+1])
            m.vertices:add(0)
        end
    end

    m.shader.uniforms.strokeWidth = strokeWidth()
    m.shader.uniforms.strokeColor = stroke()

    m:render()
end

function graphics2d.polygon(...)
    local m = Mesh.polygonMesh
    if m == nil then
        Mesh.polygonMesh = Mesh()
        m = Mesh.polygonMesh

        m.drawMode = gl.GL_TRIANGLE_STRIP
        m.shader = Shader.shaders['default']
    end

    local points = {...}
    if #points == 1 and  type(points[1]) == 'table' then
        points = points[1]
    end

    m.vertices = points

    m.shader.uniforms.strokeWidth = strokeWidth()
    m.shader.uniforms.strokeColor = stroke()

    m.shader.uniforms.fillColor = fill()

    m:render()

    if m.shader.uniforms.strokeWidth > 0 and m.shader.uniforms.strokeColor.a > 0 then
        graphics2d.polylineProc(true, ...)
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

    mode = mode or spriteMode()

    local m = Mesh.spriteMesh
    if m == nil then
        Mesh.spriteMesh = Mesh()
        m = Mesh.spriteMesh

        m.vertices = {
            0, 0, 0,
            1, 0, 0,
            1, 1, 0,
            0, 0, 0,
            1, 1, 0,
            0, 1, 0}

        m.texCoords = {
            0, 0,
            1, 0,
            1, 1,
            0, 0,
            1, 1,
            0, 1}

        m.drawMode = gl.GL_TRIANGLES
        m.shaderRef = Shader.shaders['sprite']
        m.shaderRef.uniforms.pos = vec2()
        m.shaderRef.uniforms.size = vec2()
    end

    assert(shader == nil or shader.name == 'text')
    m.shader = shader or m.shaderRef

    m.shader.uniforms.pos:set(x, y)
    m.shader.uniforms.size:set(w, h)

    m.texture = img

    m.shader.uniforms.mode = mode == CORNER and 1 or 0

    m.shader.uniforms.tintColor = clr or tint()

    m:render()
end

function graphics2d.textSize(txt)
    if txt == nil then return 0, 0 end

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
    if txt == nil then return end

    x = x or 0
    y = y or 0

    local w, h = graphics2d.textSize(txt, x, y)

    local mode = textMode()
    if mode == CORNER then
        y = y + h
    else
        x = x - w / 2
        y = y + h / 2
    end

    local lines = tostring(txt):split('\n')

    for i,line in ipairs(lines) do
        local image, lw, lh = getFont():getText(line)
        graphics2d.textRender(image, x, y, lw, lh)
        w = max(w, lw)
        h = h + lh
    end

    graphics2d.NEXTX = x + w
    graphics2d.NEXTY = y - h

    return w, h
end

function graphics2d.textRender(image, x, y, w, h)
    local shader = Shader.shaders['text']
    shader.uniforms.pos = vec2()
    shader.uniforms.size = vec2()

    pushStyle()
    do
        blendMode(NORMAL)

        depthMode(false)
        cullingMode('none')

        sprite(image, x, y, w, -h, CORNER, fill(), shader)
    end
    popStyle()
end
