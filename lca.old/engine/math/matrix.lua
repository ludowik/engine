-- matrix

lua_matrix = class('matrix', table)
matrix = lua_matrix

function lua_matrix:init(...)
    local args = {...}
    if #args == 2 then
        self:create(args[1], args[2])
    elseif #args == 0 or #args == 16 then
        self:create(4, 4)
    elseif #args == 4 then
        self:create(4, 1)
    else
        assert()
    end

    if #args >= 4 then
        self:set(...)
    elseif #args == 0 then -- identity
        local val = args[1] or 1
        self[ 1] = val
        self[ 6] = val
        self[11] = val
        self[16] = val
    end
    return self
end

function lua_matrix:clone()
    local m = lua_matrix()

    local n = self.m * self.n
    for i=1,n do
        m[i] = self[i]
    end
    return m
end

function lua_matrix:ref(l, c)
    return (l - 1) * self.n + c
end

function lua_matrix:create(m, n)
    self.m = m
    self.n = n

    self[16] = 0

    for i=1,15 do
        self[i] = 0
    end
end

function lua_matrix:set(...)
    local args = {...}

    local default = args[1] or 0

    local n = self.m * self.n
    for i=1,n do
        self[i] = args[i] or default
    end
end

function lua_matrix:scale(x, y, z)
    x = x or 1
    y = y or x
    z = z or x

    scaleMatrix = scaleMatrix or matrix()
    scaleMatrix:set(
        x,0,0,0,
        0,y,0,0,
        0,0,z,0,
        0,0,0,1)

    return self * scaleMatrix
end

function lua_matrix:translate(x, y, z)    
    translateMatrix = translateMatrix or lua_matrix()

    translateMatrix[ 4] = x or 0
    translateMatrix[ 8] = y or 0
    translateMatrix[12] = z or 0

    return self * translateMatrix
end

function lua_matrix:transpose()
    local m = lua_matrix()
    for x=0,3 do
        for y=0,3 do
            m[1+y*4+x] = self[1+x*4+y]
        end
    end

    return m
end

local cos = math.cos
local sin = math.sin

function lua_matrix:rotate(angle, x, y, z)
    local c = cos(rad(angle))
    local s = sin(rad(angle))

    rotateMatrix = rotateMatrix or matrix()
    if x == 1 then
        rotateMatrix:set(
            1,0,0,0,
            0,c,-s,0,
            0,s,c,0,
            0,0,0,1)
    elseif y == 1 then
        rotateMatrix:set(
            c,0,s,0,
            0,1,0,0,
            -s,0,c,0,
            0,0,0,1)
    else -- y == 1 (default)
        rotateMatrix:set(
            c,-s,0,0,
            s,c,0,0,
            0,0,1,0,
            0,0,0,1)
    end

    return self * rotateMatrix
end

function lua_matrix:__mul(b)
    local m = self.m
    local n = self.n -- b.m

    local returnVector = false
    if typeOf(b):inList('vector') or b.n == nil then
        returnVector = true
        b = lua_matrix(b.x, b.y, b.z or 0, 1)

    end

    local p = b.n
    
    local r = lua_matrix(m, p)    
    local a = self

    local val

    local ii = 1

    for l=1,m do
        for c=1,p do
            val = 0
            for i=1,n do
                val = val + a[a:ref(l,i)] * b[b:ref(i,c)]
            end

            r[ii] = val

            ii = ii + 1
        end
    end

    if returnVector then
        return vector(
            r[1],
            r[2],
            r[3])
    end

    return r
end

function lua_matrix:__eq(mat)
    local m = self.m
    local n = self.n

    if m ~= mat.m or n ~= mat.n then
        return false
    end

    local curData = self
    local matData = mat

    for i=1,m*n do
        if curData[i] ~= matData[i] then
            return false
        end
    end

    return true
end

function lua_matrix:__tostring()
    local s = ''
    for l=1,self.m do
        for c=1,self.n do
            s = s .. string.format('%.2f', self[self:ref(l,c)])
            if c < self.m then
                s = s .. ', '
            end
        end
        if l < self.n then
            s = s .. NL
        end
    end
    return s
end

function lua_matrix.random()
    local m = lua_matrix()
    for i=1,16 do
        m[i] = random(100)
    end
    return m
end

ut:add('matrix', function (lib)
        local m = lua_matrix()
        assert(m == m)
        assert(lua_matrix():__eq(lua_matrix()))

        local function assertMatrixIdentity(m)    
            for i=1,16 do
                if i == 1 or i == 6 or i == 11 or i == 16 then
                    assert(m[i] == 1)
                else
                    assert(m[i] == 0)
                end
            end
        end

        assertMatrixIdentity(lua_matrix())

        translate(1, 2, 3)
        local m = lua_matrix():translate(1, 2, 3)

--    assert(m  == modelMatrix())
    end)
