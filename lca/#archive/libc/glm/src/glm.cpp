#define GLM_ENABLE_EXPERIMENTAL

#include <stdio.h>
#include <string>

#include <glm/glm.hpp>
#include <glm/gtx/transform.hpp>
#include <glm/gtc/noise.hpp>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

extern "C" {
    EXPORT glm::vec2* vec2_create(glm::vec2 v_) {
        float* v = new float[2];
        memcpy(v, &v_, sizeof(float[2]));
        return (glm::vec2*)v;
    }

	EXPORT glm::vec2* vec2_new(float value) {
		return vec2_create(glm::vec2(value));
	}

	EXPORT glm::vec2* vec2_clone(glm::vec2* v) {
		return vec2_create(*v);
	}
    
    EXPORT glm::vec2* vec2_random() {
        glm::vec2 v = glm::vec2(0);
        for(int i=0; i<=1; ++i) {
            v[i] = (float)(rand() * 100.);
		}
		return vec2_create(v);
	}
    
    EXPORT void vec2_gc(glm::vec2* m) {
		delete[] (float*)m;
	}

    EXPORT glm::vec2* vec2_set(glm::vec2* v_, float v1, float v2)
	{
		glm::vec2& v = *v_;
		
		v[0] = v1;
		v[1] = v2;
		
		return v_;
	}
    
	EXPORT glm::vec2* vec2_add(glm::vec2* v1, glm::vec2* v2) {
        return vec2_create((*v1)+(*v2));
    }
    
	EXPORT glm::vec2* vec2_sub(glm::vec2* v1, glm::vec2* v2) {
        return vec2_create((*v1)-(*v2));
    }
    
	EXPORT glm::vec2* vec2_mul(glm::vec2* v, float coef) {
        return vec2_create((*v)*coef);
    }
    
	EXPORT glm::vec2* vec2_div(glm::vec2* v, float coef) {
        return vec2_create((*v)/coef);
    }

	EXPORT glm::vec2* vec2_dot(glm::vec2* v1, glm::vec2* v2) {
        return vec2_create((*v1)*(*v2));
    }    
}

extern "C" {
    EXPORT glm::vec3* vec3_create(glm::vec3 v_) {
        float* v = new float[3];
        memcpy(v, &v_, sizeof(float[3]));
        return (glm::vec3*)v;
    }
    
    EXPORT void vec3_gc(glm::vec3* m) {
		delete[] (float*)m;
	}    
}

extern "C" {
    EXPORT glm::vec4* vec4_create(glm::vec4 v_) {
        float* v = new float[4];
        memcpy(v, &v_, sizeof(float[4]));
        return (glm::vec4*)v;
    }
    
    EXPORT void vec4_gc(glm::vec4* m) {
		delete[] (float*)m;
	}    
}

extern "C" {
	EXPORT glm::mat4* matrix_create(glm::mat4 m_) {
		float* m = new float[16];
		memcpy(m, &m_, sizeof(float[16]));
		return (glm::mat4*)m;
	}
	
	EXPORT glm::mat4* matrix_new(float value) {
		return matrix_create(glm::mat4(value));
	}
	
	EXPORT glm::mat4* matrix_clone(glm::mat4* m) {
		return matrix_create(*m);
	}
	
    EXPORT glm::mat4* matrix_random() {
        glm::mat4 m = glm::mat4(0);
        for(int i=0; i<=3; ++i) {
			for(int j=0; j<=3; ++j) {
                m[i][j] = (float)(rand() * 100.);
			}
		}
		return matrix_create(m);
	}
    
	EXPORT void matrix_gc(glm::mat4* m) {
		delete[] (float*)m;
	}
	
	EXPORT glm::mat4* matrix_set(glm::mat4* m_,
		float v1, float v2, float v3, float v4,
		float v5, float v6, float v7, float v8,
		float v9, float v10, float v11, float v12,
		float v13, float v14, float v15, float v16)
	{
		glm::mat4& m = *m_;
		
		m[0][0] = v1;
		m[1][0] = v2;
		m[2][0] = v3;
		m[3][0] = v4;
		 
		m[0][1] = v5;
		m[1][1] = v6;
		m[2][1] = v7;
		m[3][1] = v8;
		 
		m[0][2] = v9;
		m[1][2] = v10;
		m[2][2] = v11;
		m[3][2] = v12;
		 
		m[0][3] = v13;
		m[1][3] = v14;
		m[2][3] = v15;
		m[3][3] = v16;
		
		return m_;
	}

	EXPORT glm::mat4* matrix_translate(glm::mat4* m, float x, float y, float z) {
		return matrix_create(glm::translate(*m, glm::vec3(x, y, z)));
	}

	EXPORT glm::mat4* matrix_rotate(glm::mat4* m, float angle, float x, float y, float z) {
		return matrix_create(glm::rotate(*m, glm::radians(angle), glm::vec3(x, y, z)));
	}

	EXPORT glm::mat4* matrix_scale(glm::mat4* m, float x, float y, float z) {
		return matrix_create(glm::scale(*m, glm::vec3(x, y, z)));
	}
	
    EXPORT glm::mat4* matrix_transpose(glm::mat4* m) {
		return matrix_create(glm::transpose(*m));
	}
    
    EXPORT glm::mat4* matrix_inverse(glm::mat4* m) {
		return matrix_create(glm::inverse(*m));
	}
    
	EXPORT glm::mat4* matrix_mul(glm::mat4* m1, glm::mat4* m2) {
		return matrix_create((*m1) * (*m2));
	}
    
    EXPORT glm::vec4* matrix_mul_vec(glm::mat4* m, float x, float y, float z) {
        return vec4_create((*m) * glm::vec4(x, y, z, 1));
    }
	
	EXPORT int matrix_eq(glm::mat4* m1, glm::mat4* m2) {
		for(int i=0; i<=3; ++i) {
			for(int j=0; j<=3; ++j) {
				if (m1[i][j] != m2[i][j]) {
					return 1;
				}
			}
		}
		return 0;
	}
}

extern "C" {    
    EXPORT float perlin2d(float x, float y) {
        return glm::perlin(glm::vec2(x, y));
    }
    
    EXPORT float perlin3d(float x, float y, float z) {
        return glm::perlin(glm::vec3(x, y, z));
    }
    
    EXPORT float perlin4d(float x, float y, float z, float w) {
        return glm::perlin(glm::vec4(x, y, z, w));
    }
}
