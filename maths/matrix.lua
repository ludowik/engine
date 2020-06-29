ffi = require 'ffi'

ffi.cdef [[
    typedef union matrix {
        struct {
            float i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15;
        };
        float values[16];
	} matrix;
]]

local mt = {}

mt.__index = function (matrix, key)
    if type(key) == 'number' then
        return matrix.values[key-1]
    else
        return rawget(mt, key)
    end
end

-- n rows x m columns
function mt.__tostring(self)
    local str = ''
    local i = 0
    for n=0,3 do
        str = str..'n'..n..':'
        for m=0,3 do
            str = str..self.values[i]..','
            i = i + 1
        end
        str = str..NL
    end
    return str
end

function mt.set(self, ...)
    self.values = {...}
end

function mt.scale(...)
    local m2 = matrix()
    local values = m2.values

    function mt.scale(m1, sx, sy, sz, res)
        values[0] = sx
        values[5] = sy
        values[10] = sz or 1
        return m1:__mul(m2, res)
    end

    return mt.scale(...)
end

function mt.translate(...)
    local m2 = matrix()
    local values = m2.values

    function mt.translate(m1, x, y, z, res)
        values[3] = x
        values[7] = y
        values[11] = z or 0
        return m1:__mul(m2, res)
    end

    return mt.translate(...)
end

function mt.rotate(...)
    local m2x = matrix()
    local m2y = matrix()
    local m2z = matrix()

    local c, s
    function mt.rotate(m1, angle, x, y, z, res)
        c = math.cos(math.rad(angle))
        s = math.sin(math.rad(angle))

        if x == 1 then
            m2x.i5 = c
            m2x.i6 = -s
            m2x.i9 = s
            m2x.i10 = c
            return m1:__mul(m2x, res)
--            m2:set(
--                1,0,0,0,
--                0,c,-s,0,
--                0,s,c,0,
--                0,0,0,1)

        elseif y == 1 then
            m2y.i0 = c
            m2y.i2 = s
            m2y.i8 = -s
            m2y.i10 = c
            return m1:__mul(m2y, res)
--            m2:set(
--                c,0,s,0,
--                0,1,0,0,
--                -s,0,c,0,
--                0,0,0,1)

        else -- z == 1 (default)
            m2z.i0 = c
            m2z.i1 = -s
            m2z.i4 = s
            m2z.i5 = c
            return m1:__mul(m2z, res)
--            m2:set(
--                c,-s,0,0,
--                s,c,0,0,
--                0,0,1,0,
--                0,0,0,1)

        end

--        return m1:__mul(m2, res)
    end

    return mt.rotate(...)
end

function mt.__mul(m1, m2, res)
    res = res or meta_matrix()

    local value

    local values1 = m1.values
    local values2 = m2.values

    local n4, j = 0, 0

    for n=0,3 do
        n4 = n * 4

        for m=0,3 do

            value = 0
            for i=0,3 do
                value = value + values1[n4 + i] * values2[i * 4 + m]
            end

            res.values[j] = value
            
            j = j + 1

        end
    end

    return res
end

function mt.tobytes(m1)
    return m1.values
end

meta_matrix = ffi.metatype('matrix', mt)

function matrix(i0, ...)
    local mat
    if i0 == nil then
        mat = meta_matrix()
        mat.i0 = 1
        mat.i5 = 1
        mat.i10 = 1
        mat.i15 = 1
    else
        mat = meta_matrix(i0, ...)
    end
    return mat
end
