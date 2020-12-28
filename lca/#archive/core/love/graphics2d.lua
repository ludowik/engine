class('graphics2d', graphics)

function graphics2d.setup()
    graphics2d.cache = {}

    graphics2d.defaultformat = {
        {"VertexPosition", "float", 3}, -- The x,y,z position of each vertex
        {"VertexTexCoord", "float", 2}, -- The u,v texture coordinates of each vertex
        {"VertexColor", "byte", 4}, -- The r,g,b,a color of each vertex
        {"VertexNormal", "float", 3}, -- The x,y,z normal of each vertex
        {"VertexTranslation", "float", 3} -- The x,y,z translation of each vertex
    }

    love.graphics.setLineStyle('rough')

    graphics2d:push2Global()
end

function graphics2d.setShader(shader)
    if shader then
        local uniforms = {}

        uniforms.pvMatrix = pvMatrix()
        uniforms.modelMatrix = modelMatrix()

        uniforms.strokeWidth = graphics.style.strokeWidth
        uniforms.strokeColor = graphics.style.strokeColor

        uniforms.fillColor = graphics.style.fillColor

        if light() and #lights > 0 then
            uniforms.useLight = true

            shader:pushToShader(currentMaterial, 'material')
            shader:pushTableToShader(lights, 'lights', 'useLight')
        else
            uniforms.useLight = false
        end

        shader:pushToShader(uniforms)    

        love.graphics.setShader(shader.shader)
    else
        love.graphics.setShader()
    end
end

function graphics2d.point(...)
    graphics2d.points(...)
end

function graphics2d.points(...)
    local points = {...}
    for i=1,#points,2 do
        graphics2d.circle(points[i], points[i+1], graphics.style.strokeWidth)
    end
end

function graphics2d.line(x1, y1, x2, y2)
    graphics2d.cache.meshLine = graphics2d.cache.meshLine or love.graphics.newMesh(graphics2d.defaultformat,
        {
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  1,  1, 0},
            {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  1,  1, 0},
            {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  1,  1, 0},
            {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1, 0}
        },
        'triangles',
        'stream')

    local shader = Shader.shaders['line']
    graphics2d.setShader(shader)
    do
        shader:send('p1', {x1, y1})
        shader:send('p2', {x2, y2})

        --        shader:send('strokeWidth', graphics.style.strokeWidth)
        --        shader:send('strokeColor', {graphics.style.strokeColor:unpack()})

        --        shader:send('fillColor', {graphics.style.fillColor:unpack()})

        love.graphics.draw(graphics2d.cache.meshLine)
    end
    graphics2d.setShader()
end

function graphics2d.lines(...)
    local points = {...}
    if type(points[1]) == 'table' then
        points = points[1]
    end

    if type(points[1]) == 'table' then
        for i=1,#points,2 do
            line(
                points[i].x, points[i].y,
                points[i+1].x, points[i+1].y)
        end
    else
        for i=1,#points,4 do
            line(
                points[i  ], points[i+1],
                points[i+2], points[i+3])
        end
    end
end

function graphics2d.polyline(...)
    local points = {...}
    if type(points[1]) == 'table' then
        points = points[1]
    end

    if type(points[1]) == 'table' then
        for i=1,#points-1 do
            line(
                points[i].x, points[i].y,
                points[i+1].x, points[i+1].y)
        end
    else
        for i=1,#points-2,2 do
            line(
                points[i  ], points[i+1],
                points[i+2], points[i+3])
        end
    end
end

function graphics2d.polygon(vertices)
    graphics2d.polyline(vertices)
end

function graphics2d.quad(x, y, w, h, img, mode)
    graphics2d.cache.meshRect = graphics2d.cache.meshRect or love.graphics.newMesh(graphics2d.defaultformat,
        {
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        },
        'triangles',
        'stream')

    if img then
        graphics2d.cache.meshRect:setTexture(img.image)
    else
        graphics2d.cache.meshRect:setTexture()
    end

    local shader = Shader.shaders['rect']
    graphics2d.setShader(shader)
    do
        x, y = center(mode, x, y, w, h)

        shader:send('pos', {x, y})        
        shader:send('size', {w, h})

        --        shader:send('strokeWidth', graphics.style.strokeWidth)
        --        shader:send('strokeColor', {graphics.style.strokeColor:unpack()})

        if img then
            shader:send('fillColor', {white:unpack()})
        end

        love.graphics.draw(graphics2d.cache.meshRect)
    end
    graphics2d.setShader()
end

function graphics2d.rect(x, y, w, h)
    graphics2d.quad(x, y, w, h, nil, graphics.style.rectMode)
end

function graphics2d.circle(x, y, r)
    graphics2d.ellipse(x, y, r*2, r*2, graphics.style.circleMode)
end

function graphics2d.ellipse(x, y, w, h, mode)
    w = w or 1
    h = h or w

    graphics2d.cache.meshCircle = graphics2d.cache.meshCircle or love.graphics.newMesh(graphics2d.defaultformat,
        {
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        },
        'triangles',
        'stream')

    local shader = Shader.shaders['circle']
    graphics2d.setShader(shader)
    do
        x, y = corner(mode or graphics.style.ellipseMode, x, y, w, h)

        shader:send('pos', {x-w/2, y-h/2})
        shader:send('size', {w, h})

        --        shader:send('strokeWidth', graphics.style.strokeWidth)
        --        shader:send('strokeColor', {graphics.style.strokeColor:unpack()})

        --        shader:send('fillColor', {graphics.style.fillColor:unpack()})

        love.graphics.draw(graphics2d.cache.meshCircle)
    end
    graphics2d.setShader()
end

function graphics2d.arc(x, y, radius, a1, a2)
    pushMatrix()

    local w, h = radius, radius
    x, y = corner(ellipseMode(), x, y, w, h)

    local rx, ry = w/2, h/2

    local shader = Shader.shaders['default']
    graphics2d.setShader(shader)

    if fill() then
        love.graphics.arc('fill', x, y, radius, a1, a2)
    end

    if stroke() and strokeWidth() then
        love.graphics.arc('line', x, y, radius, a1, a2)
    end

    popMatrix()
end

function graphics2d.sprite(img, x, y, w, h)
    if type(img) == 'string' then
        img = image.getImage(img)
    else
        img:update()
    end

    w = w or img.width
    h = h or img.height

    graphics2d.quad(x, y, w, h, img, graphics.style.spriteMode)
end

local textObject
local function createTextObject()
    return love.graphics.newText(getFont())
end

local function releaseTextObject(textObject)
    textObject:release()
end

function graphics2d.textSize(str)
    textObject = resources.get('font.text',
        getFont(),
        createTextObject,
        releaseTextObject,
        true)

    textObject:set(str)
    return textObject:getDimensions()
end

graphics2d.NEXTX = 0
graphics2d.NEXTY = 0

function graphics2d.text(str, x, y)
    str = tostring(str)
    
    local w, h = textSize(str)

    pushMatrix()
    if fill().a > 0 then
        x, y = center(textMode(), x, y, w, h)

        graphics2d.NEXTX = x + w
        graphics2d.NEXTY = y - h

        translate(x, y+h)
        scale(1, -1)

        local shader = Shader.shaders['default']
        graphics2d.setShader(shader)

        love.graphics.draw(textObject)
    end
    popMatrix()

    return w, h
end
