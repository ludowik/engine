ffi.cdef[[    
    typedef union vec4 {
        struct {
            float x;
            float y;
            float z;
            float w;
        };
        float data[4];
	} vec4;
    
    typedef struct matrix {
		float data[16];
	} matrix;
	
	matrix* matrix_new(float v);
	matrix* matrix_clone(matrix* m);
	matrix* matrix_random();
	
	void matrix_gc(matrix* m);
	
	matrix* matrix_set(matrix* m,
		float v1, float v2, float v3, float v4,
		float v5, float v6, float v7, float v8,
		float v9, float v10, float v11, float v12,
		float v13, float v14, float v15, float v16);
	
	matrix* matrix_translate(matrix* m, float x, float y, float z);
	matrix* matrix_rotate(matrix* m, float angle, float x, float y, float z);
	matrix* matrix_scale(matrix* m, float x, float y, float z);
	matrix* matrix_transpose(matrix* m);
	matrix* matrix_inverse(matrix* m);
	matrix* matrix_mul(matrix*, matrix*);
    vec4* matrix_mul_vec(matrix*, float, float, float);
    
    int matrix_eq(matrix*, matrix*);
    
    double getHeight(double x, double z);
    
    float perlin2d(float x, float y);
    float perlin3d(float x, float y, float z);
    float perlin4d(float x, float y, float z, float w);
]]

glm_matrix = class('matrix')
matrix = glm_matrix

function glm_matrix.setup()
end

function glm_matrix:init(...)    
    local args = {...}
    if type(args[1]) == 'cdata' then
        self.matrix = args[1]
    else
        self.matrix = ffi.gc(glm.matrix_new(1), glm.matrix_gc)
        if #args == 16 then
            glm.matrix_set(self.matrix, ...)
        end
    end
end

glm_matrix.__index = function (tbl, key)
        if type(key) == 'number' then
            return tbl.matrix.data[key-1]
        else
            return rawget(glm_matrix, key)
        end
    end

glm_matrix.__newindex = function (tbl, key, value)
        if type(key) == 'number' then
            tbl.matrix.data[key-1] = value
        else
            rawset(tbl, key, value)
        end
    end

function glm_matrix.random()
    return matrix(ffi.gc(glm.matrix_random(), glm.matrix_gc))
end

function glm_matrix:clone()
    return matrix(glm.matrix_clone(self.matrix))
end

function glm_matrix:set(...)
    glm.matrix_set(self.matrix, ...)
end

function glm_matrix:translate(x, y, z)
    x = x or 0
    y = y or 0
    z = z or 0
    return matrix(glm.matrix_translate(self.matrix, x, y, z))
end

function glm_matrix:scale(x, y, z)
    x = x or 1
    y = y or x
    z = z or x
    return matrix(glm.matrix_scale(self.matrix, x, y, z))
end

function glm_matrix:rotate(angle, x, y, z)
    x = x or 0
    y = y or 0
    z = z or 1
    return matrix(glm.matrix_rotate(self.matrix, angle, x, y, z)) -- angle in deg
end

function glm_matrix:geti(i) 
    assert(false)
end

function glm_matrix:seti(i) 
    assert(false)
end

function glm_matrix:transpose()
    return matrix(glm.matrix_transpose(self.matrix))
end

function glm_matrix:inverse()
    return matrix(glm.matrix_inverse(self.matrix))
end

function glm_matrix.__mul(m1, m2)
    local typ = typeOf(m2)
    if typ == 'vec3' or typ == 'Vector' then
        local v = glm.matrix_mul_vec(m1.matrix, m2.x, m2.y, m2.z)
        return vec3(v.x, v.y, v.z)
    end
    assert(m1.matrix and m2.matrix)
    return matrix(glm.matrix_mul(m1.matrix, m2.matrix))
end

function glm_matrix.__eq(m1, m2)
    return glm.matrix_eq(m1.matrix, m2.matrix)
end

function glm_matrix:__tostring()
    local m = ffi.cast("float*", self.matrix.data)

    local s = ''
    for l=0,3 do
        for c=0,3 do
            s = s .. string.format('%.2f', m[c * 4 + l])
            if c < 3 then
                s = s .. ', '
            end
        end
        if l < 4 then
            s = s .. NL
        end
    end
    return s
end

matrix_index = {
    clone = function (self)
        return glm.matrix_clone(self)
    end,

    set = function (self, ...)
        glm.matrix_set(self, ...)
    end,

    translate = function (self, x, y, z)
        x = x or 0
        y = y or 0
        z = z or 0
        return glm.matrix_translate(self, x, y, z)
    end,

    scale = function (self, x, y, z)
        x = x or 1
        y = y or 1
        z = z or 1
        return glm.matrix_scale(self, x, y, z)
    end,

    rotate = function (self, angle, x, y, z)
        x = x or 0
        y = y or 0
        z = z or 1
        return glm.matrix_rotate(self, angle, x, y, z) -- angle in deg
    end,

    geti = function (self, i) 
        assert(false)
    end,

    seti = function (self, i) 
        assert(false)
    end,

    transpose = function (self)
        return glm.matrix_transpose(self)
    end,

    inverse = function (self)
        return glm.matrix_inverse(self)
    end,

    __mul = function (m1, m2)
        if typeOf(m2) == 'vec3' then
            local v = glm.matrix_mul_vec(m1, m2.x, m2.y, m2.z)
            return vec3(v.x, v.y, v.z)
        end
        return glm.matrix_mul(m1, m2)
    end,

    __eq = function (a,b)
        local r = glm.matrix_eq(a, b)
        return r
    end,

    __tostring = function (self)
        local m = ffi.cast("float*", self)

        local s = ''
        for l=0,3 do
            for c=0,3 do
                s = s .. string.format('%.2f', m[c * 4 + l])
                if c < 3 then
                    s = s .. ', '
                end
            end
            if l < 4 then
                s = s .. NL
            end
        end
        return s
    end
}
