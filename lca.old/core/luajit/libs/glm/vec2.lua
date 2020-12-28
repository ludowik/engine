ffi.cdef[[
    typedef union vec2 {
        struct {
            float x;
            float y;
        };
        float values[2];
	} vec2;
	
	vec2* vec2_new(float v);
	vec2* vec2_clone(vec2* m);
	vec2* vec2_random();
	
	void vec2_gc(vec2* m);
	
	vec2* vec2_set(vec2* m, float v1, float v2);
	
	vec2* vec2_add(vec2*, vec2*);
	vec2* vec2_sub(vec2*, vec2*);
	vec2* vec2_mul(vec2*, float);
	vec2* vec2_div(vec2*, float);
    
	vec2* vec2_dot(vec2*, vec2*);
    
    int vec2_eq(vec2*, vec2*);
]]

glm_vec2 = class()

function glm_vec2:init(v)
    return ffi.gc(glm.vec2_new(v or 1), glm.vec2_gc)
end

function glm_vec2.random()
    return ffi.gc(glm.vec2_random(), glm.vec2_gc)
end

vec2_index = {
    clone = glm.vec2_clone,
    set = glm.vec2_set,

    __eq = function (a,b)
        local r = glm.vec2_eq(a, b)
        return r
    end,

    __tostring = function (self)
        local v = ffi.cast("float*", self)
        local s = string.format('%.2f', v.x)..','..string.format('%.2f', v.y)
        return s
    end
}

vec2_mt = ffi.metatype('vec2', {
        __add = glm.vec2_add,
        __sub = glm.vec2_sub,
        __div = glm.vec2_div,

        __mul = function (p, coef)
            if type(p) == 'number' then
                coef, p = p, coef
            end

            if type(coef) == 'number' then
                return glm.vec2_mul(p, coef)
            end

            return p:dot(coef)
        end,

        __index = function (...)
            return vec2_index
        end
    })
