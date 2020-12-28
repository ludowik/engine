local matrix = class('matrix')

ffi.cdef[[
    typedef struct matrix {
        float datamatrix[16];
        int n;
        int m;
	} matrix;
]]

matrixct = ffi.typeof('matrix')
matrixmt = ffi.metatype(matrixct, matrix)

local translateMatrix, scaleMatrix, rotateMatrix

function matrix.setup()
    matrix.className = 'matrix'

    translateMatrix = matrix()
    scaleMatrix = matrix()
    rotateMatrix = matrix()
end

function matrix.__new(k)
    return ffi.new(matrixct)
end

function matrix.__len(self)
    return self.m * self.n
end

matrix.properties.get.index = function (self, index) return self.datamatrix[index-1] end
matrix.properties.set.index = function (self, index, value) self.datamatrix[index-1] = value end

function matrix:init(...)
    local args = {...}
    local nargs = #args
    if nargs == 2 then
        self:create(args[1], args[2])

    elseif nargs == 0 then
        self:create(4, 4)
        local val = args[1] or 1
        self.datamatrix[ 1-1] = val
        self.datamatrix[ 6-1] = val
        self.datamatrix[11-1] = val
        self.datamatrix[16-1] = val

    elseif nargs == 16 then
        self:create(4, 4)
        self:set(...)

    elseif nargs == 4 then
        self:create(4, 1)
        self:set(...)

    else
        assert()
    end

    return self
end

function matrix:clone()
    local m = matrix()

    local mxn = self.m * self.n
    for i=1,mxn do
        m.datamatrix[i-1] = self.datamatrix[i-1]
    end
    return m
end

function matrix:ref(l, c)
    return (l - 1) * self.n + c
end

function matrix:create(m, n)
    self.m = m
    self.n = n

    local mxn = self.m * self.n
    for i=1,mxn do
        self.datamatrix[i-1] = 0
    end
end

--function matrix:set(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16)
function matrix:set(...)
    local args = {...}

    local default = args[1] or 0

    local mxn = self.m * self.n
    assert(#args == mxn)

    for i=1,mxn do
        self.datamatrix[i-1] = args[i] or default
    end
end

function matrix:scale(x, y, z)
    x = x or 1
    y = y or x
    z = z or x

    scaleMatrix:set(
        x,0,0,0,
        0,y,0,0,
        0,0,z,0,
        0,0,0,1)

    return self * scaleMatrix
end

function matrix:translate(x, y, z)    
    translateMatrix.datamatrix[ 4-1] = x or 0
    translateMatrix.datamatrix[ 8-1] = y or 0
    translateMatrix.datamatrix[12-1] = z or 0

    return self * translateMatrix
end

function matrix:transpose()
    local m = matrix()
    for x=0,3 do
        for y=0,3 do
            m[1+y*4+x] = self[1+x*4+y]
        end
    end

    return m
end

local cos = math.cos
local sin = math.sin

function matrix:rotate(angle, x, y, z)
    local c = cos(rad(angle))
    local s = sin(rad(angle))

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

function matrix:__mul(b)
--    assert(typeof(b) == 'matrix')

    local res = matrix(self.m, b.n)
    self:mul(b, res)

    return res
end

function matrix:mul(b, r)
--    assert(typeof(b) == 'matrix')
--    assert(typeof(r) == 'matrix')
    
    local a = self

    local m = a.m
    local n = a.n -- or b.m

    local p = b.n

    r = r or matrix(m, p)    

    local val, ln

    local ii = 0

    for l=0,m-1 do
        ln = l * n
        for c=0,p-1 do
            val = 0
            for i=0,n-1 do
                val = (val +
                    a.datamatrix[ln + i] *
                    b.datamatrix[i * p + c]
                )
            end

            r.datamatrix[ii] = val

            ii = ii + 1
        end
    end

    return r
end

function matrix:mulVector(b)
    b = matrix(b.x, b.y, b.z or 0, 1)

    local res = matrix(self.m, b.n)
    self:mul(b, res)

    return vec3(
        res[1],
        res[2],
        res[3])
end

function matrix:__eq(mat)
    local m = self.m
    local n = self.n

    if m ~= mat.m or n ~= mat.n then
        return false
    end

    for i=1,m*n do
        if self[i] ~= mat[i] then
            return false
        end
    end

    return true
end

function matrix:__tostring()
    local s = ''
    for l=1,self.m do
        for c=1,self.n do
            s = s .. string.format('%.4f', self[self:ref(l,c)])
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

function matrix.random()
    local m = matrix()
    for i=1,16 do
        m[i] = random(100)
    end
    return m
end

function matrix.test()
    local m = matrix()
    assert(m == m)
    assert(matrix():__eq(matrix()))

    local function assertMatrixIdentity(m)    
        for i=1,16 do
            if i == 1 or i == 6 or i == 11 or i == 16 then
                assert(m[i] == 1)
            else
                assert(m[i] == 0)
            end
        end
    end

    assertMatrixIdentity(matrix())

    translate(1, 2, 3)
    local m = matrix():translate(1, 2, 3)
    
    m = matrix.random()
    assert(m:transpose():transpose() == m)
end
