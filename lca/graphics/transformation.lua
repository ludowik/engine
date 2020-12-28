--- matrix transform
local needUpdatePV  = true
local needUpdatePVM = true

class('transformation').setup = function ()
    _modelMatrix = matrix()
    _viewMatrix = matrix()
    _projectionMatrix = matrix()

    _pvMatrix = matrix()
    _pvmMatrix = matrix()

    _identity = matrix()
    
    _orthoMatrix = matrix()

    mmHeap = newHeap('modelMatrix')
    vmHeap = newHeap('viewMatrix')
    pmHeap = newHeap('projectionMatrix')
end

function pushMatrix(all)
    mmHeap:push(_modelMatrix)
    if all then
        vmHeap:push(_viewMatrix)
        pmHeap:push(_projectionMatrix)
    end
end

function popMatrix(all)
    modelMatrix(mmHeap:pop())
    if all then
        viewMatrix(vmHeap:pop())
        projectionMatrix(pmHeap:pop())

        needUpdatePV = true
    end

    needUpdatePVM = true
end

function resetMatrix(all)
    modelMatrix(_identity)
    if all then
        viewMatrix(_identity)
        ortho()

        needUpdatePV = true
    end

    needUpdatePVM = true
end

function translate(x, y, z)
    modelMatrix(_modelMatrix
        :translate(x, y, z))
end

function scale(x, y, z)
    modelMatrix(_modelMatrix
        :scale(x, y, z))
end

function rotate(angle, x, y, z)
    modelMatrix(_modelMatrix
        :rotate(angle, x, y, z))
end

function applyMatrix(m)
    modelMatrix(_modelMatrix * m)
end

function modelMatrix(m)
    if m then
        _modelMatrix = m
        needUpdatePVM = true
    end
    return _modelMatrix
end

function viewMatrix(m)
    if m then
        if meshManager then meshManager:flush() end
        _viewMatrix = m
        needUpdatePV = true
    end
    return _viewMatrix
end

function projectionMatrix(m)
    if m then
        if meshManager then meshManager:flush() end
        _projectionMatrix = m
        needUpdatePV = true
    end
    return _projectionMatrix
end

function pvMatrix()
    if needUpdatePV then
        -- TODO : tofix
--        _pvMatrix = _projectionMatrix * _viewMatrix
        _projectionMatrix:mul(_viewMatrix, _pvMatrix)
        needUpdatePV = false
    end
    return _pvMatrix
end

function pvmMatrix()
    if needUpdatePVM then
--        _pvmMatrix = pvMatrix() * _modelMatrix
        pvMatrix():mul(_modelMatrix, _pvmMatrix)
        needUpdatePVM = false
    end
    return _pvmMatrix
end

function ortho(left, right, bottom, top, near, far)
    local l = left or 0
    local r = right or WIDTH

    local b = bottom or 0
    local t = top or HEIGHT

    local n = near or -1000
    local f = far or 1000

    local m = _orthoMatrix
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

    camera(w/2, h/2, w, w/2, h/2, 0)

    perspective()
end

function perspective(fovy, aspect, near, far)
    local camera = lca.camera

    fovy = fovy or (lca.camera and lca.camera.fovy) or config.fov or 45

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

    if camera then
        camera:setViewMatrix()
    end
end

function camera(eyeX, eyeY, eyeZ, atX, atY, atZ, upX, upY, upZ)
    if eyeX then
        if upX == nil then
            upX = 0
            upY = 1
            upZ = 0
        end

        lca.camera = lca.camera or Camera()
        lca.camera:set(eyeX, eyeY, eyeZ, atX, atY, atZ, upX, upY, upZ)

        lca.camera:setViewMatrix()
    end
    return lca.camera
end
