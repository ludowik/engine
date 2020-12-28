graphics = graphic or {}

function graphics.background(...)
    local clr = color(...)

    gl.glClearColor(clr.r/255, clr.g/255, clr.b/255, clr.a/255)

    gl.glClearDepth(1)
    gl.glClear(gl.GL_COLOR_BUFFER_BIT + gl.GL_DEPTH_BUFFER_BIT)
end

-- primitives
function graphics.point(x, y)
    local w = strokeWidth()
    x, y = center(CENTER, x, y, w, w)

    graphics.rect(x, y, w, w)    
end

function graphics.line(...)
    local meshLine = Model.line()    
    graphics.line = function (x1, y1, x2, y2)
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
            meshLine.shader = shaders['lines2d']
            meshLine:setColors(strokeColor)
            meshLine:addMesh2d(
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
    graphics.line(...)    
end

function graphics.rect(x, y, w, h)
    local meshRect, meshEdges = Model.rect()
    graphics.rect = function (x, y, w, h)
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
            meshRect:setColors(fillColor)
            meshRect:addMesh2d(
                x, y, nil,
                w-dw, h-dw, nil)
        end

        -- stroke
        if dw > 0 and strokeColor ~= transparent then
            meshEdges.shader = shaders['lines2d']
            meshEdges:setColors(strokeColor)
            meshEdges:addMesh2d(
                x, y, nil,
                w-dx, h-dx, nil,
                gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
        end 
    end
    graphics.rect(x, y, w, h)
end

function graphics.ellipse(x, y, w, h)
    local meshEllipse, meshEdges = Model.ellipse()
    graphics.ellipse = function (x, y, w, h)
        h = h or w

        local mode = ellipseMode()
        if mode == CORNER then
            x, y = corner(mode, x, y, w, h)
        end

        local dw = strokeWidth()
        local dx = dw/2

        local strokeColor = stroke()
        local fillColor = fill()

        -- fill
        if fillColor ~= transparent then
            meshEllipse:setColors(fillColor)
            meshEllipse:addMesh2d(
                x, y, nil,
                w-dx, h-dx, nil)
        end

        -- stroke
        if dw > 0 and strokeColor ~= transparent then
            meshEdges.shader = shaders['lines2d']
            meshEdges:setColors(strokeColor)
            meshEdges:addMesh2d(
                x, y, nil,
                w-dx, h-dx, nil,
                gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
        end        
    end
    graphics.ellipse(x, y, w, h)
end

function graphics.polygon(...)
    local function vectorsFromArgs(...)
        return ...
    end

    local polygonMesh = Mesh()
    graphics.polygon = function (...)
        local vertices = vectorsFromArgs(...)

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
            polygonMesh.vertices = triangulate(vertices)
            polygonMesh.shader = shaders['standard']
            polygonMesh:setColors(fillColor)
            polygonMesh:drawMesh2d()
        end

        -- stroke
        if dw > 0 and strokeColor ~= transparent then
            polygonMesh.vertices = vertices
            polygonMesh.shader = shaders['lines2d']
            polygonMesh:setColors(strokeColor)
            polygonMesh:drawMesh2d(
                0, 0, nil,
                1, 1, nil,
                gl.GL_LINE_STRIP_ADJACENCY, gl.GL_FILL)
        end
    end
    graphics.polygon(...)
end

function graphics.sprite(img, x, y, w, h)
    local meshSprite = Model.rect()
    graphics.sprite = function (img, x, y, w, h)
        x = x or 0
        y = y or 0
        
        if type(img) == 'string' then
            img = image(img)
        end

        meshSprite.texture = img.image or img

        w = w or meshSprite.texture:getWidth()
        h = h or meshSprite.texture:getHeight()

        if spriteMode() == CORNER then
            x, y = corner(spriteMode(), x, y, w, h)
        end

        meshSprite:addMesh2d(
            x, y, nil,
            w, h, nil)
    end
    graphics.sprite(img, x, y, w, h)
end

-- text

local function textSizeProc(str)
    return MeshText.textSize(str)
end

function graphics.textSize(str)
    return textSizeProc(tostring(str))
end

function graphics.text(...)
    local mesh = MeshText()
    graphics.text = function(str, x, y)
        local font = getFont()
        assert(font)

        str = tostring(str)

        local w, h = textSizeProc(str)
        if textMode() == CORNER then
            x, y = corner(textMode(), x, y, w, h)
        end

        local clr = fill()
        if clr ~= transparent then
            mesh.txt = str

            mesh.x = x
            mesh.y = y

            mesh:drawMesh2d()
        end
        
        return w, h
    end
    return graphics.text(...)
end
