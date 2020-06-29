function resetMatrix()
    __projectionMatrix = matrix()
    __viewMatrix = matrix()

    __pvMatrix = matrix()

    __modelMatrix = matrix()

    ortho()
end

function pushMatrix()
    push('__projectionMatrix', __projectionMatrix)
    push('__viewMatrix', __viewMatrix)
    push('__pvMatrix', __pvMatrix)
    push('__modelMatrix', __modelMatrix)
end

function popMatrix()
    __projectionMatrix = pop('__projectionMatrix')
    __viewMatrix = pop('__viewMatrix')
    __pvMatrix = pop('__pvMatrix')
    __modelMatrix = pop('__modelMatrix')
end

function pvMatrix()
    return __pvMatrix
end

function projectionMatrix(m)
    if m then
        __projectionMatrix = m

        __pvMatrix = __projectionMatrix * __viewMatrix
    end
    return __projectionMatrix
end

function viewMatrix(m)
    if m then
        __viewMatrix = m

        __pvMatrix = __projectionMatrix * __viewMatrix
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
    __modelMatrix = __modelMatrix:translate(x, y, z)
end

function scale(sx, sy, sz)
    __modelMatrix = __modelMatrix:scale(sx, sy, sz)
end

function rotate(angle, x, y, z)
    __modelMatrix = __modelMatrix:rotate(angle, x, y, z)
end

function ortho(left, right, bottom, top, near, far)
    local l = left or 0
    local r = right or W

    local b = bottom or 0
    local t = top or H

    local n = near or -1000
    local f = far or 1000

    projectionMatrix(matrix(
            2/(r-l), 0, 0, -(r+l)/(r-l),
            0, 2/(t-b), 0, -(t+b)/(t-b),
            0, 0, -2/(f-n), -(f+n)/(f-n),
            0, 0, 0, 1))
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

    projectionMatrix(matrix(
            (2 * near) / (right - left), 0, 0, 0,
            0, (2 * near) / (top - bottom), 0, 0,
            0, 0, - (far + near) / (far - near), - (2 * far * near) / (far - near),
            0, 0, - 1, 0))
end

function camera(eye_x, eye_y, eye_z, at_x, at_y, at_z, up_x, up_y, up_z)
    if type(eye_x) == 'number' then
        cameraImplem(vec3(eye_x, eye_y, eye_z), vec3(at_x, at_y, at_z), vec3(up_x, up_y, up_z))
    else
        cameraImplem(eye_x, eye_y, eye_z)
    end
end

function cameraImplem(eye, at, up)
    at = at or vec3()
    up = up or vec3(0, 1, 0)

    local f, u, s = vec3(), vec3(), vec3()

    f:set(at):sub(eye):normalizeInPlace()
    u:set(up):normalizeInPlace()
    s:set(f):crossInPlace(u):normalizeInPlace()

    u:set(s):crossInPlace(f)

    viewMatrix(matrix(
            s.x, s.y, s.z, -s:dot(eye),
            u.x, u.y, u.z, -u:dot(eye),
            -f.x, -f.y, -f.z, f:dot(eye),
            0, 0, 0, 1))
end
