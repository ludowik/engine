function applyMatrixRowsToVec3(v, r1, r2, r3)
-- Let M be a matrix with rows r1, r2, and r3. Return M*v.
    return vec3(v:dot(r1), v:dot(r2), v:dot(r3))
end


function rotationVectors(u, angle)
-- Returns three 3D vectors corresponding to the rows of a matrix
-- implementing a rotation of the given angle around the given axis.
    local m = matrix()
    m = m:rotate(angle, u.x, u.y, u.z)
    return  vec3(m[1], m[2], m[3]),
            vec3(m[5], m[6], m[7]),
            vec3(m[9], m[10], m[11])

--[[
    -- The following is pretty efficient, but using whole-matrix operations as is
    -- done above is faster still. Also, this expanded form requires a unit vector u.
    local c = math.cos(angle)
    local s = math.sin(angle)
    local d = 1-c
    local su = s*u
    local du = d*u
    local r1 = du.x*u + vec3(c, su.z, -su.y)
    local r2 = du.y*u + vec3(-su.z, c, su.x)
    local r3 = du.z*u + vec3(su.y, -su.x, c)
    return r1, r2, r3
]]--
end

function rotateVec3(v, u, angle)
--  Return vector v rotated angle degrees around vector u.
    return applyMatrixRowsToVec3(v, rotationVectors(u, angle))
end

-- MeshTest

function sweepHollowCylinderMesh(basePoint, axis, radius, aN, cN)
-- This function creates a mesh of triangles that form a cylinder (without
-- tops). The mesh' vertices and normals are set, but not its colors.
-- This returns the mesh and its number of vertices.
-- basePoint (vec3): One end of the cylinder's axis
-- axis (vec3): The length and direction of the axis
-- radius (vec3 or number): Either the vector swept around the axis to
--                          describe the cylinder, or just a numerical radius
-- aN, cN: The number of steps in the axial and circular sweeps, respectively.

    -- Create the mesh and pre-size its position and normal buffers.
    local m = Mesh()
    local bufLen = 6*cN*aN
    local posBuf = m:buffer("position")
    posBuf:resize(bufLen)
    local normBuf = m:buffer("normal")
    normBuf:resize(bufLen)
    -- If radius is given as a length, turn it into a vector orthogonal
    -- to the axis.
    if type(radius) == "number" then
        local r = radius
        local ax, ay, az = axis.x, axis.y, axis.z
        -- Beware of catastrophic cancelation
        if az >= math.abs(ax) and az >= math.abs(ay) then
            radius = vec3(az, az, -ax-ay)
        elseif ay >= math.abs(ax) and ay >= math.abs(az) then
            radius = vec3(ay, -ax-az, ay)
        elseif ay >= math.abs(ax) and ay >= math.abs(az) then
            radius = vec3(-ay-az, ax, ax)
        end
        radius = r*radius:normalize()
    end
    -- Compute the incremental rotation vector and the incremental
    -- axial sliding vector for sweeping the mesh.
    local rot1, rot2, rot3 = rotationVectors(axis, 360/cN)
    axis = axis/aN
    -- Sweep the mesh with axial sliding in the inner loop since that
    -- is more efficient than the rotational sweep.
    local i = 1 -- Index into the buffers
    local r1, r2, b1, b2
    r1 = radius
    for c = 1, cN do
        -- Rotate the radius vector, but ensure that the last one is
        -- exactly the one we started with.
        if c == cN then
            r2 = radius
        else
            r2 = applyMatrixRowsToVec3(r1, rot1, rot2, rot3)
        end
        b1 = basePoint
        for a = 1, aN do
            b2 = b1 + axis
            -- Create two triangles:
            local p2 = b1+r2
            local p3 = b2+r1
            posBuf[i] = b1+r1
            posBuf[i+1] = p2
            posBuf[i+2] = p3
            posBuf[i+3] = p2
            posBuf[i+4] = p3
            posBuf[i+5] = b2+r2
            normBuf[i] = r1
            normBuf[i+1] = r2
            normBuf[i+2] = r1
            normBuf[i+3] = r2
            normBuf[i+4] = r1
            normBuf[i+5] = r2
            i = i + 6
            b1 = b2
        end
        r1 = r2
    end
    return m, bufLen
end


function setup()
    basePt = vec3(0, -50, 0)
    axis = vec3(10, 100, 10)
    radius = 50
    hN = 2; cN = 24
    m, nVertices = sweepHollowCylinderMesh(basePt, axis, radius, hN, cN)
    colorBuf = m:buffer("color")
    colorBuf:resize(nVertices)
    for n = 1, nVertices, 6 do
        local c = Color(240+math.random(-15, 15))
        for i = n, n+5 do
            colorBuf[i] = c
        end
    end
    camPos = { angle = 0 }
    tween(12, camPos, { angle = 2*math.pi }, { loop = tween.loop.forever})
end


function draw()
    -- Clear screen to black.
    background(0, 0, 0, 255)
    pushMatrix()
    perspective(45, WIDTH/HEIGHT, 200, -200)
    camera(0, 400*math.cos(camPos.angle), 400*math.sin(camPos.angle),
           0, 0, 0,
           0, math.cos(camPos.angle+math.pi/2), math.sin(camPos.angle+math.pi/2))
    m:draw()
    popMatrix()
end
