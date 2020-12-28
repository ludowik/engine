--- matrix transform
local needUpdate = true

class('transformation').setup = function ()
    _modelMatrix = matrix()
    _viewMatrix = matrix()
    _projectionMatrix = matrix()

    _pvMatrix = matrix()
    _pvmMatrix = matrix()

    _identity = matrix()
end

function pushMatrix(all)
    push('modelMatrix', modelMatrix())
    if all then
        push('viewMatrix', viewMatrix())
        push('projectionMatrix', projectionMatrix())
    end
end

function popMatrix(all)
    modelMatrix(pop('modelMatrix'))
    if all then
        viewMatrix(pop('viewMatrix'))
        projectionMatrix(pop('projectionMatrix'))
    end

    needUpdate = true
end

function resetMatrix(all)
    modelMatrix(_identity)
    if all then
        viewMatrix(_identity)
        ortho()
    end

    needUpdate = true
end

function translate(x, y, z)
    modelMatrix(modelMatrix()
        :translate(x, y, z))
end

function scale(x, y, z)
    modelMatrix(modelMatrix()
        :scale(x, y, z))
end

function rotate(angle, x, y, z)
    modelMatrix(modelMatrix()
        :rotate(angle, x, y, z))
end

function applyMatrix(m)
    modelMatrix(modelMatrix() * m)
end

function modelMatrix(m)
    if m then
        _modelMatrix = m
        needUpdate = true
    end
    return _modelMatrix
end

function viewMatrix(m)
    if m then
        if meshManager then meshManager:flush() end
        _viewMatrix = m
        needUpdate = true
    end
    return _viewMatrix
end

function projectionMatrix(m)
    if m then
        if meshManager then meshManager:flush() end
        _projectionMatrix = m
        needUpdate = true
    end
    return _projectionMatrix
end

function pvMatrix()
    if needUpdate then
        _pvMatrix = _projectionMatrix * _viewMatrix
        needUpdate = false
    end
    return _pvMatrix
end

function pvmMatrix()
    if needUpdate then
        _pvmMatrix = _projectionMatrix * _viewMatrix * _modelMatrix
        needUpdate = false
    end
    return _pvmMatrix
end

function ortho(left, right, bottom, top, near, far)
    local w, h = currentDef(WIDTH, HEIGHT)
    
    local l = left or 0
    local r = right or w

    local b = bottom or 0
    local t = top or h

    local n = near or -1000
    local f = far or 1000

    local m = matrix()
    m:set(
        2/(r-l), 0, 0, -(r+l)/(r-l),
        0, 2/(t-b), 0, -(t+b)/(t-b),
        0, 0, -2/(f-n), -(f+n)/(f-n),
        0, 0, 0, 1)

    projectionMatrix(m)
end

function isometric(n)
    ortho()

    translate(WIDTH/2, HEIGHT/2)

    local alpha = deg(atan(1/sqrt(2)))
    local beta = 45

    rotate(alpha, 1, 0, 0)
    rotate(beta, 0, 1, 0)

    if n then
        scale(n, n, n)
    end
end

function ortho3d(w, h)
    w = w or WIDTH
    h = h or HEIGHT
    
    perspective()
    camera(w/2, h/2, w, w/2, h/2, 0)
end

function perspective(fovy, aspect, near, far)
    local camera = engine.camera
    
    fovy = fovy or (engine.camera and engine.camera.fovy) or config.fov or 45

    aspect = aspect or (WIDTH / HEIGHT)

    near = near or 0.1
    far = far or 100000

    local range = math.tan(math.rad(fovy*0.5)) * near

    local left = -range * aspect
    local right = range * aspect

    local bottom = -range
    local top = range

    local m = matrix()

    m:set(
        (2 * near) / (right - left), 0, 0, 0,
        0, (2 * near) / (top - bottom), 0, 0,
        0, 0, - (far + near) / (far - near), - (2 * far * near) / (far - near),
        0, 0, - 1, 0)

    projectionMatrix(m)
    
    camera:setViewMatrix()
end

function camera(eyeX, eyeY, eyeZ, atX, atY, atZ, upX, upY, upZ)
    if eyeX then
        if upX == nil then
            upX = 0
            upY = 1
            upZ = 0
        end

        engine.camera = engine.camera or Camera()
        engine.camera:set(eyeX, eyeY, eyeZ, atX, atY, atZ, upX, upY, upZ)

        engine.camera:setViewMatrix()
    end
    return engine.camera
end
