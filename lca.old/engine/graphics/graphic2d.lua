-- font and border size
s0 = 0.01
s1 = 1.01
for i = 2, 20 do
    _G['s'..i] = i
end

-- screen size and position
local ntiles = 12

function ws(i, n)
    i = i or 1
    n = n or ntiles
    return WIDTH * i / n
end

function hs(i, n)
    i = i or 1
    n = n or ntiles
    return HEIGHT * i / n
end

function ls(i, n)
    i = i or 1
    n = n or ntiles
    return max(WIDTH, HEIGHT) * i / n
end

function size(m, n)
    local w = m and ls(m) or ls(1)
    local h = n and ls(n) or w
    return vec2(w, h)
end

-- alignments
enum 'AlignmentMode' {
    CENTER = 'center',
    CORNER = 'corner'
}

function center(mode, x, y, w, h)
    if mode == CENTER then
        x = x - w / 2
        y = y - h / 2
    end
    return x, y
end

function corner(mode, x, y, w, h)
    if mode == CORNER then
        x = x + w / 2
        y = y + h / 2
    end
    return x, y
end

-- primitives
local function setColor(clr)
    if clr then
        graphics.setColor(clr:rgba())
        return true
    end
end

local function setWidth(width)
    if width then
        graphics.setLineWidth(width)
        graphics.setPointSize(width)
        return true
    end
end

local backgroundColor = color()
function background(...)
    backgroundColor:init(...)
    local r, g, b, a = backgroundColor:rgba()
    graphics.clear(r, g, b, a,
        true,
        true)
end

local currentShader
local function setShader(shader)
    if shader then
        currentShader = shader
    else
        currentShader = currentShader or shaders['standard']
    end
    currentShader:setUniforms()
end

function point(x, y)
    setShader()

    if setColor(stroke()) and setWidth(strokeWidth()) then
        if type(x) == 'table' then
            x, y = x.x, x.y
        end
        graphics.points(x, y)
    end
end

function points(...)
    setShader()

    if setColor(stroke()) and setWidth(strokeWidth()) then
        graphics.points(...)
    end
end

function line(x1, y1, x2, y2)
    setShader()

    local strokeWidth = strokeWidth()
    if setColor(stroke()) and setWidth(strokeWidth) then

        local lineCapMode = lineCapMode()

        if lineCapMode == SQUARE then
            graphics.line(x1, y1, x2, y2)

        elseif lineCapMode == PROJECT then
            local dx = x2 - x1
            local dy = y2 - y1

            local v1 = vec2(x1, y1) - vec2(dx, dy):normalize() * strokeWidth / 2
            local v2 = vec2(x2, y2) + vec2(dx, dy):normalize() * strokeWidth / 2

            x1, y1 = v1.x, v1.y
            x2, y2 = v2.x, v2.y

            dx = x2 - x1
            dy = y2 - y1

            graphics.line(x1, y1, x2, y2)

        elseif lineCapMode == ROUND then
            local radius = strokeWidth/2

            graphics.line(x1, y1, x2, y2)

            graphics.setLineWidth(1)

            graphics.circle('fill', x1, y1, radius)
            graphics.circle('fill', x2, y2, radius)
        end
    end
end

function rect(x, y, w, h, rx, ry, segments)
    setShader()

    h = h or w
    x, y = center(rectMode(), x, y, w, h)

    if setColor(fill()) then
        graphics.rectangle('fill', x, y, w, h, rx, ry, segments)
    end
    if setColor(stroke()) and setWidth(strokeWidth()) then
        local s = math.floor(strokeWidth() / 2)
        graphics.rectangle('line', x+s, y+s, w-s*2, h-s*2, rx, ry, segments)
    end
end

function ellipse(x, y, w, h)
    pushMatrix()

    h = h or w
    x, y = corner(ellipseMode(), x, y, w, h)

    local rx, ry = w/2, h/2

    setShader()

    if setColor(fill()) then
        graphics.ellipse('fill', x, y, rx, ry)
    end

    if setColor(stroke()) and setWidth(strokeWidth()) then
        graphics.ellipse('line', x, y, rx, ry)
    end

    popMatrix()
end

function circle(x, y, r)
    pushMatrix()

    local d = r*2
    x, y = corner(circleMode(), x, y, d, d)

    setShader()

    if setColor(fill()) then
        graphics.circle('fill', x, y, r)
    end

    if setColor(stroke()) and setWidth(strokeWidth()) then
        graphics.circle('line', x, y, r)
    end

    popMatrix()
end

function arc(x, y, radius, a1, a2)
    pushMatrix()

    local w, h = radius, radius
    x, y = corner(ellipseMode(), x, y, w, h)

    local rx, ry = w/2, h/2

    setShader()

    if setColor(fill()) then
        Graphics.arc('fill', x, y, radius, a1, a2)
    end

    if setColor(stroke()) and setWidth(strokeWidth()) then
        Graphics.arc('line', x, y, radius, a1, a2)
    end

    popMatrix()
end

function polyline(vectors)
    setShader()

    local vertices = vectors2vertices(vectors)

    if setColor(stroke()) and setWidth(strokeWidth()) then
        graphics.line(unpack(vertices))
    end    
end

function polygon(vectors, closedPolygon)
    setShader()

    local vertices = vectors2vertices(vectors)

    if setColor(fill()) then
        graphics.polygon('fill', vertices)
    end
    if setColor(stroke()) and setWidth(strokeWidth()) then
        graphics.polygon('line', vertices)
    end
end

-- shape
do
    local vertices
    CLOSE = true

    function beginShape()
        vertices = {}
    end

    function vertex(x, y)
        vertices[#vertices+1] = x
        vertices[#vertices+1] = y
    end

    function endShape(close)
        if close then
            vertices[#vertices+1] = vertices[1]
            vertices[#vertices+1] = vertices[2]
        end
        polyline(vertices)
    end

    function getShape()
        return vertices
    end
end

function spriteSize(img, x, y, w, h)
    if type(img) == 'string' then
        img = image(img)
    end
    return img.width, img.height
end

function sprite(img, x, y, w, h)
    if type(img) == 'string' then
        img = image(img)
    end

    pushMatrix()

    w = w or img.width
    h = h or img.height
    x, y = center(spriteMode(), x, y, w, h)

    local sx = w / img.width
    local sy = h / img.height

    if setColor(tint()) then
        local blendMode = graphics.getBlendMode()
        graphics.setBlendMode('alpha', 'premultiplied')

        translate(x, y)
        scale(sx, sy)

        setShader(nil, true)

        img:draw(0, 0)

        graphics.setBlendMode(blendMode)
    end

    popMatrix()
end

local textObject
local function createTextObject()
    return graphics.newText(getFont())
end

function textSize(str)
    textObject = resources.get('textObject', getFont(), createTextObject)
    textObject:set(str)

    return textObject:getDimensions()
end

function text(str, x, y)
    str = tostring(str)

    pushMatrix()
    if setColor(fill()) then
        local w, h = textSize(str)
        x, y = center(textMode(), x, y, w, h)

        NEXTX = x + w
        NEXTY = y - h

        translate(x, y+h)
        scale(1, -1)
        setShader(nil, true)

        graphics.draw(textObject)
    end
    popMatrix()
end
