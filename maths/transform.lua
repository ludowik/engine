__identityMatrix = matrix()

__pvMatrix1 = matrix()
__pvMatrix2 = matrix()
__pvMatrix = __pvMatrix1

__projectionMatrix = matrix()
__viewMatrix = matrix()

__modelMatrix1 = matrix()
__modelMatrix2 = matrix()
__modelMatrix = __modelMatrix1

function resetMatrix()
    if love then
        transform = love.math.newTransform()
    else
        __pvMatrix.values = __identityMatrix.values

        __projectionMatrix.values = __identityMatrix.values
        __viewMatrix.values = __identityMatrix.values

        __modelMatrix.values = __identityMatrix.values

        ortho()
    end
end

function pvMatrix()
    return __pvMatrix
end

function projectionMatrix(m)
    if m then
        __projectionMatrix = m

        __projectionMatrix:__mul(__viewMatrix, __pvMatrix2)
        __pvMatrix1, __pvMatrix2 = __pvMatrix2, __pvMatrix1
        __pvMatrix = __pvMatrix1
    end
    return __projectionMatrix
end

function viewMatrix(m)
    if m then
        __viewMatrix = m

        __projectionMatrix:__mul(__viewMatrix, __pvMatrix2)
        __pvMatrix1, __pvMatrix2 = __pvMatrix2, __pvMatrix1
        __pvMatrix = __pvMatrix1
    end
    return __viewMatrix
end

function modelMatrix(m)
    if m then
        __modelMatrix = m
    end
    return __modelMatrix
end

function translate(x, y, z)
    __modelMatrix:translate(x, y, z, __modelMatrix2)
    __modelMatrix1, __modelMatrix2 = __modelMatrix2, __modelMatrix1
    __modelMatrix = __modelMatrix1
end

function scale(sx, sy, sz)
    __modelMatrix:scale(sx, sy, sz, __modelMatrix2)
    __modelMatrix1, __modelMatrix2 = __modelMatrix2, __modelMatrix1
    __modelMatrix = __modelMatrix1
end

function rotate(angle, x, y, z)
    __modelMatrix:rotate(angle, x, y, z, __modelMatrix2)
    __modelMatrix1, __modelMatrix2 = __modelMatrix2, __modelMatrix1
    __modelMatrix = __modelMatrix1
end

function ortho(left, right, bottom, top, near, far)
    local l = left or 0
    local r = right or W

    local b = bottom or 0
    local t = top or H

    local n = near or -1000
    local f = far or 1000

--    local m = matrix(
    __projectionMatrix:set(
        2/(r-l), 0, 0, -(r+l)/(r-l),
        0, 2/(t-b), 0, -(t+b)/(t-b),
        0, 0, -2/(f-n), -(f+n)/(f-n),
        0, 0, 0, 1)

    projectionMatrix(__projectionMatrix)
end

function perspective(fovy, aspect, near, far)
    fovy = fovy or 45

    aspect = aspect or (W / H)

    near = near or 0.1
    far = far or 100000

    local range = math.tan(math.rad(fovy*0.5)) * near

    local left = -range * aspect
    local right = range * aspect

    local bottom = -range
    local top = range

--    local m = matrix(
    __projectionMatrix:set(
        (2 * near) / (right - left), 0, 0, 0,
        0, (2 * near) / (top - bottom), 0, 0,
        0, 0, - (far + near) / (far - near), - (2 * far * near) / (far - near),
        0, 0, - 1, 0)

    projectionMatrix(__projectionMatrix)
end

function camera(eye, at, up)
    at = at or vec3()
    up = up or vec3(0, 1, 0)

    local f, u, s = vec3(), vec3(), vec3()

    f:set(at):sub(eye):normalizeInPlace()
    u:set(up):normalizeInPlace()
    s:set(f):crossInPlace(u):normalizeInPlace()

    u:set(s):crossInPlace(f)

--    local m = matrix(
    __viewMatrix:set(
        s.x,  s.y,  s.z, -s:dot(eye),
        u.x,  u.y,  u.z, -u:dot(eye),
        -f.x, -f.y, -f.z,  f:dot(eye),
        0, 0, 0, 1)

    viewMatrix(__viewMatrix)
end
